package com.shopsphere.dto;

import java.util.Set;

public record LoginResponse(String token, String tokenType, Long userId, String email, Set<String> roles) {
}
