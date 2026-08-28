package com.shopsphere.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class ProductResponse {

    private Long id;
    private Long categoryId;
    private String categoryName;
    private String name;
    private String description;
    private BigDecimal price;
    private BigDecimal originalPrice;
    private Integer discountPercentage;
    private String sku;
    private Boolean active;
    private List<ProductImageResponse> images;
    private List<ProductSpecificationResponse> specifications;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
