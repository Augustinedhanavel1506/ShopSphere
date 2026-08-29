import api from './api'

export function getDashboardSummary({ period, from, to, lowStockThreshold } = {}) {
  return api
    .get('/api/admin/dashboard/summary', { params: { period, from, to, lowStockThreshold } })
    .then((res) => res.data)
}

export function getLowStockProducts(threshold = 5) {
  return api.get('/api/admin/dashboard/low-stock', { params: { threshold } }).then((res) => res.data)
}

export function getRecentOrders({ limit = 10, period, from, to } = {}) {
  return api
    .get('/api/admin/dashboard/recent-orders', { params: { limit, period, from, to } })
    .then((res) => res.data)
}
