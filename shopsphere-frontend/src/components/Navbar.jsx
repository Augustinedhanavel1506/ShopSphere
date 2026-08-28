import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'

export default function Navbar() {
  const { user, isAdmin, logout } = useAuth()
  const navigate = useNavigate()

  const handleLogout = async () => {
    await logout()
    navigate('/login')
  }

  return (
    <header className="sticky top-0 z-40 border-b border-slate-200 bg-surface/95 backdrop-blur">
      <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-4 py-3">
        <Link to="/" className="flex items-center gap-2 text-lg font-extrabold text-ink">
          <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-cta text-white">🛍️</span>
          ShopSphere
        </Link>

        <nav className="hidden items-center gap-6 text-sm font-medium text-ink md:flex">
          <Link to="/" className="hover:text-primary">
            Home
          </Link>
          <Link to="/products" className="hover:text-primary">
            Shop
          </Link>
          {isAdmin && (
            <Link to="/admin" className="hover:text-primary">
              Admin
            </Link>
          )}
        </nav>

        <div className="flex items-center gap-3">
          {user ? (
            <>
              <Link to="/wishlist" className="text-sm font-medium text-ink hover:text-primary">
                Wishlist
              </Link>
              <Link to="/cart" className="text-sm font-medium text-ink hover:text-primary">
                Cart
              </Link>
              <Link to="/orders" className="text-sm font-medium text-ink hover:text-primary">
                Orders
              </Link>
              <span className="hidden text-sm text-muted sm:inline">Hi, {user.firstName}</span>
              <button
                onClick={handleLogout}
                className="rounded-lg border border-slate-300 px-3 py-1.5 text-sm font-medium text-ink hover:bg-slate-50"
              >
                Logout
              </button>
            </>
          ) : (
            <>
              <Link
                to="/login"
                className="rounded-lg border border-slate-300 px-3 py-1.5 text-sm font-medium text-ink hover:bg-slate-50"
              >
                Login
              </Link>
              <Link
                to="/register"
                className="rounded-lg bg-primary px-3 py-1.5 text-sm font-medium text-white hover:bg-primary-dark"
              >
                Register
              </Link>
            </>
          )}
        </div>
      </div>
    </header>
  )
}
