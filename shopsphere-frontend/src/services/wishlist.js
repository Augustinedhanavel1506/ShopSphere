import api from './api'

export function getWishlist() {
  return api.get('/api/wishlist').then((res) => res.data)
}

export function addToWishlist(productId) {
  return api.post('/api/wishlist/items', { productId }).then((res) => res.data)
}

export function removeFromWishlist(productId) {
  return api.delete(`/api/wishlist/items/${productId}`).then((res) => res.data)
}
