package com.shopsphere.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.CouponPreviewResponse;
import com.shopsphere.dto.CouponRequest;
import com.shopsphere.dto.CouponResponse;
import com.shopsphere.entity.Coupon;
import com.shopsphere.entity.DiscountType;
import com.shopsphere.exception.DuplicateResourceException;
import com.shopsphere.exception.InvalidCouponException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.CouponRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CouponService {

    private final CouponRepository couponRepository;

    public List<CouponResponse> getAll() {
        return couponRepository.findAll().stream().map(this::toResponse).toList();
    }

    public CouponResponse create(CouponRequest request) {
        String code = normalize(request.getCode());

        if (couponRepository.existsByCode(code)) {
            throw new DuplicateResourceException("A coupon with code '" + code + "' already exists");
        }
        validatePercentageRange(request.getDiscountType(), request.getDiscountValue());

        Coupon coupon = Coupon.builder()
                .code(code)
                .discountType(request.getDiscountType())
                .discountValue(request.getDiscountValue())
                .minOrderAmount(request.getMinOrderAmount() == null ? BigDecimal.ZERO : request.getMinOrderAmount())
                .maxUses(request.getMaxUses())
                .usedCount(0)
                .expiresAt(request.getExpiresAt())
                .active(request.getActive() == null || request.getActive())
                .build();

        return toResponse(couponRepository.save(coupon));
    }

    public CouponResponse update(Long id, CouponRequest request) {
        Coupon coupon = findOrThrow(id);
        String code = normalize(request.getCode());

        if (!coupon.getCode().equals(code) && couponRepository.existsByCode(code)) {
            throw new DuplicateResourceException("A coupon with code '" + code + "' already exists");
        }
        validatePercentageRange(request.getDiscountType(), request.getDiscountValue());

        coupon.setCode(code);
        coupon.setDiscountType(request.getDiscountType());
        coupon.setDiscountValue(request.getDiscountValue());
        coupon.setMinOrderAmount(request.getMinOrderAmount() == null ? BigDecimal.ZERO : request.getMinOrderAmount());
        coupon.setMaxUses(request.getMaxUses());
        coupon.setExpiresAt(request.getExpiresAt());
        coupon.setActive(request.getActive() == null || request.getActive());

        return toResponse(couponRepository.save(coupon));
    }

    public void delete(Long id) {
        couponRepository.delete(findOrThrow(id));
    }

    public CouponPreviewResponse preview(String code, BigDecimal orderTotal) {
        Coupon coupon = validate(code, orderTotal);
        BigDecimal discount = calculateDiscount(coupon, orderTotal);

        return CouponPreviewResponse.builder()
                .code(coupon.getCode())
                .orderTotal(orderTotal)
                .discountAmount(discount)
                .finalTotal(orderTotal.subtract(discount))
                .build();
    }

    public Coupon validate(String code, BigDecimal orderTotal) {
        Coupon coupon = couponRepository.findByCode(normalize(code))
                .orElseThrow(() -> new InvalidCouponException("Coupon code '" + code + "' does not exist"));

        if (!coupon.getActive()) {
            throw new InvalidCouponException("Coupon '" + coupon.getCode() + "' is not active");
        }
        if (coupon.getExpiresAt() != null && coupon.getExpiresAt().isBefore(LocalDateTime.now())) {
            throw new InvalidCouponException("Coupon '" + coupon.getCode() + "' has expired");
        }
        if (coupon.getMaxUses() != null && coupon.getUsedCount() >= coupon.getMaxUses()) {
            throw new InvalidCouponException("Coupon '" + coupon.getCode() + "' has reached its usage limit");
        }
        if (orderTotal.compareTo(coupon.getMinOrderAmount()) < 0) {
            throw new InvalidCouponException(
                    "Coupon '" + coupon.getCode() + "' requires a minimum order amount of " + coupon.getMinOrderAmount());
        }

        return coupon;
    }

    public BigDecimal calculateDiscount(Coupon coupon, BigDecimal orderTotal) {
        BigDecimal discount = coupon.getDiscountType() == DiscountType.PERCENTAGE
                ? orderTotal.multiply(coupon.getDiscountValue()).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP)
                : coupon.getDiscountValue();

        return discount.min(orderTotal);
    }

    public void recordRedemption(Coupon coupon) {
        coupon.setUsedCount(coupon.getUsedCount() + 1);
        couponRepository.save(coupon);
    }

    private void validatePercentageRange(DiscountType type, BigDecimal value) {
        if (type == DiscountType.PERCENTAGE && value.compareTo(BigDecimal.valueOf(100)) > 0) {
            throw new InvalidCouponException("Percentage discount cannot exceed 100");
        }
    }

    private String normalize(String code) {
        return code.trim().toUpperCase();
    }

    private Coupon findOrThrow(Long id) {
        return couponRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Coupon not found with id " + id));
    }

    private CouponResponse toResponse(Coupon coupon) {
        return CouponResponse.builder()
                .id(coupon.getId())
                .code(coupon.getCode())
                .discountType(coupon.getDiscountType().name())
                .discountValue(coupon.getDiscountValue())
                .minOrderAmount(coupon.getMinOrderAmount())
                .maxUses(coupon.getMaxUses())
                .usedCount(coupon.getUsedCount())
                .expiresAt(coupon.getExpiresAt())
                .active(coupon.getActive())
                .createdAt(coupon.getCreatedAt())
                .updatedAt(coupon.getUpdatedAt())
                .build();
    }
}
