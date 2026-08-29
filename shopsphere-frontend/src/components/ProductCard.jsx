import { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { useToast } from '../context/ToastContext'
import { addToCart } from '../services/cart'
import { addToWishlist } from '../services/wishlist'
import { getInventory } from '../services/inventory'
import { extractErrorMessage } from '../services/errorUtils'
import Button from './Button'
import Badge from './Badge'

export default function ProductCard({ product }) {
  const { user } = useAuth()
  const { showToast } = useToast()
  const navigate = useNavigate()
  const [inStock, setInStock] = useState(null)

  useEffect(() => {
    let cancelled = false
    getInventory(product.id)
      .then((inv) => {
        if (!cancelled) setInStock(inv.inStock)
      })
      .catch(() => {
        if (!cancelled) setInStock(null)
      })
    return () => {
      cancelled = true
    }
  }, [product.id])

  const image = product.images?.[0]?.imageUrl
  const hasDiscount = product.originalPrice && product.discountPercentage

  const requireAuth = () => {
    if (!user) {
      navigate('/login', { state: { from: '/products' } })
      return false
    }
    return true
  }

  const handleAddToCart = async (e) => {
    e.preventDefault()
    if (!requireAuth()) return
    try {
      await addToCart(product.id, 1)
      showToast(`${product.name} added to cart`, 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleAddToWishlist = async (e) => {
    e.preventDefault()
    if (!requireAuth()) return
    try {
      await addToWishlist(product.id)
      showToast(`${product.name} added to wishlist`, 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  return (
    <Link
      to={`/products/${product.id}`}
      className="group flex flex-col overflow-hidden rounded-2xl border border-slate-200 bg-surface shadow-sm transition-shadow hover:shadow-md"
    >
      <div className="relative flex aspect-square items-center justify-center bg-slate-50">
        {hasDiscount && (
          <span className="absolute left-2 top-2 rounded-full bg-cta px-2 py-0.5 text-xs font-bold text-white">
            -{product.discountPercentage}%
          </span>
        )}
        <button
          onClick={handleAddToWishlist}
          className="absolute right-2 top-2 flex h-8 w-8 items-center justify-center rounded-full bg-white/90 text-ink shadow hover:bg-white"
          aria-label="Add to wishlist"
        >
          ♡
        </button>
        {image ? (
          <img src={image} alt={product.name} className="h-full w-full object-cover" />
        ) : (
          <span className="text-4xl">📦</span>
        )}
      </div>

      <div className="flex flex-1 flex-col gap-1.5 p-4">
        <h3 className="line-clamp-1 text-sm font-semibold text-ink">{product.name}</h3>

        <div className="flex items-center gap-2">
          <span className="text-base font-bold text-ink">${Number(product.price).toFixed(2)}</span>
          {hasDiscount && (
            <span className="text-xs text-muted line-through">${Number(product.originalPrice).toFixed(2)}</span>
          )}
        </div>

        {product.active === false ? (
          <Badge tone="neutral">Unavailable</Badge>
        ) : inStock === false ? (
          <Badge tone="danger">Out of Stock</Badge>
        ) : inStock === true ? (
          <Badge tone="success">In Stock</Badge>
        ) : null}

        <Button
          onClick={handleAddToCart}
          disabled={product.active === false || inStock === false}
          className="mt-2 w-full"
          variant="primary"
        >
          Add to Cart
        </Button>
      </div>
    </Link>
  )
}
