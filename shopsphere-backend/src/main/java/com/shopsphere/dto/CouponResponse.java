package com.shopsphere.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class CouponResponse {

    private Long id;
    private String code;
    private String discountType;
    private BigDecimal discountValue;
    private BigDecimal minOrderAmount;
    private Integer maxUses;
    private BigDecimal maxDiscountAmount;
    private Integer usedCount;
    private LocalDateTime expiresAt;
    private Boolean active;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
