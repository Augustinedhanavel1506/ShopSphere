package com.shopsphere.dto;

public record LowStockProductResponse(Long productId, String productName, Integer quantity) {
}
