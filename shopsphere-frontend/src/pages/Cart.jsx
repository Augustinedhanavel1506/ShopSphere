import { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useToast } from '../context/ToastContext'
import { getCart, updateCartItem, removeCartItem, saveForLater, moveToCart } from '../services/cart'
import { extractErrorMessage } from '../services/errorUtils'
import ItemThumbnail from '../components/ItemThumbnail'
import Button from '../components/Button'
import Card from '../components/Card'

export default function Cart() {
  const { showToast } = useToast()
  const navigate = useNavigate()
  const [cart, setCart] = useState(null)
  const [loading, setLoading] = useState(true)

  const load = () => getCart().then(setCart).catch((err) => showToast(extractErrorMessage(err), 'error'))

  useEffect(() => {
    load().finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleQuantityChange = async (productId, quantity) => {
    if (quantity < 1) return
    try {
      const updated = await updateCartItem(productId, quantity)
      setCart(updated)
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleRemove = async (productId) => {
    try {
      const updated = await removeCartItem(productId)
      setCart(updated)
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleSaveForLater = async (productId) => {
    try {
      const updated = await saveForLater(productId)
      setCart(updated)
      showToast('Saved for later', 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleMoveToCart = async (productId) => {
    try {
      const updated = await moveToCart(productId)
      setCart(updated)
      showToast('Moved to cart', 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  if (loading) return <p className="px-4 py-16 text-center text-sm text-muted">Loading cart…</p>

  const items = cart?.items ?? []
  const savedItems = cart?.savedItems ?? []

  return (
    <div className="mx-auto max-w-5xl px-4 py-8">
      <h1 className="mb-6 text-xl font-bold text-ink">My Cart</h1>

      {items.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-slate-300 py-16 text-center text-muted">
          <p className="mb-4">Your cart is empty.</p>
          <Link to="/products">
            <Button>Continue Shopping</Button>
          </Link>
        </div>
      ) : (
        <div className="grid grid-cols-1 gap-8 md:grid-cols-[1fr_320px]">
          <div className="flex flex-col gap-3">
            {items.map((item) => (
              <Card key={item.id} className="flex items-center gap-4">
                <Link to={`/products/${item.productId}`}>
                  <ItemThumbnail productId={item.productId} />
                </Link>
                <div className="flex-1">
                  <Link to={`/products/${item.productId}`} className="font-semibold text-ink hover:text-primary">
                    {item.productName}
                  </Link>
                  <p className="text-sm text-muted">${Number(item.unitPrice).toFixed(2)} each</p>
                  <div className="mt-2 flex items-center gap-3">
                    <div className="flex items-center rounded-lg border border-slate-300">
                      <button
                        onClick={() => handleQuantityChange(item.productId, item.quantity - 1)}
                        className="px-2.5 py-1 text-ink hover:bg-slate-50"
                      >
                        −
                      </button>
                      <span className="w-8 text-center text-sm">{item.quantity}</span>
                      <button
                        onClick={() => handleQuantityChange(item.productId, item.quantity + 1)}
                        className="px-2.5 py-1 text-ink hover:bg-slate-50"
                      >
                        +
                      </button>
                    </div>
                    <button
                      onClick={() => handleSaveForLater(item.productId)}
                      className="text-xs font-medium text-primary hover:underline"
                    >
                      Save for later
                    </button>
                    <button
                      onClick={() => handleRemove(item.productId)}
                      className="text-xs font-medium text-red-600 hover:underline"
                    >
                      Remove
                    </button>
                  </div>
                </div>
                <span className="font-bold text-ink">${Number(item.lineTotal).toFixed(2)}</span>
              </Card>
            ))}

            {savedItems.length > 0 && (
              <div className="mt-6">
                <h2 className="mb-3 text-sm font-semibold uppercase tracking-wide text-muted">Saved for Later</h2>
                <div className="flex flex-col gap-3">
                  {savedItems.map((item) => (
                    <Card key={item.id} className="flex items-center gap-4">
                      <ItemThumbnail productId={item.productId} />
                      <div className="flex-1">
                        <p className="font-semibold text-ink">{item.productName}</p>
                        <p className="text-sm text-muted">${Number(item.unitPrice).toFixed(2)}</p>
                        <div className="mt-2 flex gap-3">
                          <button
                            onClick={() => handleMoveToCart(item.productId)}
                            className="text-xs font-medium text-primary hover:underline"
                          >
                            Move to cart
                          </button>
                          <button
                            onClick={() => handleRemove(item.productId)}
                            className="text-xs font-medium text-red-600 hover:underline"
                          >
                            Remove
                          </button>
                        </div>
                      </div>
                    </Card>
                  ))}
                </div>
              </div>
            )}
          </div>

          <Card className="h-fit">
            <h2 className="mb-4 text-sm font-semibold uppercase tracking-wide text-muted">Order Summary</h2>
            <div className="mb-4 flex justify-between text-sm">
              <span className="text-muted">Subtotal ({cart.totalItems} items)</span>
              <span className="font-semibold text-ink">${Number(cart.totalPrice).toFixed(2)}</span>
            </div>
            <Button onClick={() => navigate('/checkout')} className="w-full">
              Proceed to Checkout
            </Button>
          </Card>
        </div>
      )}
    </div>
  )
}
