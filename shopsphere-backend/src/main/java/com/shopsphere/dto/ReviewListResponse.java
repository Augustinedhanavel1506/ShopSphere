package com.shopsphere.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class ReviewListResponse {

    private double averageRating;
    private int totalReviews;
    private List<ReviewResponse> reviews;
}
