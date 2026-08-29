import api from './api'

export function getCart() {
  return api.get('/api/cart').then((res) => res.data)
}

export function addToCart(productId, quantity = 1) {
  return api.post('/api/cart/items', { productId, quantity }).then((res) => res.data)
}

export function updateCartItem(productId, quantity) {
  return api.put(`/api/cart/items/${productId}`, { quantity }).then((res) => res.data)
}

export function removeCartItem(productId) {
  return api.delete(`/api/cart/items/${productId}`).then((res) => res.data)
}

export function clearCart() {
  return api.delete('/api/cart')
}

export function saveForLater(productId) {
  return api.post(`/api/cart/items/${productId}/save-for-later`).then((res) => res.data)
}

export function moveToCart(productId) {
  return api.post(`/api/cart/items/${productId}/move-to-cart`).then((res) => res.data)
}
