package com.shopsphere.controller;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shopsphere.dto.WishlistItemRequest;
import com.shopsphere.dto.WishlistResponse;
import com.shopsphere.service.WishlistService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/wishlist")
@RequiredArgsConstructor
public class WishlistController {

    private final WishlistService wishlistService;

    @GetMapping
    public WishlistResponse getWishlist(Authentication authentication) {
        return wishlistService.getWishlist(authentication.getName());
    }

    @PostMapping("/items")
    public WishlistResponse addItem(Authentication authentication, @Valid @RequestBody WishlistItemRequest request) {
        return wishlistService.addItem(authentication.getName(), request.getProductId());
    }

    @DeleteMapping("/items/{productId}")
    public WishlistResponse removeItem(Authentication authentication, @PathVariable Long productId) {
        return wishlistService.removeItem(authentication.getName(), productId);
    }
}
