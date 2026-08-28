package com.shopsphere.service;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.InventoryResponse;
import com.shopsphere.entity.Inventory;
import com.shopsphere.entity.Product;
import com.shopsphere.exception.InsufficientStockException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.InventoryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryService {

    private final InventoryRepository inventoryRepository;

    public void initializeForProduct(Product product) {
        Inventory inventory = Inventory.builder()
                .product(product)
                .quantity(0)
                .build();
        inventoryRepository.save(inventory);
    }

    public InventoryResponse getByProductId(Long productId) {
        return toResponse(findOrThrow(productId));
    }

    public InventoryResponse setQuantity(Long productId, int quantity) {
        Inventory inventory = findOrThrow(productId);
        inventory.setQuantity(quantity);
        return toResponse(inventoryRepository.save(inventory));
    }

    public InventoryResponse adjustQuantity(Long productId, int delta) {
        Inventory inventory = findOrThrow(productId);
        int newQuantity = inventory.getQuantity() + delta;

        if (newQuantity < 0) {
            throw new InsufficientStockException(
                    "Cannot adjust stock by " + delta + ": only " + inventory.getQuantity() + " available");
        }

        inventory.setQuantity(newQuantity);
        return toResponse(inventoryRepository.save(inventory));
    }

    private Inventory findOrThrow(Long productId) {
        return inventoryRepository.findByProductId(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Inventory not found for product id " + productId));
    }

    private InventoryResponse toResponse(Inventory inventory) {
        return InventoryResponse.builder()
                .productId(inventory.getProduct().getId())
                .quantity(inventory.getQuantity())
                .inStock(inventory.getQuantity() > 0)
                .updatedAt(inventory.getUpdatedAt())
                .build();
    }
}
