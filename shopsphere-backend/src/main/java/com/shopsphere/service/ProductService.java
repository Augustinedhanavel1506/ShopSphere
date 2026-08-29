package com.shopsphere.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.ProductImageRequest;
import com.shopsphere.dto.ProductImageResponse;
import com.shopsphere.dto.ProductRequest;
import com.shopsphere.dto.ProductResponse;
import com.shopsphere.dto.ProductSpecificationRequest;
import com.shopsphere.dto.ProductSpecificationResponse;
import com.shopsphere.entity.Category;
import com.shopsphere.entity.Product;
import com.shopsphere.entity.ProductImage;
import com.shopsphere.entity.ProductSpecification;
import com.shopsphere.exception.DuplicateResourceException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.CategoryRepository;
import com.shopsphere.repository.ProductRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final InventoryService inventoryService;

    public List<ProductResponse> getAll(Long categoryId, boolean includeInactive) {
        List<Product> products;
        if (categoryId != null) {
            products = includeInactive
                    ? productRepository.findByCategoryId(categoryId)
                    : productRepository.findByActiveTrueAndCategoryId(categoryId);
        } else {
            products = includeInactive ? productRepository.findAll() : productRepository.findByActiveTrue();
        }
        return products.stream().map(this::toResponse).toList();
    }

    public List<ProductResponse> search(String query, boolean includeInactive) {
        List<Product> products = includeInactive
                ? productRepository.findByNameContainingIgnoreCaseOrDescriptionContainingIgnoreCase(query, query)
                : productRepository.findByActiveTrueAndNameContainingIgnoreCaseOrActiveTrueAndDescriptionContainingIgnoreCase(query, query);
        return products.stream().map(this::toResponse).toList();
    }

    public ProductResponse getById(Long id) {
        return toResponse(findOrThrow(id));
    }

    public ProductResponse create(ProductRequest request) {
        if (productRepository.existsBySku(request.getSku())) {
            throw new DuplicateResourceException("A product with SKU '" + request.getSku() + "' already exists");
        }

        Category category = findCategoryOrThrow(request.getCategoryId());

        Product product = Product.builder()
                .category(category)
                .name(request.getName())
                .description(request.getDescription())
                .price(request.getPrice())
                .originalPrice(request.getOriginalPrice())
                .sku(request.getSku())
                .active(Optional.ofNullable(request.getActive()).orElse(true))
                .build();

        applyImages(product, request.getImages());
        applySpecifications(product, request.getSpecifications());

        Product saved = productRepository.save(product);
        inventoryService.initializeForProduct(saved);

        return toResponse(saved);
    }

    public ProductResponse update(Long id, ProductRequest request) {
        Product product = findOrThrow(id);

        if (productRepository.existsBySkuAndIdNot(request.getSku(), id)) {
            throw new DuplicateResourceException("A product with SKU '" + request.getSku() + "' already exists");
        }

        Category category = findCategoryOrThrow(request.getCategoryId());

        product.setCategory(category);
        product.setName(request.getName());
        product.setDescription(request.getDescription());
        product.setPrice(request.getPrice());
        product.setOriginalPrice(request.getOriginalPrice());
        product.setSku(request.getSku());
        product.setActive(Optional.ofNullable(request.getActive()).orElse(true));

        product.getImages().clear();
        applyImages(product, request.getImages());

        product.getSpecifications().clear();
        applySpecifications(product, request.getSpecifications());

        return toResponse(productRepository.save(product));
    }

    public void delete(Long id) {
        Product product = findOrThrow(id);
        productRepository.delete(product);
    }

    private void applyImages(Product product, List<ProductImageRequest> imageRequests) {
        if (imageRequests == null) {
            return;
        }
        imageRequests.forEach(imageRequest -> product.getImages().add(
                ProductImage.builder()
                        .product(product)
                        .imageUrl(imageRequest.getImageUrl())
                        .displayOrder(Optional.ofNullable(imageRequest.getDisplayOrder()).orElse(0))
                        .build()));
    }

    private void applySpecifications(Product product, List<ProductSpecificationRequest> specRequests) {
        if (specRequests == null) {
            return;
        }
        specRequests.forEach(specRequest -> product.getSpecifications().add(
                ProductSpecification.builder()
                        .product(product)
                        .specKey(specRequest.getKey())
                        .specValue(specRequest.getValue())
                        .build()));
    }

    private Product findOrThrow(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id " + id));
    }

    private Category findCategoryOrThrow(Long categoryId) {
        return categoryRepository.findById(categoryId)
                .orElseThrow(() -> new ResourceNotFoundException("Category not found with id " + categoryId));
    }

    private ProductResponse toResponse(Product product) {
        List<ProductImageResponse> images = product.getImages().stream()
                .map(image -> ProductImageResponse.builder()
                        .id(image.getId())
                        .imageUrl(image.getImageUrl())
                        .displayOrder(image.getDisplayOrder())
                        .build())
                .toList();

        List<ProductSpecificationResponse> specifications = product.getSpecifications().stream()
                .map(spec -> ProductSpecificationResponse.builder()
                        .id(spec.getId())
                        .key(spec.getSpecKey())
                        .value(spec.getSpecValue())
                        .build())
                .toList();

        Integer discountPercentage = null;
        if (product.getOriginalPrice() != null && product.getOriginalPrice().compareTo(product.getPrice()) > 0) {
            discountPercentage = product.getOriginalPrice().subtract(product.getPrice())
                    .multiply(BigDecimal.valueOf(100))
                    .divide(product.getOriginalPrice(), 0, RoundingMode.HALF_UP)
                    .intValue();
        }

        return ProductResponse.builder()
                .id(product.getId())
                .categoryId(product.getCategory().getId())
                .categoryName(product.getCategory().getName())
                .name(product.getName())
                .description(product.getDescription())
                .price(product.getPrice())
                .originalPrice(product.getOriginalPrice())
                .discountPercentage(discountPercentage)
                .sku(product.getSku())
                .active(product.getActive())
                .images(images)
                .specifications(specifications)
                .createdAt(product.getCreatedAt())
                .updatedAt(product.getUpdatedAt())
                .build();
    }
}
