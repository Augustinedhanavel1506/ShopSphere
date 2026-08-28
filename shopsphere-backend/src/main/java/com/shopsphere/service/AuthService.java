package com.shopsphere.service;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.shopsphere.dto.ForgotPasswordRequest;
import com.shopsphere.dto.LoginRequest;
import com.shopsphere.dto.LoginResponse;
import com.shopsphere.dto.RefreshTokenRequest;
import com.shopsphere.dto.RegisterRequest;
import com.shopsphere.dto.ResendVerificationRequest;
import com.shopsphere.dto.ResetPasswordRequest;
import com.shopsphere.dto.UserResponse;
import com.shopsphere.entity.RefreshToken;
import com.shopsphere.entity.Role;
import com.shopsphere.entity.User;
import com.shopsphere.exception.DuplicateEmailException;
import com.shopsphere.exception.EmailNotVerifiedException;
import com.shopsphere.exception.InvalidTokenException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.RefreshTokenRepository;
import com.shopsphere.repository.RoleRepository;
import com.shopsphere.repository.UserRepository;
import com.shopsphere.security.JwtService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

    private static final String DEFAULT_ROLE = "CUSTOMER";

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final NotificationService notificationService;

    @Value("${app.refresh-token.expiration-days}")
    private long refreshTokenExpirationDays;

    public UserResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new DuplicateEmailException(request.getEmail());
        }

        Role customerRole = roleRepository.findByName(DEFAULT_ROLE)
                .orElseThrow(() -> new IllegalStateException(DEFAULT_ROLE + " role is not seeded"));

        String verificationToken = UUID.randomUUID().toString();

        User user = User.builder()
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .phone(request.getPhone())
                .roles(Set.of(customerRole))
                .emailVerified(false)
                .verificationToken(verificationToken)
                .verificationTokenExpiry(LocalDateTime.now().plusHours(24))
                .build();

        User saved = userRepository.save(user);
        notificationService.sendRegistrationEmail(saved.getEmail(), saved.getFirstName());
        notificationService.sendVerificationEmail(saved.getEmail(), saved.getFirstName(), verificationToken);
        return toResponse(saved);
    }

    public LoginResponse login(LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));

        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new IllegalStateException("Authenticated user not found: " + request.getEmail()));

        if (!Boolean.TRUE.equals(user.getEmailVerified())) {
            throw new EmailNotVerifiedException(
                    "Please verify your email before logging in. Check your inbox for a verification link.");
        }

        Set<String> roleNames = user.getRoles().stream().map(Role::getName).collect(Collectors.toSet());
        String accessToken = jwtService.generateToken(user.getEmail(), roleNames);
        RefreshToken refreshToken = createRefreshToken(user);

        return new LoginResponse(accessToken, refreshToken.getToken(), "Bearer", user.getId(), user.getEmail(), roleNames);
    }

    public LoginResponse refresh(RefreshTokenRequest request) {
        RefreshToken existing = refreshTokenRepository.findByToken(request.getRefreshToken())
                .orElseThrow(() -> new InvalidTokenException("Invalid refresh token"));

        if (Boolean.TRUE.equals(existing.getRevoked()) || existing.getExpiresAt().isBefore(LocalDateTime.now())) {
            throw new InvalidTokenException("Refresh token is expired or has been revoked");
        }

        existing.setRevoked(true);
        refreshTokenRepository.save(existing);

        User user = existing.getUser();
        Set<String> roleNames = user.getRoles().stream().map(Role::getName).collect(Collectors.toSet());
        String accessToken = jwtService.generateToken(user.getEmail(), roleNames);
        RefreshToken newRefreshToken = createRefreshToken(user);

        return new LoginResponse(accessToken, newRefreshToken.getToken(), "Bearer", user.getId(), user.getEmail(), roleNames);
    }

    public void logout(RefreshTokenRequest request) {
        refreshTokenRepository.findByToken(request.getRefreshToken()).ifPresent(rt -> {
            rt.setRevoked(true);
            refreshTokenRepository.save(rt);
        });
        // Idempotent: logging out with an unknown/already-invalid token still succeeds silently.
    }

    private RefreshToken createRefreshToken(User user) {
        RefreshToken refreshToken = RefreshToken.builder()
                .user(user)
                .token(UUID.randomUUID().toString())
                .expiresAt(LocalDateTime.now().plusDays(refreshTokenExpirationDays))
                .revoked(false)
                .build();
        return refreshTokenRepository.save(refreshToken);
    }

    public void verifyEmail(String token) {
        User user = userRepository.findByVerificationToken(token)
                .orElseThrow(() -> new InvalidTokenException("Invalid verification token"));

        if (user.getVerificationTokenExpiry() == null || user.getVerificationTokenExpiry().isBefore(LocalDateTime.now())) {
            throw new InvalidTokenException("Verification token has expired; request a new one");
        }

        user.setEmailVerified(true);
        user.setVerificationToken(null);
        user.setVerificationTokenExpiry(null);
        userRepository.save(user);
    }

    public void resendVerification(ResendVerificationRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + request.getEmail()));

        if (Boolean.TRUE.equals(user.getEmailVerified())) {
            throw new InvalidTokenException("Email is already verified");
        }

        String verificationToken = UUID.randomUUID().toString();
        user.setVerificationToken(verificationToken);
        user.setVerificationTokenExpiry(LocalDateTime.now().plusHours(24));
        userRepository.save(user);

        notificationService.sendVerificationEmail(user.getEmail(), user.getFirstName(), verificationToken);
    }

    public void forgotPassword(ForgotPasswordRequest request) {
        userRepository.findByEmail(request.getEmail()).ifPresent(user -> {
            String resetToken = UUID.randomUUID().toString();
            user.setResetToken(resetToken);
            user.setResetTokenExpiry(LocalDateTime.now().plusHours(1));
            userRepository.save(user);
            notificationService.sendPasswordResetEmail(user.getEmail(), user.getFirstName(), resetToken);
        });
        // Always returns silently, even if the email doesn't exist, to avoid leaking which emails are registered.
    }

    public void resetPassword(ResetPasswordRequest request) {
        User user = userRepository.findByResetToken(request.getToken())
                .orElseThrow(() -> new InvalidTokenException("Invalid reset token"));

        if (user.getResetTokenExpiry() == null || user.getResetTokenExpiry().isBefore(LocalDateTime.now())) {
            throw new InvalidTokenException("Reset token has expired; request a new one");
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        user.setResetToken(null);
        user.setResetTokenExpiry(null);
        userRepository.save(user);
    }

    public UserResponse getProfile(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalStateException("Authenticated user not found: " + email));
        return toResponse(user);
    }

    private UserResponse toResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .roles(user.getRoles().stream().map(Role::getName).collect(Collectors.toSet()))
                .createdAt(user.getCreatedAt())
                .build();
    }
}
