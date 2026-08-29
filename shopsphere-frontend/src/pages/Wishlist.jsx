import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { useToast } from '../context/ToastContext'
import { getWishlist, removeFromWishlist } from '../services/wishlist'
import { addToCart } from '../services/cart'
import { extractErrorMessage } from '../services/errorUtils'
import ItemThumbnail from '../components/ItemThumbnail'
import Button from '../components/Button'
import Card from '../components/Card'

export default function Wishlist() {
  const { showToast } = useToast()
  const [wishlist, setWishlist] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    getWishlist()
      .then(setWishlist)
      .catch((err) => showToast(extractErrorMessage(err), 'error'))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleRemove = async (productId) => {
    try {
      const updated = await removeFromWishlist(productId)
      setWishlist(updated)
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleMoveToCart = async (productId) => {
    try {
      await addToCart(productId, 1)
      await handleRemove(productId)
      showToast('Moved to cart', 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  if (loading) return <p className="px-4 py-16 text-center text-sm text-muted">Loading wishlist…</p>

  const items = wishlist?.items ?? []

  return (
    <div className="mx-auto max-w-3xl px-4 py-8">
      <h1 className="mb-6 text-xl font-bold text-ink">My Wishlist</h1>

      {items.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-slate-300 py-16 text-center text-muted">
          <p className="mb-4">Your wishlist is empty.</p>
          <Link to="/products">
            <Button>Browse Products</Button>
          </Link>
        </div>
      ) : (
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
                <p className="text-sm text-muted">${Number(item.price).toFixed(2)}</p>
              </div>
              <Button variant="secondary" onClick={() => handleMoveToCart(item.productId)}>
                Move to Cart
              </Button>
              <button
                onClick={() => handleRemove(item.productId)}
                className="text-xs font-medium text-red-600 hover:underline"
              >
                Remove
              </button>
            </Card>
          ))}
        </div>
      )}
    </div>
  )
}
