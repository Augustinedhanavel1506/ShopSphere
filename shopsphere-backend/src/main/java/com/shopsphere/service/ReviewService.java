package com.shopsphere.service;

import java.util.List;
import java.util.Optional;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import com.shopsphere.dto.ReviewListResponse;
import com.shopsphere.dto.ReviewRequest;
import com.shopsphere.dto.ReviewResponse;
import com.shopsphere.entity.OrderStatus;
import com.shopsphere.entity.Product;
import com.shopsphere.entity.Review;
import com.shopsphere.entity.User;
import com.shopsphere.exception.DuplicateResourceException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.OrderRepository;
import com.shopsphere.repository.ProductRepository;
import com.shopsphere.repository.ReviewRepository;
import com.shopsphere.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;

    public ReviewListResponse getForProduct(Long productId) {
        List<Review> reviews = reviewRepository.findByProductId(productId);

        double average = reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);

        return ReviewListResponse.builder()
                .averageRating(Math.round(average * 10.0) / 10.0)
                .totalReviews(reviews.size())
                .reviews(reviews.stream().map(this::toResponse).toList())
                .build();
    }

    public ReviewResponse create(String email, Long productId, ReviewRequest request) {
        User user = findUserOrThrow(email);
        Product product = findProductOrThrow(productId);

        if (reviewRepository.existsByProductIdAndUserId(productId, user.getId())) {
            throw new DuplicateResourceException("You have already reviewed this product; use PUT to update it");
        }

        boolean hasPurchased = orderRepository.existsByUserIdAndStatusNotAndItems_Product_Id(
                user.getId(), OrderStatus.CANCELLED, productId);
        if (!hasPurchased) {
            throw new AccessDeniedException("You can only review products you have purchased");
        }

        Review review = Review.builder()
                .product(product)
                .user(user)
                .rating(request.getRating())
                .comment(request.getComment())
                .build();

        return toResponse(reviewRepository.save(review));
    }

    public ReviewResponse update(String email, Long productId, ReviewRequest request) {
        User user = findUserOrThrow(email);
        Review review = reviewRepository.findByProductIdAndUserId(productId, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("You have not reviewed this product yet"));

        review.setRating(request.getRating());
        review.setComment(request.getComment());

        return toResponse(reviewRepository.save(review));
    }

    public void delete(String email, boolean isAdmin, Long reviewId) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new ResourceNotFoundException("Review not found with id " + reviewId));

        if (!isAdmin && !review.getUser().getEmail().equalsIgnoreCase(email)) {
            throw new AccessDeniedException("You can only delete your own review");
        }

        reviewRepository.delete(review);
    }

    private User findUserOrThrow(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + email));
    }

    private Product findProductOrThrow(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id " + productId));
    }

    private ReviewResponse toResponse(Review review) {
        String lastName = Optional.ofNullable(review.getUser().getLastName()).orElse("");
        String userName = (review.getUser().getFirstName() + " " + lastName).trim();

        return ReviewResponse.builder()
                .id(review.getId())
                .productId(review.getProduct().getId())
                .userId(review.getUser().getId())
                .userName(userName)
                .rating(review.getRating())
                .comment(review.getComment())
                .createdAt(review.getCreatedAt())
                .updatedAt(review.getUpdatedAt())
                .build();
    }
}
