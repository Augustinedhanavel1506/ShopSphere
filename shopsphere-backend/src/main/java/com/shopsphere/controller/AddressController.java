package com.shopsphere.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shopsphere.dto.AddressRequest;
import com.shopsphere.dto.AddressResponse;
import com.shopsphere.service.AddressService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/addresses")
@RequiredArgsConstructor
public class AddressController {

    private final AddressService addressService;

    @GetMapping
    public List<AddressResponse> getAll(Authentication authentication) {
        return addressService.getAll(authentication.getName());
    }

    @PostMapping
    public ResponseEntity<AddressResponse> create(Authentication authentication, @Valid @RequestBody AddressRequest request) {
        AddressResponse response = addressService.create(authentication.getName(), request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PutMapping("/{id}")
    public AddressResponse update(Authentication authentication, @PathVariable Long id, @Valid @RequestBody AddressRequest request) {
        return addressService.update(authentication.getName(), id, request);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(Authentication authentication, @PathVariable Long id) {
        addressService.delete(authentication.getName(), id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/{id}/default")
    public AddressResponse setDefault(Authentication authentication, @PathVariable Long id) {
        return addressService.setDefault(authentication.getName(), id);
    }
}
