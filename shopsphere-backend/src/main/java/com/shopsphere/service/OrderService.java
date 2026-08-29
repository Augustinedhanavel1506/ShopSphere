package com.shopsphere.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.EnumMap;
import java.util.EnumSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shopsphere.dto.CheckoutRequest;
import com.shopsphere.dto.OrderItemResponse;
import com.shopsphere.dto.OrderResponse;
import com.shopsphere.dto.OrderStatusUpdateRequest;
import com.shopsphere.dto.ShippingAddressRequest;
import com.shopsphere.dto.ShippingAddressResponse;
import com.shopsphere.entity.Address;
import com.shopsphere.entity.Cart;
import com.shopsphere.entity.CartItem;
import com.shopsphere.entity.Coupon;
import com.shopsphere.entity.InventoryTransactionReason;
import com.shopsphere.entity.Order;
import com.shopsphere.entity.OrderItem;
import com.shopsphere.entity.OrderStatus;
import com.shopsphere.entity.Product;
import com.shopsphere.entity.User;
import com.shopsphere.exception.InvalidOrderStateException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.CartRepository;
import com.shopsphere.repository.OrderRepository;
import com.shopsphere.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService {

    private static final Map<OrderStatus, Set<OrderStatus>> ALLOWED_TRANSITIONS = new EnumMap<>(OrderStatus.class);

    static {
        ALLOWED_TRANSITIONS.put(OrderStatus.PAID, EnumSet.of(OrderStatus.CONFIRMED, OrderStatus.CANCELLED));
        ALLOWED_TRANSITIONS.put(OrderStatus.CONFIRMED, EnumSet.of(OrderStatus.PROCESSING, OrderStatus.CANCELLED));
        ALLOWED_TRANSITIONS.put(OrderStatus.PROCESSING, EnumSet.of(OrderStatus.SHIPPED, OrderStatus.CANCELLED));
        ALLOWED_TRANSITIONS.put(OrderStatus.SHIPPED, EnumSet.of(OrderStatus.DELIVERED));
    }

    private final OrderRepository orderRepository;
    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final InventoryService inventoryService;
    private final CouponService couponService;
    private final NotificationService notificationService;
    private final AddressService addressService;

    @Value("${app.tax.rate}")
    private double taxRate;

    @Transactional
    public OrderResponse checkout(String email, CheckoutRequest request) {
        User user = findUserOrThrow(email);

        Cart cart = cartRepository.findByUserId(user.getId())
                .filter(c -> c.getItems().stream().anyMatch(item -> !Boolean.TRUE.equals(item.getSaved())))
                .orElseThrow(() -> new InvalidOrderStateException("Your cart is empty"));

        List<CartItem> activeItems = cart.getItems().stream()
                .filter(item -> !Boolean.TRUE.equals(item.getSaved()))
                .toList();

        ShippingAddressRequest shippingAddress = resolveShippingAddress(email, request);
        Order order = buildOrderShell(user, shippingAddress);
        BigDecimal total = BigDecimal.ZERO;

        for (CartItem cartItem : activeItems) {
            Product product = cartItem.getProduct();

            inventoryService.adjustQuantity(product.getId(), -cartItem.getQuantity(), InventoryTransactionReason.ORDER_PLACED);

            order.getItems().add(OrderItem.builder()
                    .order(order)
                    .product(product)
                    .productName(product.getName())
                    .unitPrice(product.getPrice())
                    .quantity(cartItem.getQuantity())
                    .build());

            total = total.add(product.getPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity())));
        }

        BigDecimal discount = BigDecimal.ZERO;
        if (request.getCouponCode() != null && !request.getCouponCode().isBlank()) {
            Coupon coupon = couponService.validate(request.getCouponCode(), total);
            discount = couponService.calculateDiscount(coupon, total);
            couponService.recordRedemption(coupon);
            order.setCouponCode(coupon.getCode());
        }

        BigDecimal afterDiscount = total.subtract(discount);
        BigDecimal tax = afterDiscount.multiply(BigDecimal.valueOf(taxRate)).setScale(2, RoundingMode.HALF_UP);

        order.setDiscountAmount(discount);
        order.setTaxAmount(tax);
        order.setTotalAmount(afterDiscount.add(tax));
        Order saved = orderRepository.save(order);

        cart.getItems().removeIf(item -> !Boolean.TRUE.equals(item.getSaved()));
        cartRepository.save(cart);

        notificationService.sendOrderConfirmationEmail(user.getEmail(), saved.getId(), saved.getTotalAmount());

        return toResponse(saved);
    }

    public List<OrderResponse> getMyOrders(String email) {
        User user = findUserOrThrow(email);
        return orderRepository.findByUserIdOrderByCreatedAtDesc(user.getId()).stream()
                .map(this::toResponse)
                .toList();
    }

    public List<OrderResponse> getAllOrders(OrderStatus status) {
        List<Order> orders = status != null
                ? orderRepository.findByStatusOrderByCreatedAtDesc(status)
                : orderRepository.findAllByOrderByCreatedAtDesc();
        return orders.stream().map(this::toResponse).toList();
    }

    public List<OrderResponse> getRecentOrders(int limit) {
        return orderRepository.findAll(PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "createdAt")))
                .stream()
                .map(this::toResponse)
                .toList();
    }

    public List<OrderResponse> getRecentOrders(int limit, LocalDateTime from, LocalDateTime to) {
        return orderRepository.findByCreatedAtBetweenOrderByCreatedAtDesc(from, to, PageRequest.of(0, limit)).stream()
                .map(this::toResponse)
                .toList();
    }

    public OrderResponse getById(String email, boolean isAdmin, Long orderId) {
        Order order = findOrderOrThrow(orderId);
        requireOwnerOrAdmin(order, email, isAdmin, "view");
        return toResponse(order);
    }

    @Transactional
    public OrderResponse cancelOrder(String email, boolean isAdmin, Long orderId) {
        Order order = findOrderOrThrow(orderId);
        requireOwnerOrAdmin(order, email, isAdmin, "cancel");

        if (order.getStatus() != OrderStatus.PENDING) {
            throw new InvalidOrderStateException(
                    "Only pending orders can be cancelled; this order is " + order.getStatus());
        }

        order.setStatus(OrderStatus.CANCELLED);
        for (OrderItem item : order.getItems()) {
            inventoryService.adjustQuantity(item.getProduct().getId(), item.getQuantity(), InventoryTransactionReason.ORDER_CANCELLED);
        }

        Order saved = orderRepository.save(order);
        notificationService.sendOrderCancelledEmail(order.getUser().getEmail(), saved.getId());

        return toResponse(saved);
    }

    @Transactional
    public OrderResponse updateStatus(Long orderId, OrderStatusUpdateRequest request) {
        Order order = findOrderOrThrow(orderId);
        OrderStatus current = order.getStatus();
        OrderStatus target = request.getStatus();

        Set<OrderStatus> allowed = ALLOWED_TRANSITIONS.getOrDefault(current, Set.of());
        if (!allowed.contains(target)) {
            throw new InvalidOrderStateException("Cannot transition order from " + current + " to " + target);
        }

        if (target == OrderStatus.CANCELLED) {
            for (OrderItem item : order.getItems()) {
                inventoryService.adjustQuantity(item.getProduct().getId(), item.getQuantity(), InventoryTransactionReason.ORDER_CANCELLED);
            }
        }

        if (target == OrderStatus.SHIPPED) {
            order.setTrackingNumber(request.getTrackingNumber());
            order.setCarrier(request.getCarrier());
        }

        order.setStatus(target);
        Order saved = orderRepository.save(order);

        notificationService.sendOrderStatusUpdateEmail(order.getUser().getEmail(), saved.getId(), target.name());

        return toResponse(saved);
    }

    private ShippingAddressRequest resolveShippingAddress(String email, CheckoutRequest request) {
        if (request.getAddressId() != null) {
            Address address = addressService.findOwnedOrThrow(email, request.getAddressId());
            ShippingAddressRequest resolved = new ShippingAddressRequest();
            resolved.setFullName(address.getFullName());
            resolved.setPhone(address.getPhone());
            resolved.setLine1(address.getLine1());
            resolved.setLine2(address.getLine2());
            resolved.setCity(address.getCity());
            resolved.setState(address.getState());
            resolved.setPostalCode(address.getPostalCode());
            resolved.setCountry(address.getCountry());
            return resolved;
        }

        if (request.getShippingAddress() != null) {
            return request.getShippingAddress();
        }

        throw new InvalidOrderStateException("Either addressId or shippingAddress must be provided");
    }

    private Order buildOrderShell(User user, ShippingAddressRequest address) {
        return Order.builder()
                .user(user)
                .status(OrderStatus.PENDING)
                .totalAmount(BigDecimal.ZERO)
                .discountAmount(BigDecimal.ZERO)
                .taxAmount(BigDecimal.ZERO)
                .shippingFullName(address.getFullName())
                .shippingPhone(address.getPhone())
                .shippingLine1(address.getLine1())
                .shippingLine2(address.getLine2())
                .shippingCity(address.getCity())
                .shippingState(address.getState())
                .shippingPostalCode(address.getPostalCode())
                .shippingCountry(address.getCountry())
                .build();
    }

    private void requireOwnerOrAdmin(Order order, String email, boolean isAdmin, String action) {
        if (!isAdmin && !order.getUser().getEmail().equalsIgnoreCase(email)) {
            throw new AccessDeniedException("You can only " + action + " your own orders");
        }
    }

    private Order findOrderOrThrow(Long orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with id " + orderId));
    }

    private User findUserOrThrow(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + email));
    }

    private OrderResponse toResponse(Order order) {
        List<OrderItemResponse> items = order.getItems().stream()
                .map(item -> OrderItemResponse.builder()
                        .id(item.getId())
                        .productId(item.getProduct().getId())
                        .productName(item.getProductName())
                        .unitPrice(item.getUnitPrice())
                        .quantity(item.getQuantity())
                        .lineTotal(item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                        .build())
                .toList();

        ShippingAddressResponse address = new ShippingAddressResponse(
                order.getShippingFullName(),
                order.getShippingPhone(),
                order.getShippingLine1(),
                order.getShippingLine2(),
                order.getShippingCity(),
                order.getShippingState(),
                order.getShippingPostalCode(),
                order.getShippingCountry());

        return OrderResponse.builder()
                .id(order.getId())
                .customerEmail(order.getUser().getEmail())
                .status(order.getStatus().name())
                .subtotal(order.getTotalAmount().subtract(order.getTaxAmount()).add(order.getDiscountAmount()))
                .couponCode(order.getCouponCode())
                .discountAmount(order.getDiscountAmount())
                .taxAmount(order.getTaxAmount())
                .totalAmount(order.getTotalAmount())
                .trackingNumber(order.getTrackingNumber())
                .carrier(order.getCarrier())
                .shippingAddress(address)
                .items(items)
                .createdAt(order.getCreatedAt())
                .updatedAt(order.getUpdatedAt())
                .build();
    }
}
