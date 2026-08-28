package com.shopsphere.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class WishlistItemResponse {

    private Long id;
    private Long productId;
    private String productName;
    private BigDecimal price;
    private LocalDateTime addedAt;
}
