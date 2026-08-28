package com.shopsphere.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.DashboardSummaryResponse;
import com.shopsphere.dto.LowStockProductResponse;
import com.shopsphere.entity.OrderStatus;
import com.shopsphere.repository.InventoryRepository;
import com.shopsphere.repository.OrderRepository;
import com.shopsphere.repository.ProductRepository;
import com.shopsphere.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminDashboardService {

    private static final String CUSTOMER_ROLE = "CUSTOMER";

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final InventoryRepository inventoryRepository;

    public DashboardSummaryResponse getSummary(int lowStockThreshold) {
        return new DashboardSummaryResponse(
                orderRepository.sumTotalAmountByStatus(OrderStatus.PAID),
                orderRepository.count(),
                orderRepository.countByStatus(OrderStatus.PENDING),
                orderRepository.countByStatus(OrderStatus.PAID),
                orderRepository.countByStatus(OrderStatus.CANCELLED),
                userRepository.countByRoles_Name(CUSTOMER_ROLE),
                productRepository.count(),
                inventoryRepository.findByQuantityLessThanEqual(lowStockThreshold).size());
    }

    public List<LowStockProductResponse> getLowStockProducts(int threshold) {
        return inventoryRepository.findByQuantityLessThanEqual(threshold).stream()
                .map(inventory -> new LowStockProductResponse(
                        inventory.getProduct().getId(),
                        inventory.getProduct().getName(),
                        inventory.getQuantity()))
                .toList();
    }
}
