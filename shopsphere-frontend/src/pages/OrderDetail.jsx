import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { useToast } from '../context/ToastContext'
import { getOrder, cancelOrder, payOrder } from '../services/orders'
import { extractErrorMessage } from '../services/errorUtils'
import OrderStatusBadge from '../components/OrderStatusBadge'
import OrderStatusStepper from '../components/OrderStatusStepper'
import ItemThumbnail from '../components/ItemThumbnail'
import Button from '../components/Button'
import Card from '../components/Card'

const PAYMENT_METHODS = ['CARD', 'UPI', 'NET_BANKING', 'COD']

export default function OrderDetail() {
  const { id } = useParams()
  const { showToast } = useToast()
  const [order, setOrder] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [showPayOptions, setShowPayOptions] = useState(false)
  const [paying, setPaying] = useState(false)
  const [cancelling, setCancelling] = useState(false)

  const load = () => getOrder(id).then(setOrder)

  useEffect(() => {
    load()
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id])

  const handlePay = async (method) => {
    setPaying(true)
    try {
      await payOrder(id, method)
      await load()
      showToast('Payment successful!', 'success')
      setShowPayOptions(false)
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setPaying(false)
    }
  }

  const handleCancel = async () => {
    setCancelling(true)
    try {
      await cancelOrder(id)
      await load()
      showToast('Order cancelled', 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setCancelling(false)
    }
  }

  if (loading) return <p className="px-4 py-16 text-center text-sm text-muted">Loading order…</p>
  if (error) return <p className="px-4 py-16 text-center text-sm text-red-600">{error}</p>
  if (!order) return null

  const addr = order.shippingAddress

  return (
    <div className="mx-auto max-w-3xl px-4 py-8">
      <div className="mb-6 flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-ink">Order #{order.id}</h1>
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
                <Link to={`/products/${item.productId}`} className="text-sm font-medium text-ink hover:text-primary">
                  {item.productName}
                </Link>
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

      {order.status === 'PENDING' && (
        <div className="flex flex-col gap-3">
          {showPayOptions ? (
            <Card>
              <h3 className="mb-3 text-sm font-semibold text-ink">Choose Payment Method</h3>
              <div className="grid grid-cols-2 gap-2">
                {PAYMENT_METHODS.map((m) => (
                  <Button key={m} variant="secondary" disabled={paying} onClick={() => handlePay(m)}>
                    {m.replace('_', ' ')}
                  </Button>
                ))}
              </div>
            </Card>
          ) : (
            <Button onClick={() => setShowPayOptions(true)}>Pay Now</Button>
          )}
          <Button variant="danger" onClick={handleCancel} disabled={cancelling}>
            {cancelling ? 'Cancelling…' : 'Cancel Order'}
          </Button>
        </div>
      )}
    </div>
  )
}
