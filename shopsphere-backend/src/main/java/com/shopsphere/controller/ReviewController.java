package com.shopsphere.controller;

import org.springframework.http.HttpStatus;
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

import com.shopsphere.dto.ReviewListResponse;
import com.shopsphere.dto.ReviewRequest;
import com.shopsphere.dto.ReviewResponse;
import com.shopsphere.service.ReviewService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/reviews")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @GetMapping("/products/{productId}")
    public ReviewListResponse getForProduct(@PathVariable Long productId) {
        return reviewService.getForProduct(productId);
    }

    @PostMapping("/products/{productId}")
    public ResponseEntity<ReviewResponse> create(Authentication authentication, @PathVariable Long productId,
                                                  @Valid @RequestBody ReviewRequest request) {
        ReviewResponse response = reviewService.create(authentication.getName(), productId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PutMapping("/products/{productId}")
    public ReviewResponse update(Authentication authentication, @PathVariable Long productId,
                                  @Valid @RequestBody ReviewRequest request) {
        return reviewService.update(authentication.getName(), productId, request);
    }

    @DeleteMapping("/{reviewId}")
    public ResponseEntity<Void> delete(Authentication authentication, @PathVariable Long reviewId) {
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"));
        reviewService.delete(authentication.getName(), isAdmin, reviewId);
        return ResponseEntity.noContent().build();
    }
}
