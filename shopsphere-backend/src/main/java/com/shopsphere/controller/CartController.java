package com.shopsphere.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shopsphere.dto.CartItemRequest;
import com.shopsphere.dto.CartResponse;
import com.shopsphere.dto.UpdateCartItemRequest;
import com.shopsphere.service.CartService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @GetMapping
    public CartResponse getCart(Authentication authentication) {
        return cartService.getCart(authentication.getName());
    }

    @PostMapping("/items")
    public CartResponse addItem(Authentication authentication, @Valid @RequestBody CartItemRequest request) {
        return cartService.addItem(authentication.getName(), request);
    }

    @PutMapping("/items/{productId}")
    public CartResponse updateItem(Authentication authentication, @PathVariable Long productId,
                                    @Valid @RequestBody UpdateCartItemRequest request) {
        return cartService.updateItemQuantity(authentication.getName(), productId, request.getQuantity());
    }

    @DeleteMapping("/items/{productId}")
    public CartResponse removeItem(Authentication authentication, @PathVariable Long productId) {
        return cartService.removeItem(authentication.getName(), productId);
    }

    @DeleteMapping
    public ResponseEntity<Void> clearCart(Authentication authentication) {
        cartService.clearCart(authentication.getName());
        return ResponseEntity.noContent().build();
    }
}
