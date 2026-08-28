package com.shopsphere.dto;

import java.util.Set;

public record LoginResponse(
        String accessToken,
        String refreshToken,
        String tokenType,
        Long userId,
        String email,
        Set<String> roles) {
}
