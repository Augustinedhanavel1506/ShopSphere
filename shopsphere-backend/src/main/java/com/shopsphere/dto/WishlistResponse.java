package com.shopsphere.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class WishlistResponse {

    private Long id;
    private List<WishlistItemResponse> items;
}
