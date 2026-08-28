package com.shopsphere.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductSpecificationRequest {

    @NotBlank(message = "Specification key is required")
    private String key;

    @NotBlank(message = "Specification value is required")
    private String value;
}
