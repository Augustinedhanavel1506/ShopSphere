package com.shopsphere.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.shopsphere.dto.AddressRequest;
import com.shopsphere.dto.AddressResponse;
import com.shopsphere.entity.Address;
import com.shopsphere.entity.User;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.AddressRepository;
import com.shopsphere.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AddressService {

    private final AddressRepository addressRepository;
    private final UserRepository userRepository;

    public List<AddressResponse> getAll(String email) {
        User user = findUserOrThrow(email);
        return addressRepository.findByUserIdOrderByIsDefaultDescCreatedAtDesc(user.getId()).stream()
                .map(this::toResponse)
                .toList();
    }

    public AddressResponse create(String email, AddressRequest request) {
        User user = findUserOrThrow(email);
        boolean isFirstAddress = addressRepository.findByUserIdOrderByIsDefaultDescCreatedAtDesc(user.getId()).isEmpty();
        boolean makeDefault = isFirstAddress || Boolean.TRUE.equals(request.getIsDefault());

        if (makeDefault) {
            clearExistingDefault(user.getId());
        }

        Address address = Address.builder()
                .user(user)
                .fullName(request.getFullName())
                .phone(request.getPhone())
                .line1(request.getLine1())
                .line2(request.getLine2())
                .city(request.getCity())
                .state(request.getState())
                .postalCode(request.getPostalCode())
                .country(request.getCountry())
                .isDefault(makeDefault)
                .build();

        return toResponse(addressRepository.save(address));
    }

    public AddressResponse update(String email, Long id, AddressRequest request) {
        Address address = findOwnedOrThrow(email, id);

        if (Boolean.TRUE.equals(request.getIsDefault()) && !Boolean.TRUE.equals(address.getIsDefault())) {
            clearExistingDefault(address.getUser().getId());
            address.setIsDefault(true);
        }

        address.setFullName(request.getFullName());
        address.setPhone(request.getPhone());
        address.setLine1(request.getLine1());
        address.setLine2(request.getLine2());
        address.setCity(request.getCity());
        address.setState(request.getState());
        address.setPostalCode(request.getPostalCode());
        address.setCountry(request.getCountry());

        return toResponse(addressRepository.save(address));
    }

    public void delete(String email, Long id) {
        Address address = findOwnedOrThrow(email, id);
        Long userId = address.getUser().getId();
        boolean wasDefault = Boolean.TRUE.equals(address.getIsDefault());

        addressRepository.delete(address);

        if (wasDefault) {
            addressRepository.findByUserIdOrderByIsDefaultDescCreatedAtDesc(userId).stream()
                    .findFirst()
                    .ifPresent(next -> {
                        next.setIsDefault(true);
                        addressRepository.save(next);
                    });
        }
    }

    public AddressResponse setDefault(String email, Long id) {
        Address address = findOwnedOrThrow(email, id);
        clearExistingDefault(address.getUser().getId());
        address.setIsDefault(true);
        return toResponse(addressRepository.save(address));
    }

    Address findOwnedOrThrow(String email, Long id) {
        User user = findUserOrThrow(email);
        return addressRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Address not found with id " + id));
    }

    private void clearExistingDefault(Long userId) {
        addressRepository.findByUserIdAndIsDefaultTrue(userId).ifPresent(existing -> {
            existing.setIsDefault(false);
            addressRepository.save(existing);
        });
    }

    private User findUserOrThrow(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + email));
    }

    private AddressResponse toResponse(Address address) {
        return AddressResponse.builder()
                .id(address.getId())
                .fullName(address.getFullName())
                .phone(address.getPhone())
                .line1(address.getLine1())
                .line2(address.getLine2())
                .city(address.getCity())
                .state(address.getState())
                .postalCode(address.getPostalCode())
                .country(address.getCountry())
                .isDefault(address.getIsDefault())
                .createdAt(address.getCreatedAt())
                .updatedAt(address.getUpdatedAt())
                .build();
    }
}
