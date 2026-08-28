package com.shopsphere.dto;

import java.math.BigDecimal;

public record DashboardSummaryResponse(
        BigDecimal totalRevenue,
        long totalOrders,
        long pendingOrders,
        long paidOrders,
        long cancelledOrders,
        long totalCustomers,
        long totalProducts,
        long lowStockProductCount) {
}
