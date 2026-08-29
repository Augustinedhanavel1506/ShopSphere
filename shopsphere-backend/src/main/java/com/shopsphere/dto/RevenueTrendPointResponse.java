package com.shopsphere.dto;

import java.math.BigDecimal;

public record RevenueTrendPointResponse(String date, BigDecimal revenue, long orderCount) {
}
