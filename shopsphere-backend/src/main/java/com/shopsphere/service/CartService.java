package com.shopsphere.service;

import java.math.BigDecimal;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.CartItemRequest;
import com.shopsphere.dto.CartItemResponse;
import com.shopsphere.dto.CartResponse;
import com.shopsphere.entity.Cart;
import com.shopsphere.entity.CartItem;
import com.shopsphere.entity.Product;
import com.shopsphere.entity.User;
import com.shopsphere.exception.InsufficientStockException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.CartRepository;
import com.shopsphere.repository.InventoryRepository;
import com.shopsphere.repository.ProductRepository;
import com.shopsphere.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final InventoryRepository inventoryRepository;

    public CartResponse getCart(String email) {
        return toResponse(getOrCreateCart(email));
    }

    public CartResponse addItem(String email, CartItemRequest request) {
        Cart cart = getOrCreateCart(email);
        Product product = findProductOrThrow(request.getProductId());

        Optional<CartItem> existing = findItem(cart, product.getId());
        int newQuantity = existing.map(CartItem::getQuantity).orElse(0) + request.getQuantity();
        validateStock(product.getId(), newQuantity);

        if (existing.isPresent()) {
            existing.get().setQuantity(newQuantity);
        } else {
            cart.getItems().add(CartItem.builder()
                    .cart(cart)
                    .product(product)
                    .quantity(newQuantity)
                    .build());
        }

        return toResponse(cartRepository.save(cart));
    }

    public CartResponse updateItemQuantity(String email, Long productId, int quantity) {
        Cart cart = getOrCreateCart(email);
        CartItem item = findItem(cart, productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product " + productId + " is not in the cart"));

        validateStock(productId, quantity);
        item.setQuantity(quantity);

        return toResponse(cartRepository.save(cart));
    }

    public CartResponse removeItem(String email, Long productId) {
        Cart cart = getOrCreateCart(email);
        boolean removed = cart.getItems().removeIf(item -> item.getProduct().getId().equals(productId));

        if (!removed) {
            throw new ResourceNotFoundException("Product " + productId + " is not in the cart");
        }

        return toResponse(cartRepository.save(cart));
    }

    public void clearCart(String email) {
        Cart cart = getOrCreateCart(email);
        cart.getItems().clear();
        cartRepository.save(cart);
    }

    private Cart getOrCreateCart(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + email));

        return cartRepository.findByUserId(user.getId())
                .orElseGet(() -> cartRepository.save(Cart.builder().user(user).build()));
    }

    private Optional<CartItem> findItem(Cart cart, Long productId) {
        return cart.getItems().stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .findFirst();
    }

    private Product findProductOrThrow(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id " + productId));
    }

    private void validateStock(Long productId, int requestedQuantity) {
        int available = inventoryRepository.findByProductId(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Inventory not found for product id " + productId))
                .getQuantity();

        if (requestedQuantity > available) {
            throw new InsufficientStockException("Only " + available + " unit(s) of this product are available");
        }
    }

    private CartResponse toResponse(Cart cart) {
        var items = cart.getItems().stream()
                .map(item -> CartItemResponse.builder()
                        .id(item.getId())
                        .productId(item.getProduct().getId())
                        .productName(item.getProduct().getName())
                        .unitPrice(item.getProduct().getPrice())
                        .quantity(item.getQuantity())
                        .lineTotal(item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                        .build())
                .toList();

        int totalItems = items.stream().mapToInt(CartItemResponse::getQuantity).sum();
        BigDecimal totalPrice = items.stream()
                .map(CartItemResponse::getLineTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return CartResponse.builder()
                .id(cart.getId())
                .items(items)
                .totalItems(totalItems)
                .totalPrice(totalPrice)
                .build();
    }
}
