package com.shopsphere.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.DashboardSummaryResponse;
import com.shopsphere.dto.LowStockProductResponse;
import com.shopsphere.dto.RevenueTrendPointResponse;
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

    public Map<String, Long> getOrdersByStatus(LocalDateTime from, LocalDateTime to) {
        Map<String, Long> result = new LinkedHashMap<>();
        for (OrderStatus status : OrderStatus.values()) {
            result.put(status.name(), orderRepository.countByStatusAndCreatedAtBetween(status, from, to));
        }
        return result;
    }

    public List<RevenueTrendPointResponse> getRevenueTrend(LocalDateTime from, LocalDateTime to) {
        return orderRepository.findRevenueTrend(from, to).stream()
                .map(row -> new RevenueTrendPointResponse(
                        row[0].toString(),
                        row[1] == null ? BigDecimal.ZERO : new BigDecimal(row[1].toString()),
                        ((Number) row[2]).longValue()))
                .toList();
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
