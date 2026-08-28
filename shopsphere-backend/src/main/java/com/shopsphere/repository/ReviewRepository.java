package com.shopsphere.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shopsphere.entity.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByProductId(Long productId);

    Optional<Review> findByProductIdAndUserId(Long productId, Long userId);

    boolean existsByProductIdAndUserId(Long productId, Long userId);
}
