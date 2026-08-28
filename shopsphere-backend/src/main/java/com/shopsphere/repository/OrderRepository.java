package com.shopsphere.repository;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.shopsphere.entity.Order;
import com.shopsphere.entity.OrderStatus;

public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findByUserIdOrderByCreatedAtDesc(Long userId);

    boolean existsByUserIdAndStatusNotAndItems_Product_Id(Long userId, OrderStatus status, Long productId);

    long countByStatus(OrderStatus status);

    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status = :status")
    BigDecimal sumTotalAmountByStatus(@Param("status") OrderStatus status);
}
