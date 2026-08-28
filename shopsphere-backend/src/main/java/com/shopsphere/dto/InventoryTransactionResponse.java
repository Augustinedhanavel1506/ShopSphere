package com.shopsphere.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class InventoryTransactionResponse {

    private Long id;
    private Integer changeQuantity;
    private Integer resultingQuantity;
    private String reason;
    private LocalDateTime createdAt;
}
