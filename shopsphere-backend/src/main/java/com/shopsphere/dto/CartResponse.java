package com.shopsphere.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class CartResponse {

    private Long id;
    private List<CartItemResponse> items;
    private List<CartItemResponse> savedItems;
    private Integer totalItems;
    private BigDecimal totalPrice;
}
