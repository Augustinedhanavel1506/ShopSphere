import { useEffect, useMemo, useState } from 'react'
import { useSearchParams } from 'react-router-dom'
import { getCategories } from '../services/categories'
import { getProducts, searchProducts } from '../services/products'
import { extractErrorMessage } from '../services/errorUtils'
import ProductCard from '../components/ProductCard'

export default function Products() {
  const [searchParams, setSearchParams] = useSearchParams()
  const categoryId = searchParams.get('categoryId') || ''
  const query = searchParams.get('q') || ''

  const [categories, setCategories] = useState([])
  const [products, setProducts] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [searchInput, setSearchInput] = useState(query)

  useEffect(() => {
    getCategories().then(setCategories).catch(() => setCategories([]))
  }, [])

  useEffect(() => {
    setLoading(true)
    setError('')
    const request = query ? searchProducts(query) : getProducts({ categoryId: categoryId || undefined })
    request
      .then(setProducts)
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
  }, [categoryId, query])

  const handleSearchSubmit = (e) => {
    e.preventDefault()
    const next = new URLSearchParams()
    if (searchInput.trim()) next.set('q', searchInput.trim())
    setSearchParams(next)
  }

  const handleCategoryClick = (id) => {
    const next = new URLSearchParams()
    if (id) next.set('categoryId', id)
    setSearchParams(next)
    setSearchInput('')
  }

  const heading = useMemo(() => {
    if (query) return `Search results for "${query}"`
    if (categoryId) return categories.find((c) => String(c.id) === categoryId)?.name ?? 'Products'
    return 'All Products'
  }, [query, categoryId, categories])

  return (
    <div className="mx-auto max-w-7xl px-4 py-8">
      <form onSubmit={handleSearchSubmit} className="mb-6 flex gap-2">
        <input
          value={searchInput}
          onChange={(e) => setSearchInput(e.target.value)}
          placeholder="Search products…"
          className="w-full max-w-md rounded-xl border border-slate-300 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
        />
        <button
          type="submit"
          className="rounded-xl bg-primary px-5 py-2.5 text-sm font-semibold text-white hover:bg-primary-dark"
        >
          Search
        </button>
      </form>

      <div className="grid grid-cols-1 gap-8 md:grid-cols-[220px_1fr]">
        <aside>
          <h3 className="mb-3 text-sm font-semibold uppercase tracking-wide text-muted">Categories</h3>
          <ul className="flex flex-col gap-1">
            <li>
              <button
                onClick={() => handleCategoryClick('')}
                className={`w-full rounded-lg px-3 py-2 text-left text-sm ${
                  !categoryId && !query ? 'bg-indigo-50 font-semibold text-primary' : 'text-ink hover:bg-slate-50'
                }`}
              >
                All Categories
              </button>
            </li>
            {categories.map((c) => (
              <li key={c.id}>
                <button
                  onClick={() => handleCategoryClick(String(c.id))}
                  className={`w-full rounded-lg px-3 py-2 text-left text-sm ${
                    categoryId === String(c.id) ? 'bg-indigo-50 font-semibold text-primary' : 'text-ink hover:bg-slate-50'
                  }`}
                >
                  {c.name}
                </button>
              </li>
            ))}
          </ul>
        </aside>

        <div>
          <h1 className="mb-4 text-xl font-bold text-ink">{heading}</h1>

          {loading && <p className="text-sm text-muted">Loading products…</p>}
          {error && <p className="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600">{error}</p>}

          {!loading && !error && products.length === 0 && (
            <div className="rounded-2xl border border-dashed border-slate-300 py-16 text-center text-muted">
              No products found.
            </div>
          )}

          {!loading && products.length > 0 && (
            <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
              {products.map((p) => (
                <ProductCard key={p.id} product={p} />
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
