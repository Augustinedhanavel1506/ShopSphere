package com.shopsphere.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
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
    private static final LocalDateTime EARLIEST = LocalDateTime.of(2000, 1, 1, 0, 0);

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final InventoryRepository inventoryRepository;

    public DashboardSummaryResponse getSummary(int lowStockThreshold, LocalDateTime from, LocalDateTime to) {
        return new DashboardSummaryResponse(
                orderRepository.sumTotalAmountByStatusAndCreatedAtBetween(OrderStatus.PAID, from, to),
                orderRepository.countByCreatedAtBetween(from, to),
                orderRepository.countByStatusAndCreatedAtBetween(OrderStatus.PENDING, from, to),
                orderRepository.countByStatusAndCreatedAtBetween(OrderStatus.PAID, from, to),
                orderRepository.countByStatusAndCreatedAtBetween(OrderStatus.CANCELLED, from, to),
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

    /** Resolves a named period (today/week/month/year) or an explicit from/to into a concrete range. */
    public LocalDateTime[] resolveRange(String period, LocalDateTime from, LocalDateTime to) {
        LocalDateTime now = LocalDateTime.now();

        if (period != null) {
            LocalDateTime start = switch (period.toLowerCase()) {
                case "today" -> LocalDate.now().atStartOfDay();
                case "week" -> now.minusDays(7);
                case "month" -> now.minusMonths(1);
                case "year" -> now.minusYears(1);
                default -> EARLIEST;
            };
            return new LocalDateTime[] {start, now};
        }

        return new LocalDateTime[] {from != null ? from : EARLIEST, to != null ? to : now};
    }
}
