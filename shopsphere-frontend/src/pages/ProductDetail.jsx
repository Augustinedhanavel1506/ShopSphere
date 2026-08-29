import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { useToast } from '../context/ToastContext'
import { getProduct } from '../services/products'
import { getInventory } from '../services/inventory'
import { getReviews, createReview, updateReview, deleteReview } from '../services/reviews'
import { addToCart } from '../services/cart'
import { addToWishlist } from '../services/wishlist'
import { extractErrorMessage } from '../services/errorUtils'
import Button from '../components/Button'
import Badge from '../components/Badge'
import Card from '../components/Card'

function StarRating({ value, onChange }) {
  return (
    <div className="flex gap-1">
      {[1, 2, 3, 4, 5].map((n) => (
        <button
          key={n}
          type="button"
          onClick={() => onChange?.(n)}
          className={`text-xl ${n <= value ? 'text-warning' : 'text-slate-300'} ${onChange ? 'cursor-pointer' : ''}`}
          disabled={!onChange}
        >
          ★
        </button>
      ))}
    </div>
  )
}

export default function ProductDetail() {
  const { id } = useParams()
  const { user, isAdmin } = useAuth()
  const { showToast } = useToast()
  const navigate = useNavigate()

  const [product, setProduct] = useState(null)
  const [inventory, setInventory] = useState(null)
  const [reviewData, setReviewData] = useState({ averageRating: 0, totalReviews: 0, reviews: [] })
  const [activeImage, setActiveImage] = useState(0)
  const [quantity, setQuantity] = useState(1)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [reviewForm, setReviewForm] = useState({ rating: 5, comment: '' })
  const [reviewSubmitting, setReviewSubmitting] = useState(false)

  const loadReviews = () => getReviews(id).then(setReviewData)

  useEffect(() => {
    setLoading(true)
    setError('')
    Promise.all([getProduct(id), getInventory(id).catch(() => null), loadReviews()])
      .then(([p, inv]) => {
        setProduct(p)
        setInventory(inv)
      })
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id])

  const myReview = reviewData.reviews.find((r) => r.userId === user?.id)

  const requireAuth = () => {
    if (!user) {
      navigate('/login', { state: { from: `/products/${id}` } })
      return false
    }
    return true
  }

  const handleAddToCart = async () => {
    if (!requireAuth()) return
    try {
      await addToCart(product.id, quantity)
      showToast(`${product.name} added to cart`, 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleAddToWishlist = async () => {
    if (!requireAuth()) return
    try {
      await addToWishlist(product.id)
      showToast(`${product.name} added to wishlist`, 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleReviewSubmit = async (e) => {
    e.preventDefault()
    if (!requireAuth()) return
    setReviewSubmitting(true)
    try {
      if (myReview) {
        await updateReview(id, reviewForm)
        showToast('Review updated', 'success')
      } else {
        await createReview(id, reviewForm)
        showToast('Review submitted', 'success')
      }
      await loadReviews()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setReviewSubmitting(false)
    }
  }

  const handleDeleteReview = async (reviewId) => {
    try {
      await deleteReview(reviewId)
      showToast('Review deleted', 'success')
      await loadReviews()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  if (loading) return <p className="px-4 py-16 text-center text-sm text-muted">Loading…</p>
  if (error) return <p className="px-4 py-16 text-center text-sm text-red-600">{error}</p>
  if (!product) return null

  const images = product.images?.length ? product.images : [{ imageUrl: null }]
  const hasDiscount = product.originalPrice && product.discountPercentage

  return (
    <div className="mx-auto max-w-6xl px-4 py-8">
      <div className="grid grid-cols-1 gap-10 md:grid-cols-2">
        <div>
          <div className="flex aspect-square items-center justify-center overflow-hidden rounded-2xl bg-slate-50">
            {images[activeImage]?.imageUrl ? (
              <img src={images[activeImage].imageUrl} alt={product.name} className="h-full w-full object-cover" />
            ) : (
              <span className="text-6xl">📦</span>
            )}
          </div>
          {images.length > 1 && (
            <div className="mt-3 flex gap-2">
              {images.map((img, i) => (
                <button
                  key={img.id ?? i}
                  onClick={() => setActiveImage(i)}
                  className={`h-16 w-16 overflow-hidden rounded-lg border-2 ${
                    i === activeImage ? 'border-primary' : 'border-transparent'
                  }`}
                >
                  <img src={img.imageUrl} alt="" className="h-full w-full object-cover" />
                </button>
              ))}
            </div>
          )}
        </div>

        <div>
          <h1 className="mb-2 text-2xl font-bold text-ink">{product.name}</h1>

          <div className="mb-2 flex items-center gap-2 text-sm text-muted">
            <span>
              {reviewData.averageRating > 0 ? '★'.repeat(Math.round(reviewData.averageRating)) : 'No ratings yet'}
            </span>
            {reviewData.totalReviews > 0 && (
              <span>
                {reviewData.averageRating.toFixed(1)} ({reviewData.totalReviews} review
                {reviewData.totalReviews === 1 ? '' : 's'})
              </span>
            )}
          </div>

          <div className="mb-3 flex items-center gap-3">
            <span className="text-2xl font-extrabold text-ink">${Number(product.price).toFixed(2)}</span>
            {hasDiscount && (
              <>
                <span className="text-base text-muted line-through">${Number(product.originalPrice).toFixed(2)}</span>
                <Badge tone="danger">-{product.discountPercentage}%</Badge>
              </>
            )}
          </div>

          <div className="mb-4">
            {inventory?.inStock ? <Badge tone="success">In Stock</Badge> : <Badge tone="danger">Out of Stock</Badge>}
          </div>

          {product.description && <p className="mb-4 text-sm text-muted">{product.description}</p>}

          <div className="mb-4 flex items-center gap-3">
            <label className="text-sm font-medium text-ink" htmlFor="qty">
              Quantity
            </label>
            <input
              id="qty"
              type="number"
              min={1}
              value={quantity}
              onChange={(e) => setQuantity(Math.max(1, Number(e.target.value)))}
              className="w-20 rounded-lg border border-slate-300 px-2 py-1.5 text-sm"
            />
          </div>

          <div className="flex gap-3">
            <Button onClick={handleAddToCart} disabled={!inventory?.inStock} className="flex-1">
              Add to Cart
            </Button>
            <Button onClick={handleAddToWishlist} variant="secondary">
              ♡ Wishlist
            </Button>
          </div>

          {product.specifications?.length > 0 && (
            <div className="mt-8">
              <h2 className="mb-2 text-sm font-semibold uppercase tracking-wide text-muted">Specifications</h2>
              <table className="w-full text-sm">
                <tbody>
                  {product.specifications.map((spec) => (
                    <tr key={spec.id} className="border-b border-slate-100">
                      <td className="py-2 pr-4 font-medium text-ink">{spec.key}</td>
                      <td className="py-2 text-muted">{spec.value}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>

      <div className="mt-12">
        <h2 className="mb-4 text-lg font-bold text-ink">Reviews</h2>

        {user && !isAdmin && (
          <Card className="mb-6">
            <h3 className="mb-3 text-sm font-semibold text-ink">
              {myReview ? 'Update your review' : 'Write a review'}
            </h3>
            <form onSubmit={handleReviewSubmit} className="flex flex-col gap-3">
              <StarRating value={reviewForm.rating} onChange={(rating) => setReviewForm((f) => ({ ...f, rating }))} />
              <textarea
                value={reviewForm.comment}
                onChange={(e) => setReviewForm((f) => ({ ...f, comment: e.target.value }))}
                placeholder="Share your thoughts about this product…"
                rows={3}
                className="rounded-xl border border-slate-300 px-3.5 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
              />
              <Button type="submit" disabled={reviewSubmitting} className="self-start">
                {reviewSubmitting ? 'Submitting…' : myReview ? 'Update Review' : 'Submit Review'}
              </Button>
              <p className="text-xs text-muted">You must have purchased this product to leave a review.</p>
            </form>
          </Card>
        )}

        {reviewData.reviews.length === 0 ? (
          <p className="text-sm text-muted">No reviews yet.</p>
        ) : (
          <div className="flex flex-col gap-4">
            {reviewData.reviews.map((r) => (
              <Card key={r.id}>
                <div className="mb-1 flex items-center justify-between">
                  <span className="font-semibold text-ink">{r.userName}</span>
                  <StarRating value={r.rating} />
                </div>
                {r.comment && <p className="text-sm text-muted">{r.comment}</p>}
                {(isAdmin || r.userId === user?.id) && (
                  <button
                    onClick={() => handleDeleteReview(r.id)}
                    className="mt-2 text-xs font-medium text-red-600 hover:underline"
                  >
                    Delete
                  </button>
                )}
              </Card>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
