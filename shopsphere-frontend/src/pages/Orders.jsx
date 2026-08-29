import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { getMyOrders } from '../services/orders'
import { extractErrorMessage } from '../services/errorUtils'
import OrderStatusBadge from '../components/OrderStatusBadge'
import Card from '../components/Card'
import Button from '../components/Button'

export default function Orders() {
  const [orders, setOrders] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    getMyOrders()
      .then(setOrders)
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
  }, [])

  if (loading) return <p className="px-4 py-16 text-center text-sm text-muted">Loading orders…</p>
  if (error) return <p className="px-4 py-16 text-center text-sm text-red-600">{error}</p>

  return (
    <div className="mx-auto max-w-3xl px-4 py-8">
      <h1 className="mb-6 text-xl font-bold text-ink">My Orders</h1>

      {orders.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-slate-300 py-16 text-center text-muted">
          <p className="mb-4">You haven't placed any orders yet.</p>
          <Link to="/products">
            <Button>Start Shopping</Button>
          </Link>
        </div>
      ) : (
        <div className="flex flex-col gap-3">
          {orders.map((order) => (
            <Card key={order.id} className="flex items-center justify-between gap-4">
              <div>
                <div className="mb-1 flex items-center gap-2">
                  <span className="font-semibold text-ink">Order #{order.id}</span>
                  <OrderStatusBadge status={order.status} />
                </div>
                <p className="text-xs text-muted">{new Date(order.createdAt).toLocaleDateString()}</p>
                <p className="text-sm text-ink">${Number(order.totalAmount).toFixed(2)}</p>
              </div>
              <Link to={`/orders/${order.id}`} className="text-sm font-medium text-primary hover:underline">
                View Details
              </Link>
            </Card>
          ))}
        </div>
      )}
    </div>
  )
}
