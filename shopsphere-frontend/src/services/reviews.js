import api from './api'

export function getReviews(productId) {
  return api.get(`/api/reviews/products/${productId}`).then((res) => res.data)
}

export function createReview(productId, payload) {
  return api.post(`/api/reviews/products/${productId}`, payload).then((res) => res.data)
}

export function updateReview(productId, payload) {
  return api.put(`/api/reviews/products/${productId}`, payload).then((res) => res.data)
}

export function deleteReview(reviewId) {
  return api.delete(`/api/reviews/${reviewId}`)
}
