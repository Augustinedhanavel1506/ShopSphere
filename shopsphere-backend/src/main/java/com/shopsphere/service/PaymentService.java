package com.shopsphere.service;

import java.util.UUID;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shopsphere.dto.PaymentRequest;
import com.shopsphere.dto.PaymentResponse;
import com.shopsphere.entity.Order;
import com.shopsphere.entity.OrderStatus;
import com.shopsphere.entity.Payment;
import com.shopsphere.entity.PaymentStatus;
import com.shopsphere.exception.InvalidOrderStateException;
import com.shopsphere.exception.ResourceNotFoundException;
import com.shopsphere.repository.OrderRepository;
import com.shopsphere.repository.PaymentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final OrderRepository orderRepository;
    private final NotificationService notificationService;

    @Transactional
    public PaymentResponse pay(String email, Long orderId, PaymentRequest request) {
        Order order = findOrderOrThrow(orderId);

        if (!order.getUser().getEmail().equalsIgnoreCase(email)) {
            throw new AccessDeniedException("You can only pay for your own orders");
        }

        if (order.getStatus() != OrderStatus.PENDING) {
            throw new InvalidOrderStateException("Only pending orders can be paid for");
        }

        Payment payment = Payment.builder()
                .order(order)
                .amount(order.getTotalAmount())
                .method(request.getMethod())
                .status(PaymentStatus.SUCCESS)
                .transactionReference(UUID.randomUUID().toString())
                .build();

        Payment saved = paymentRepository.save(payment);

        order.setStatus(OrderStatus.PAID);
        orderRepository.save(order);

        notificationService.sendPaymentConfirmationEmail(order.getUser().getEmail(), order.getId(), saved.getAmount());

        return toResponse(saved);
    }

    public PaymentResponse getForOrder(String email, boolean isAdmin, Long orderId) {
        Order order = findOrderOrThrow(orderId);

        if (!isAdmin && !order.getUser().getEmail().equalsIgnoreCase(email)) {
            throw new AccessDeniedException("You can only view payments for your own orders");
        }

        Payment payment = paymentRepository.findByOrderId(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("No payment found for order id " + orderId));

        return toResponse(payment);
    }

    private Order findOrderOrThrow(Long orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with id " + orderId));
    }

    private PaymentResponse toResponse(Payment payment) {
        return PaymentResponse.builder()
                .id(payment.getId())
                .orderId(payment.getOrder().getId())
                .amount(payment.getAmount())
                .method(payment.getMethod().name())
                .status(payment.getStatus().name())
                .transactionReference(payment.getTransactionReference())
                .createdAt(payment.getCreatedAt())
                .build();
    }
}
