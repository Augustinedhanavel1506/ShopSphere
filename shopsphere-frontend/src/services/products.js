import api from './api'

export function getProducts({ categoryId } = {}) {
  return api.get('/api/products', { params: categoryId ? { categoryId } : {} }).then((res) => res.data)
}

export function searchProducts(q) {
  return api.get('/api/products/search', { params: { q } }).then((res) => res.data)
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
