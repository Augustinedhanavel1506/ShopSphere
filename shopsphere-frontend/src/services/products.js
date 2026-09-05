import api from './api'

export function getProducts({ categoryId, page = 0, size = 20 } = {}) {
  return api.get('/api/products', { params: { categoryId, page, size } }).then((res) => res.data)
}

export function searchProducts(q, { page = 0, size = 20 } = {}) {
  return api.get('/api/products/search', { params: { q, page, size } }).then((res) => res.data)
}

export function getProduct(id) {
  return api.get(`/api/products/${id}`).then((res) => res.data)
}

export function createProduct(payload) {
  return api.post('/api/products', payload).then((res) => res.data)
}

export function updateProduct(id, payload) {
  return api.put(`/api/products/${id}`, payload).then((res) => res.data)
}

export function deleteProduct(id) {
  return api.delete(`/api/products/${id}`).then((res) => res.data)
}
