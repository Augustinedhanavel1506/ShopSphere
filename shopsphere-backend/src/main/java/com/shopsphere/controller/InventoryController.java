package com.shopsphere.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shopsphere.dto.AdjustQuantityRequest;
import com.shopsphere.dto.InventoryResponse;
import com.shopsphere.dto.InventoryTransactionResponse;
import com.shopsphere.dto.SetQuantityRequest;
import com.shopsphere.service.InventoryService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/inventory")
@RequiredArgsConstructor
public class InventoryController {

    private final InventoryService inventoryService;

    @GetMapping("/{productId}")
    public InventoryResponse get(@PathVariable Long productId) {
        return inventoryService.getByProductId(productId);
    }

    @PutMapping("/{productId}")
    @PreAuthorize("hasRole('ADMIN')")
    public InventoryResponse setQuantity(@PathVariable Long productId, @Valid @RequestBody SetQuantityRequest request) {
        return inventoryService.setQuantity(productId, request.getQuantity());
    }

    @PostMapping("/{productId}/adjust")
    @PreAuthorize("hasRole('ADMIN')")
    public InventoryResponse adjust(@PathVariable Long productId, @Valid @RequestBody AdjustQuantityRequest request) {
        return inventoryService.adjustQuantity(productId, request.getDelta());
    }

    @GetMapping("/{productId}/history")
    @PreAuthorize("hasRole('ADMIN')")
    public List<InventoryTransactionResponse> getHistory(@PathVariable Long productId) {
        return inventoryService.getHistory(productId);
    }
}
