import api from './api'

export function getInventory(productId) {
  return api.get(`/api/inventory/${productId}`).then((res) => res.data)
}
