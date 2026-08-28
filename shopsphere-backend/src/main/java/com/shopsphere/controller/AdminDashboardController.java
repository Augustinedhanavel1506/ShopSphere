package com.shopsphere.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shopsphere.dto.DashboardSummaryResponse;
import com.shopsphere.dto.LowStockProductResponse;
import com.shopsphere.dto.OrderResponse;
import com.shopsphere.service.AdminDashboardService;
import com.shopsphere.service.OrderService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin/dashboard")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminDashboardController {

    private final AdminDashboardService adminDashboardService;
    private final OrderService orderService;

    @GetMapping("/summary")
    public DashboardSummaryResponse getSummary(
            @RequestParam(defaultValue = "5") int lowStockThreshold,
            @RequestParam(required = false) String period,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime from,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime to) {
        LocalDateTime[] range = adminDashboardService.resolveRange(period, from, to);
        return adminDashboardService.getSummary(lowStockThreshold, range[0], range[1]);
    }

    @GetMapping("/low-stock")
    public List<LowStockProductResponse> getLowStockProducts(@RequestParam(defaultValue = "5") int threshold) {
        return adminDashboardService.getLowStockProducts(threshold);
    }

    @GetMapping("/recent-orders")
    public List<OrderResponse> getRecentOrders(
            @RequestParam(defaultValue = "10") int limit,
            @RequestParam(required = false) String period,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime from,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime to) {
        LocalDateTime[] range = adminDashboardService.resolveRange(period, from, to);
        return orderService.getRecentOrders(limit, range[0], range[1]);
    }
}
