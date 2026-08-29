import api from './api'

export function getCategories() {
  return api.get('/api/categories').then((res) => res.data)
}

export function createCategory(payload) {
  return api.post('/api/categories', payload).then((res) => res.data)
}

export function updateCategory(id, payload) {
  return api.put(`/api/categories/${id}`, payload).then((res) => res.data)
}

export function deleteCategory(id) {
  return api.delete(`/api/categories/${id}`).then((res) => res.data)
}
