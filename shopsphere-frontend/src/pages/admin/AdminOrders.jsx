import { useEffect, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import { getAllOrdersAdmin } from '../../services/orders'
import { extractErrorMessage } from '../../services/errorUtils'
import { useToast } from '../../context/ToastContext'
import Card from '../../components/Card'
import OrderStatusBadge from '../../components/OrderStatusBadge'

const STATUSES = ['', 'PENDING', 'PAID', 'CONFIRMED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED']

export default function AdminOrders() {
  const { showToast } = useToast()
  const [searchParams, setSearchParams] = useSearchParams()
  const [status, setStatus] = useState(searchParams.get('status') || '')
  const [orders, setOrders] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    setStatus(searchParams.get('status') || '')
  }, [searchParams])

  useEffect(() => {
    setLoading(true)
    getAllOrdersAdmin(status || undefined)
      .then(setOrders)
      .catch((err) => showToast(extractErrorMessage(err), 'error'))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [status])

  return (
    <div>
      <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-xl font-bold text-ink">Orders</h1>
        <select
          value={status}
          onChange={(e) => setSearchParams(e.target.value ? { status: e.target.value } : {})}
          className="rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
        >
          {STATUSES.map((s) => (
            <option key={s || 'all'} value={s}>
              {s || 'All Statuses'}
            </option>
          ))}
        </select>
      </div>

      {loading ? (
        <p className="text-sm text-muted">Loading orders…</p>
      ) : orders.length === 0 ? (
        <p className="text-sm text-muted">No orders found.</p>
      ) : (
        <div className="flex flex-col gap-3">
          {orders.map((order) => (
            <Card key={order.id} className="flex items-center justify-between gap-4">
              <div>
                <div className="mb-1 flex items-center gap-2">
                  <span className="font-semibold text-ink">Order #{order.id}</span>
                  <OrderStatusBadge status={order.status} />
                </div>
                <p className="text-xs text-muted">
                  {order.customerEmail} · {new Date(order.createdAt).toLocaleDateString()}
                </p>
                <p className="text-sm text-ink">${Number(order.totalAmount).toFixed(2)}</p>
              </div>
              <Link to={`/admin/orders/${order.id}`} className="text-sm font-medium text-primary hover:underline">
                Manage
              </Link>
            </Card>
          ))}
        </div>
      )}
    </div>
  )
}
