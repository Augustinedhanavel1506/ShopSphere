import api from './api'

export function checkout(payload) {
  return api.post('/api/orders', payload).then((res) => res.data)
}

export function getMyOrders() {
  return api.get('/api/orders').then((res) => res.data)
}

export function getOrder(id) {
  return api.get(`/api/orders/${id}`).then((res) => res.data)
}

export function cancelOrder(id) {
  return api.put(`/api/orders/${id}/cancel`).then((res) => res.data)
}

export function payOrder(id, method) {
  return api.post(`/api/orders/${id}/pay`, { method }).then((res) => res.data)
}

export function getPayment(id) {
  return api.get(`/api/orders/${id}/payment`).then((res) => res.data)
}

export function validateCoupon(code, orderTotal) {
  return api.get('/api/coupons/validate', { params: { code, orderTotal } }).then((res) => res.data)
}
