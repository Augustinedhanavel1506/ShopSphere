package com.shopsphere.controller;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shopsphere.dto.PaymentRequest;
import com.shopsphere.dto.PaymentResponse;
import com.shopsphere.service.PaymentService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/orders/{orderId}")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;

    @PostMapping("/pay")
    public PaymentResponse pay(Authentication authentication, @PathVariable Long orderId,
                                @Valid @RequestBody PaymentRequest request) {
        return paymentService.pay(authentication.getName(), orderId, request);
    }

    @GetMapping("/payment")
    public PaymentResponse getPayment(Authentication authentication, @PathVariable Long orderId) {
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"));
        return paymentService.getForOrder(authentication.getName(), isAdmin, orderId);
    }
}
