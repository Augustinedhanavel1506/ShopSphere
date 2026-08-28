package com.shopsphere.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.shopsphere.entity.DiscountType;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CouponRequest {

    @NotBlank(message = "Code is required")
    private String code;

    @NotNull(message = "Discount type is required")
    private DiscountType discountType;

    @NotNull(message = "Discount value is required")
    @DecimalMin(value = "0.01", message = "Discount value must be positive")
    private BigDecimal discountValue;

    @DecimalMin(value = "0.0", message = "Minimum order amount must not be negative")
    private BigDecimal minOrderAmount = BigDecimal.ZERO;

    @Min(value = 1, message = "Max uses must be at least 1")
    private Integer maxUses;

    private LocalDateTime expiresAt;

    private Boolean active = true;
}
