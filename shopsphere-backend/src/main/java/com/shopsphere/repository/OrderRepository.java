package com.shopsphere.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shopsphere.entity.Order;
import com.shopsphere.entity.OrderStatus;

public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findByUserIdOrderByCreatedAtDesc(Long userId);

    boolean existsByUserIdAndStatusNotAndItems_Product_Id(Long userId, OrderStatus status, Long productId);
}
