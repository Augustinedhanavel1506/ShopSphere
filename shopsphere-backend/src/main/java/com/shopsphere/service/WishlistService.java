package com.shopsphere.service;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.WishlistItemResponse;
import com.shopsphere.dto.WishlistResponse;
import com.shopsphere.entity.Product;
import com.shopsphere.entity.User;
import com.shopsphere.entity.Wishlist;
import com.shopsphere.entity.WishlistItem;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.ProductRepository;
import com.shopsphere.repository.UserRepository;
import com.shopsphere.repository.WishlistRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WishlistService {

    private final WishlistRepository wishlistRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    public WishlistResponse getWishlist(String email) {
        return toResponse(getOrCreateWishlist(email));
    }

    public WishlistResponse addItem(String email, Long productId) {
        Wishlist wishlist = getOrCreateWishlist(email);

        boolean alreadyPresent = wishlist.getItems().stream()
                .anyMatch(item -> item.getProduct().getId().equals(productId));

        if (!alreadyPresent) {
            Product product = productRepository.findById(productId)
                    .orElseThrow(() -> new ResourceNotFoundException("Product not found with id " + productId));

            wishlist.getItems().add(WishlistItem.builder()
                    .wishlist(wishlist)
                    .product(product)
                    .build());
            wishlistRepository.save(wishlist);
        }

        return toResponse(wishlist);
    }

    public WishlistResponse removeItem(String email, Long productId) {
        Wishlist wishlist = getOrCreateWishlist(email);
        boolean removed = wishlist.getItems().removeIf(item -> item.getProduct().getId().equals(productId));

        if (!removed) {
            throw new ResourceNotFoundException("Product " + productId + " is not in the wishlist");
        }

        return toResponse(wishlistRepository.save(wishlist));
    }

    private Wishlist getOrCreateWishlist(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + email));

        return wishlistRepository.findByUserId(user.getId())
                .orElseGet(() -> wishlistRepository.save(Wishlist.builder().user(user).build()));
    }

    private WishlistResponse toResponse(Wishlist wishlist) {
        var items = wishlist.getItems().stream()
                .map(item -> WishlistItemResponse.builder()
                        .id(item.getId())
                        .productId(item.getProduct().getId())
                        .productName(item.getProduct().getName())
                        .price(item.getProduct().getPrice())
                        .addedAt(item.getAddedAt())
                        .build())
                .toList();

        return WishlistResponse.builder()
                .id(wishlist.getId())
                .items(items)
                .build();
    }
}
