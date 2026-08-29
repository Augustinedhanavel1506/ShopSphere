import { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useToast } from '../context/ToastContext'
import { getCart } from '../services/cart'
import { getAddresses } from '../services/addresses'
import { checkout, validateCoupon } from '../services/orders'
import { extractErrorMessage } from '../services/errorUtils'
import Button from '../components/Button'
import Card from '../components/Card'

export default function Checkout() {
  const { showToast } = useToast()
  const navigate = useNavigate()

  const [cart, setCart] = useState(null)
  const [addresses, setAddresses] = useState([])
  const [selectedAddressId, setSelectedAddressId] = useState(null)
  const [couponInput, setCouponInput] = useState('')
  const [appliedCoupon, setAppliedCoupon] = useState(null)
  const [couponError, setCouponError] = useState('')
  const [loading, setLoading] = useState(true)
  const [placing, setPlacing] = useState(false)

  useEffect(() => {
    Promise.all([getCart(), getAddresses()])
      .then(([cartData, addressList]) => {
        setCart(cartData)
        setAddresses(addressList)
        const defaultAddress = addressList.find((a) => a.isDefault) ?? addressList[0]
        if (defaultAddress) setSelectedAddressId(defaultAddress.id)
      })
      .catch((err) => showToast(extractErrorMessage(err), 'error'))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleApplyCoupon = async () => {
    setCouponError('')
    if (!couponInput.trim()) return
    try {
      const preview = await validateCoupon(couponInput.trim(), cart.totalPrice)
      setAppliedCoupon(preview)
    } catch (err) {
      setAppliedCoupon(null)
      setCouponError(extractErrorMessage(err))
    }
  }

  const handlePlaceOrder = async () => {
    if (!selectedAddressId) {
      showToast('Please select a shipping address', 'error')
      return
    }
    setPlacing(true)
    try {
      const order = await checkout({
        addressId: selectedAddressId,
        couponCode: appliedCoupon?.code,
      })
      showToast('Order placed successfully!', 'success')
      navigate(`/orders/${order.id}`)
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setPlacing(false)
    }
  }

  if (loading) return <p className="px-4 py-16 text-center text-sm text-muted">Loading checkout…</p>

  if (!cart || cart.items.length === 0) {
    return (
      <div className="mx-auto max-w-md px-4 py-16 text-center">
        <p className="mb-4 text-muted">Your cart is empty.</p>
        <Link to="/products">
          <Button>Continue Shopping</Button>
        </Link>
      </div>
    )
  }

  const discount = appliedCoupon?.discountAmount ?? 0
  const estimatedTotal = cart.totalPrice - discount

  return (
    <div className="mx-auto max-w-5xl px-4 py-8">
      <h1 className="mb-6 text-xl font-bold text-ink">Checkout</h1>

      <div className="grid grid-cols-1 gap-8 md:grid-cols-[1fr_320px]">
        <div className="flex flex-col gap-6">
          <Card>
            <div className="mb-3 flex items-center justify-between">
              <h2 className="text-sm font-semibold uppercase tracking-wide text-muted">Shipping Address</h2>
              <Link to="/addresses" className="text-xs font-medium text-primary hover:underline">
                Manage Addresses
              </Link>
            </div>

            {addresses.length === 0 ? (
              <p className="text-sm text-muted">
                No saved addresses.{' '}
                <Link to="/addresses" className="font-medium text-primary hover:underline">
                  Add one
                </Link>{' '}
                to continue.
              </p>
            ) : (
              <div className="flex flex-col gap-2">
                {addresses.map((addr) => (
                  <label
                    key={addr.id}
                    className={`flex cursor-pointer items-start gap-3 rounded-xl border p-3 ${
                      selectedAddressId === addr.id ? 'border-primary bg-indigo-50/50' : 'border-slate-200'
                    }`}
                  >
                    <input
                      type="radio"
                      name="address"
                      checked={selectedAddressId === addr.id}
                      onChange={() => setSelectedAddressId(addr.id)}
                      className="mt-1"
                    />
                    <div className="text-sm">
                      <p className="font-semibold text-ink">
                        {addr.fullName} {addr.isDefault && <span className="text-xs text-primary">(Default)</span>}
                      </p>
                      <p className="text-muted">
                        {addr.line1}
                        {addr.line2 ? `, ${addr.line2}` : ''}, {addr.city}, {addr.state} {addr.postalCode},{' '}
                        {addr.country}
                      </p>
                    </div>
                  </label>
                ))}
              </div>
            )}
          </Card>

          <Card>
            <h2 className="mb-3 text-sm font-semibold uppercase tracking-wide text-muted">Order Items</h2>
            <div className="flex flex-col gap-2">
              {cart.items.map((item) => (
                <div key={item.id} className="flex justify-between text-sm">
                  <span className="text-ink">
                    {item.productName} × {item.quantity}
                  </span>
                  <span className="text-muted">${Number(item.lineTotal).toFixed(2)}</span>
                </div>
              ))}
            </div>
          </Card>
        </div>

        <Card className="h-fit">
          <h2 className="mb-4 text-sm font-semibold uppercase tracking-wide text-muted">Order Summary</h2>

          <div className="mb-4 flex gap-2">
            <input
              value={couponInput}
              onChange={(e) => setCouponInput(e.target.value)}
              placeholder="Coupon code"
              className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
            />
            <button
              onClick={handleApplyCoupon}
              className="rounded-lg border border-slate-300 px-3 py-2 text-sm font-medium text-ink hover:bg-slate-50"
            >
              Apply
            </button>
          </div>
          {couponError && <p className="mb-3 text-xs text-red-600">{couponError}</p>}
          {appliedCoupon && (
            <p className="mb-3 text-xs text-success">Coupon "{appliedCoupon.code}" applied!</p>
          )}

          <div className="flex flex-col gap-2 border-t border-slate-100 pt-3 text-sm">
            <div className="flex justify-between">
              <span className="text-muted">Subtotal</span>
              <span className="text-ink">${Number(cart.totalPrice).toFixed(2)}</span>
            </div>
            {discount > 0 && (
              <div className="flex justify-between">
                <span className="text-muted">Discount</span>
                <span className="text-success">-${Number(discount).toFixed(2)}</span>
              </div>
            )}
            <div className="flex justify-between border-t border-slate-100 pt-2 text-base font-bold">
              <span className="text-ink">Estimated Total</span>
              <span className="text-ink">${Number(estimatedTotal).toFixed(2)}</span>
            </div>
            <p className="text-xs text-muted">Tax will be calculated at checkout.</p>
          </div>

          <Button onClick={handlePlaceOrder} disabled={placing || !selectedAddressId} className="mt-4 w-full">
            {placing ? 'Placing Order…' : 'Place Order'}
          </Button>
        </Card>
      </div>
    </div>
  )
}
