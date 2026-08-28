package com.shopsphere.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdjustQuantityRequest {

    @NotNull(message = "Delta is required")
    private Integer delta;
}
