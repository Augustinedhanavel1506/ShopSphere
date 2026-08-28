package com.shopsphere.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WishlistItemRequest {

    @NotNull(message = "Product id is required")
    private Long productId;
}
