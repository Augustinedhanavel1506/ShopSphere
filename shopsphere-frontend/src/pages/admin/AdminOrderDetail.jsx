import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { useToast } from '../../context/ToastContext'
import { getOrder, updateOrderStatus } from '../../services/orders'
import { extractErrorMessage } from '../../services/errorUtils'
import OrderStatusBadge from '../../components/OrderStatusBadge'
import OrderStatusStepper from '../../components/OrderStatusStepper'
import ItemThumbnail from '../../components/ItemThumbnail'
import Button from '../../components/Button'
import Card from '../../components/Card'

const ALLOWED_TRANSITIONS = {
  PAID: ['CONFIRMED', 'CANCELLED'],
  CONFIRMED: ['PROCESSING', 'CANCELLED'],
  PROCESSING: ['SHIPPED', 'CANCELLED'],
  SHIPPED: ['DELIVERED'],
}

export default function AdminOrderDetail() {
  const { id } = useParams()
  const { showToast } = useToast()
  const [order, setOrder] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [updating, setUpdating] = useState(false)
  const [shipTarget, setShipTarget] = useState(false)
  const [trackingNumber, setTrackingNumber] = useState('')
  const [carrier, setCarrier] = useState('')

  const load = () => getOrder(id).then(setOrder)

  useEffect(() => {
    load()
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id])

  const handleTransition = async (target) => {
    if (target === 'SHIPPED' && !shipTarget) {
      setShipTarget(true)
      return
    }
    setUpdating(true)
    try {
      await updateOrderStatus(id, { status: target, trackingNumber: trackingNumber || undefined, carrier: carrier || undefined })
      await load()
      showToast(`Order marked as ${target}`, 'success')
      setShipTarget(false)
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setUpdating(false)
    }
  }

  if (loading) return <p className="text-sm text-muted">Loading order…</p>
  if (error) return <p className="text-sm text-red-600">{error}</p>
  if (!order) return null

  const addr = order.shippingAddress
  const nextStatuses = ALLOWED_TRANSITIONS[order.status] ?? []

  return (
    <div className="mx-auto max-w-3xl">
      <Link to="/admin/orders" className="mb-4 inline-block text-sm font-medium text-primary hover:underline">
        ← Back to Orders
      </Link>

      <div className="mb-6 flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-ink">Order #{order.id}</h1>
          <p className="text-xs text-muted">{order.customerEmail}</p>
          <p className="text-xs text-muted">Placed on {new Date(order.createdAt).toLocaleString()}</p>
        </div>
        <OrderStatusBadge status={order.status} />
      </div>

      <Card className="mb-6">
        <OrderStatusStepper status={order.status} />
      </Card>

      {order.trackingNumber && (
        <Card className="mb-6">
          <h2 className="mb-1 text-sm font-semibold uppercase tracking-wide text-muted">Tracking</h2>
          <p className="text-sm text-ink">
            {order.carrier} — {order.trackingNumber}
          </p>
        </Card>
      )}

      <Card className="mb-6">
        <h2 className="mb-2 text-sm font-semibold uppercase tracking-wide text-muted">Shipping Address</h2>
        <p className="text-sm text-ink">{addr.fullName}</p>
        <p className="text-sm text-muted">
          {addr.line1}
          {addr.line2 ? `, ${addr.line2}` : ''}, {addr.city}, {addr.state} {addr.postalCode}, {addr.country}
        </p>
        <p className="text-sm text-muted">{addr.phone}</p>
      </Card>

      <Card className="mb-6">
        <h2 className="mb-3 text-sm font-semibold uppercase tracking-wide text-muted">Items</h2>
        <div className="flex flex-col gap-3">
          {order.items.map((item) => (
            <div key={item.id} className="flex items-center gap-3">
              <ItemThumbnail productId={item.productId} className="h-12 w-12" />
              <div className="flex-1">
                <span className="text-sm font-medium text-ink">{item.productName}</span>
                <p className="text-xs text-muted">
                  ${Number(item.unitPrice).toFixed(2)} × {item.quantity}
                </p>
              </div>
              <span className="text-sm font-semibold text-ink">${Number(item.lineTotal).toFixed(2)}</span>
            </div>
          ))}
        </div>

        <div className="mt-4 flex flex-col gap-1 border-t border-slate-100 pt-3 text-sm">
          <div className="flex justify-between text-muted">
            <span>Subtotal</span>
            <span>${Number(order.subtotal).toFixed(2)}</span>
          </div>
          {order.discountAmount > 0 && (
            <div className="flex justify-between text-success">
              <span>Discount {order.couponCode ? `(${order.couponCode})` : ''}</span>
              <span>-${Number(order.discountAmount).toFixed(2)}</span>
            </div>
          )}
          <div className="flex justify-between text-muted">
            <span>Tax</span>
            <span>${Number(order.taxAmount).toFixed(2)}</span>
          </div>
          <div className="flex justify-between text-base font-bold text-ink">
            <span>Total</span>
            <span>${Number(order.totalAmount).toFixed(2)}</span>
          </div>
        </div>
      </Card>

      {nextStatuses.length > 0 && (
        <Card>
          <h2 className="mb-3 text-sm font-semibold uppercase tracking-wide text-muted">Update Status</h2>

          {shipTarget && (
            <div className="mb-4 flex flex-col gap-3">
              <input
                value={carrier}
                onChange={(e) => setCarrier(e.target.value)}
                placeholder="Carrier (e.g. UPS)"
                className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
              />
              <input
                value={trackingNumber}
                onChange={(e) => setTrackingNumber(e.target.value)}
                placeholder="Tracking number"
                className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
              />
            </div>
          )}

          <div className="flex flex-wrap gap-2">
            {nextStatuses.map((target) => (
              <Button
                key={target}
                variant={target === 'CANCELLED' ? 'danger' : 'primary'}
                disabled={updating}
                onClick={() => handleTransition(target)}
              >
                {target === 'SHIPPED' && shipTarget ? 'Confirm Ship' : `Mark ${target}`}
              </Button>
            ))}
          </div>
        </Card>
      )}
    </div>
  )
}
