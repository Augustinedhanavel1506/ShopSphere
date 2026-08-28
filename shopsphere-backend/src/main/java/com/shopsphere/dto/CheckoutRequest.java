package com.shopsphere.dto;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckoutRequest {

    /** Either addressId (a saved address) or shippingAddress (inline) must be provided. */
    private Long addressId;

    @Valid
    private ShippingAddressRequest shippingAddress;

    private String couponCode;
}
