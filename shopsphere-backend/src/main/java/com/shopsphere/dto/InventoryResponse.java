package com.shopsphere.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class InventoryResponse {

    private Long productId;
    private Integer quantity;
    private boolean inStock;
    private LocalDateTime updatedAt;
}
