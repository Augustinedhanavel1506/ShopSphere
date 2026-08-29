import api from './api'

export function getInventory(productId) {
  return api.get(`/api/inventory/${productId}`).then((res) => res.data)
}

export function setInventoryQuantity(productId, quantity) {
  return api.put(`/api/inventory/${productId}`, { quantity }).then((res) => res.data)
}

export function adjustInventoryQuantity(productId, delta) {
  return api.post(`/api/inventory/${productId}/adjust`, { delta }).then((res) => res.data)
}

export function getInventoryHistory(productId) {
  return api.get(`/api/inventory/${productId}/history`).then((res) => res.data)
}
