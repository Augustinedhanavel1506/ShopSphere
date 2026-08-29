import api from './api'

export function uploadImage(file) {
  const formData = new FormData()
  formData.append('file', file)
  return api.post('/api/uploads', formData).then((res) => res.data)
}
