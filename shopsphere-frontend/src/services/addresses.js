import api from './api'

export function getAddresses() {
  return api.get('/api/addresses').then((res) => res.data)
}

export function createAddress(payload) {
  return api.post('/api/addresses', payload).then((res) => res.data)
}

export function updateAddress(id, payload) {
  return api.put(`/api/addresses/${id}`, payload).then((res) => res.data)
}

export function deleteAddress(id) {
  return api.delete(`/api/addresses/${id}`)
}

export function setDefaultAddress(id) {
  return api.put(`/api/addresses/${id}/default`).then((res) => res.data)
}
