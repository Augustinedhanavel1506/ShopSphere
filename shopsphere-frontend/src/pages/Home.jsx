import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { getCategories } from '../services/categories'
import { getProducts } from '../services/products'
import Button from '../components/Button'
import ProductCard from '../components/ProductCard'

export default function Home() {
  const [categories, setCategories] = useState([])
  const [products, setProducts] = useState([])

  useEffect(() => {
    getCategories().then(setCategories).catch(() => setCategories([]))
    getProducts({ size: 8 }).then((res) => setProducts(res.content)).catch(() => setProducts([]))
  }, [])

  return (
    <div>
      <section className="bg-white px-4 py-16 text-center">
        <h1 className="mb-4 text-4xl font-extrabold text-ink">Shop Everything You Love</h1>
        <p className="mb-8 text-muted">Top quality products, best prices, fast delivery.</p>
        <Link to="/products">
          <Button variant="cta">Shop Now</Button>
        </Link>
      </section>

      {categories.length > 0 && (
        <section className="mx-auto max-w-7xl px-4 py-10">
          <h2 className="mb-4 text-lg font-bold text-ink">Shop by Category</h2>
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 md:grid-cols-6">
            {categories.map((c) => (
              <Link
                key={c.id}
                to={`/products?categoryId=${c.id}`}
                className="flex flex-col items-center gap-2 rounded-xl border border-slate-200 bg-surface p-4 text-center hover:shadow-md"
              >
                <div className="flex h-16 w-16 items-center justify-center overflow-hidden rounded-full bg-slate-100">
                  {c.imageUrl ? (
                    <img src={c.imageUrl} alt={c.name} className="h-full w-full object-cover" />
                  ) : (
                    <span className="text-2xl">🛍️</span>
                  )}
                </div>
                <span className="text-sm font-medium text-ink">{c.name}</span>
              </Link>
            ))}
          </div>
        </section>
      )}

      {products.length > 0 && (
        <section className="mx-auto max-w-7xl px-4 pb-16">
          <div className="mb-4 flex items-center justify-between">
            <h2 className="text-lg font-bold text-ink">Best Selling Products</h2>
            <Link to="/products" className="text-sm font-medium text-primary hover:underline">
              View all
            </Link>
          </div>
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6">
            {products.map((p) => (
              <ProductCard key={p.id} product={p} />
            ))}
          </div>
        </section>
      )}
    </div>
  )
}
