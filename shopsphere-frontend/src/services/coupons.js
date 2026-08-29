import api from './api'

export function getCoupons() {
  return api.get('/api/coupons').then((res) => res.data)
}

export function createCoupon(payload) {
  return api.post('/api/coupons', payload).then((res) => res.data)
}

export function updateCoupon(id, payload) {
  return api.put(`/api/coupons/${id}`, payload).then((res) => res.data)
}

export function deleteCoupon(id) {
  return api.delete(`/api/coupons/${id}`).then((res) => res.data)
}
