package com.shopsphere.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shopsphere.dto.CheckoutRequest;
import com.shopsphere.dto.OrderItemResponse;
import com.shopsphere.dto.OrderResponse;
import com.shopsphere.dto.ShippingAddressRequest;
import com.shopsphere.dto.ShippingAddressResponse;
import com.shopsphere.entity.Cart;
import com.shopsphere.entity.CartItem;
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

    private final OrderRepository orderRepository;
    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final InventoryService inventoryService;

    @Transactional
    public OrderResponse checkout(String email, CheckoutRequest request) {
        User user = findUserOrThrow(email);

        Cart cart = cartRepository.findByUserId(user.getId())
                .filter(c -> !c.getItems().isEmpty())
                .orElseThrow(() -> new InvalidOrderStateException("Your cart is empty"));

        Order order = buildOrderShell(user, request.getShippingAddress());
        BigDecimal total = BigDecimal.ZERO;

        for (CartItem cartItem : cart.getItems()) {
            Product product = cartItem.getProduct();

            inventoryService.adjustQuantity(product.getId(), -cartItem.getQuantity());

            order.getItems().add(OrderItem.builder()
                    .order(order)
                    .product(product)
                    .productName(product.getName())
                    .unitPrice(product.getPrice())
                    .quantity(cartItem.getQuantity())
                    .build());

            total = total.add(product.getPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity())));
        }

        order.setTotalAmount(total);
        Order saved = orderRepository.save(order);

        cart.getItems().clear();
        cartRepository.save(cart);

        return toResponse(saved);
    }

    public List<OrderResponse> getMyOrders(String email) {
        User user = findUserOrThrow(email);
        return orderRepository.findByUserIdOrderByCreatedAtDesc(user.getId()).stream()
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

        if (order.getStatus() == OrderStatus.CANCELLED) {
            throw new InvalidOrderStateException("Order is already cancelled");
        }

        order.setStatus(OrderStatus.CANCELLED);
        for (OrderItem item : order.getItems()) {
            inventoryService.adjustQuantity(item.getProduct().getId(), item.getQuantity());
        }

        return toResponse(orderRepository.save(order));
    }

    private Order buildOrderShell(User user, ShippingAddressRequest address) {
        return Order.builder()
                .user(user)
                .status(OrderStatus.PENDING)
                .totalAmount(BigDecimal.ZERO)
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
                .status(order.getStatus().name())
                .totalAmount(order.getTotalAmount())
                .shippingAddress(address)
                .items(items)
                .createdAt(order.getCreatedAt())
                .updatedAt(order.getUpdatedAt())
                .build();
    }
}
