package com.shopsphere.service;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationService {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromAddress;

    @Async
    public void sendRegistrationEmail(String toEmail, String firstName) {
        send(toEmail, "Welcome to ShopSphere",
                "Hi " + firstName + ",\n\nThanks for registering with ShopSphere! We're glad to have you.");
    }

    @Async
    public void sendOrderConfirmationEmail(String toEmail, Long orderId, BigDecimal totalAmount) {
        send(toEmail, "Order Confirmation - #" + orderId,
                "Your order #" + orderId + " has been placed successfully.\nTotal: " + totalAmount
                        + "\n\nWe'll notify you once payment is received.");
    }

    @Async
    public void sendPaymentConfirmationEmail(String toEmail, Long orderId, BigDecimal amount) {
        send(toEmail, "Payment Received - Order #" + orderId,
                "We have received your payment of " + amount + " for order #" + orderId + ". Thank you!");
    }

    @Async
    public void sendOrderCancelledEmail(String toEmail, Long orderId) {
        send(toEmail, "Order Cancelled - #" + orderId,
                "Your order #" + orderId + " has been cancelled. If this wasn't you, please contact support.");
    }

    @Async
    public void sendOrderStatusUpdateEmail(String toEmail, Long orderId, String newStatus) {
        send(toEmail, "Order Update - #" + orderId,
                "Your order #" + orderId + " status has been updated to: " + newStatus + ".");
    }

    private void send(String to, String subject, String body) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromAddress);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            mailSender.send(message);
        } catch (Exception ex) {
            log.warn("Failed to send email to {}: {}", to, ex.getMessage());
        }
    }
}
