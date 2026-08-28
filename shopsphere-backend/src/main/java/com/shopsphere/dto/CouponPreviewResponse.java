package com.shopsphere.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class CouponPreviewResponse {

    private String code;
    private BigDecimal orderTotal;
    private BigDecimal discountAmount;
    private BigDecimal finalTotal;
}
