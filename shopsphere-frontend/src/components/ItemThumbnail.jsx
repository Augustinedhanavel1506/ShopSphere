import { useEffect, useState } from 'react'
import { getProduct } from '../services/products'

export default function ItemThumbnail({ productId, className = 'h-16 w-16' }) {
  const [image, setImage] = useState(null)

  useEffect(() => {
    let cancelled = false
    getProduct(productId)
      .then((p) => {
        if (!cancelled) setImage(p.images?.[0]?.imageUrl ?? null)
      })
      .catch(() => {})
    return () => {
      cancelled = true
    }
  }, [productId])

  return (
    <div className={`flex shrink-0 items-center justify-center overflow-hidden rounded-lg bg-slate-100 ${className}`}>
      {image ? <img src={image} alt="" className="h-full w-full object-cover" /> : <span className="text-xl">📦</span>}
    </div>
  )
}
