package com.shopsphere.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.InventoryResponse;
import com.shopsphere.dto.InventoryTransactionResponse;
import com.shopsphere.entity.Inventory;
import com.shopsphere.entity.InventoryTransaction;
import com.shopsphere.entity.InventoryTransactionReason;
import com.shopsphere.entity.Product;
import com.shopsphere.exception.InsufficientStockException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.InventoryRepository;
import com.shopsphere.repository.InventoryTransactionRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryService {

    private final InventoryRepository inventoryRepository;
    private final InventoryTransactionRepository transactionRepository;

    public void initializeForProduct(Product product) {
        Inventory inventory = Inventory.builder()
                .product(product)
                .quantity(0)
                .build();
        inventoryRepository.save(inventory);
        logTransaction(product, 0, 0, InventoryTransactionReason.INITIAL);
    }

    public InventoryResponse getByProductId(Long productId) {
        return toResponse(findOrThrow(productId));
    }

    public List<InventoryTransactionResponse> getHistory(Long productId) {
        return transactionRepository.findByProductIdOrderByCreatedAtDescIdDesc(productId).stream()
                .map(tx -> InventoryTransactionResponse.builder()
                        .id(tx.getId())
                        .changeQuantity(tx.getChangeQuantity())
                        .resultingQuantity(tx.getResultingQuantity())
                        .reason(tx.getReason().name())
                        .createdAt(tx.getCreatedAt())
                        .build())
                .toList();
    }

    public InventoryResponse setQuantity(Long productId, int quantity) {
        Inventory inventory = findOrThrow(productId);
        int change = quantity - inventory.getQuantity();
        inventory.setQuantity(quantity);
        Inventory saved = inventoryRepository.save(inventory);
        logTransaction(inventory.getProduct(), change, quantity, InventoryTransactionReason.MANUAL_ADJUSTMENT);
        return toResponse(saved);
    }

    public InventoryResponse adjustQuantity(Long productId, int delta) {
        return adjustQuantity(productId, delta, InventoryTransactionReason.MANUAL_ADJUSTMENT);
    }

    public InventoryResponse adjustQuantity(Long productId, int delta, InventoryTransactionReason reason) {
        Inventory inventory = findOrThrow(productId);
        int newQuantity = inventory.getQuantity() + delta;

        if (newQuantity < 0) {
            throw new InsufficientStockException(
                    "Cannot adjust stock by " + delta + ": only " + inventory.getQuantity() + " available");
        }

        inventory.setQuantity(newQuantity);
        Inventory saved = inventoryRepository.save(inventory);
        logTransaction(inventory.getProduct(), delta, newQuantity, reason);
        return toResponse(saved);
    }

    private void logTransaction(Product product, int change, int resultingQuantity, InventoryTransactionReason reason) {
        transactionRepository.save(InventoryTransaction.builder()
                .product(product)
                .changeQuantity(change)
                .resultingQuantity(resultingQuantity)
                .reason(reason)
                .build());
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
