package com.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class ProductImageResponse {

    private Long id;
    private String imageUrl;
    private Integer displayOrder;
}
