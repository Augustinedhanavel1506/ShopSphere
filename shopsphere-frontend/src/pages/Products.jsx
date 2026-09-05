import { useEffect, useMemo, useState } from 'react'
import { useSearchParams } from 'react-router-dom'
import { getCategories } from '../services/categories'
import { getProducts, searchProducts } from '../services/products'
import { extractErrorMessage } from '../services/errorUtils'
import ProductCard from '../components/ProductCard'

const PAGE_SIZE = 20

export default function Products() {
  const [searchParams, setSearchParams] = useSearchParams()
  const categoryId = searchParams.get('categoryId') || ''
  const query = searchParams.get('q') || ''
  const page = Math.max(0, Number(searchParams.get('page') || 0))

  const [categories, setCategories] = useState([])
  const [products, setProducts] = useState([])
  const [totalPages, setTotalPages] = useState(0)
  const [totalElements, setTotalElements] = useState(0)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [searchInput, setSearchInput] = useState(query)

  useEffect(() => {
    getCategories().then(setCategories).catch(() => setCategories([]))
  }, [])

  useEffect(() => {
    setLoading(true)
    setError('')
    const request = query
      ? searchProducts(query, { page, size: PAGE_SIZE })
      : getProducts({ categoryId: categoryId || undefined, page, size: PAGE_SIZE })
    request
      .then((res) => {
        setProducts(res.content)
        setTotalPages(res.page.totalPages)
        setTotalElements(res.page.totalElements)
      })
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
  }, [categoryId, query, page])

  const goToPage = (nextPage) => {
    const next = new URLSearchParams(searchParams)
    if (nextPage > 0) next.set('page', String(nextPage))
    else next.delete('page')
    setSearchParams(next)
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

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
            <>
              <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                {products.map((p) => (
                  <ProductCard key={p.id} product={p} />
                ))}
              </div>
              <Pagination page={page} totalPages={totalPages} totalElements={totalElements} onPageChange={goToPage} />
            </>
          )}
        </div>
      </div>
    </div>
  )
}

function Pagination({ page, totalPages, totalElements, onPageChange }) {
  if (totalPages <= 1) return null

  const pageNumbers = []
  const start = Math.max(0, Math.min(page - 2, totalPages - 5))
  const end = Math.min(totalPages, start + 5)
  for (let i = start; i < end; i++) pageNumbers.push(i)

  return (
    <div className="mt-8 flex flex-col items-center gap-2">
      <p className="text-xs text-muted">
        Page {page + 1} of {totalPages} &middot; {totalElements} products
      </p>
      <nav className="flex items-center gap-1">
        <button
          onClick={() => onPageChange(page - 1)}
          disabled={page === 0}
          className="rounded-lg border border-slate-300 px-3 py-1.5 text-sm text-ink hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-40"
        >
          Prev
        </button>
        {start > 0 && <span className="px-1 text-sm text-muted">…</span>}
        {pageNumbers.map((n) => (
          <button
            key={n}
            onClick={() => onPageChange(n)}
            className={`rounded-lg px-3 py-1.5 text-sm ${
              n === page ? 'bg-primary font-semibold text-white' : 'border border-slate-300 text-ink hover:bg-slate-50'
            }`}
          >
            {n + 1}
          </button>
        ))}
        {end < totalPages && <span className="px-1 text-sm text-muted">…</span>}
        <button
          onClick={() => onPageChange(page + 1)}
          disabled={page >= totalPages - 1}
          className="rounded-lg border border-slate-300 px-3 py-1.5 text-sm text-ink hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-40"
        >
          Next
        </button>
      </nav>
    </div>
  )
}
