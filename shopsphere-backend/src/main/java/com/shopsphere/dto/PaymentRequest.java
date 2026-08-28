package com.shopsphere.dto;

import com.shopsphere.entity.PaymentMethod;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentRequest {

    @NotNull(message = "Payment method is required")
    private PaymentMethod method;
}
