import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { getDashboardSummary, getRecentOrders, getLowStockProducts } from '../../services/dashboard'
import { extractErrorMessage } from '../../services/errorUtils'
import Card from '../../components/Card'
import OrderStatusBadge from '../../components/OrderStatusBadge'

const PERIODS = [
  { value: 'today', label: 'Today' },
  { value: 'week', label: '7 Days' },
  { value: 'month', label: '30 Days' },
  { value: 'year', label: '1 Year' },
  { value: '', label: 'All Time' },
]

function StatCard({ label, value }) {
  return (
    <Card>
      <p className="text-xs font-semibold uppercase tracking-wide text-muted">{label}</p>
      <p className="mt-1 text-2xl font-bold text-ink">{value}</p>
    </Card>
  )
}

export default function AdminDashboard() {
  const [period, setPeriod] = useState('month')
  const [summary, setSummary] = useState(null)
  const [recentOrders, setRecentOrders] = useState([])
  const [lowStock, setLowStock] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    setLoading(true)
    Promise.all([getDashboardSummary({ period }), getRecentOrders({ limit: 8, period }), getLowStockProducts(5)])
      .then(([summaryData, orders, lowStockProducts]) => {
        setSummary(summaryData)
        setRecentOrders(orders)
        setLowStock(lowStockProducts)
      })
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
  }, [period])

  return (
    <div>
      <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-xl font-bold text-ink">Dashboard</h1>
        <div className="flex gap-1 rounded-xl border border-slate-200 bg-surface p-1">
          {PERIODS.map((p) => (
            <button
              key={p.value || 'all'}
              onClick={() => setPeriod(p.value)}
              className={`rounded-lg px-3 py-1.5 text-xs font-medium ${
                period === p.value ? 'bg-primary text-white' : 'text-ink hover:bg-slate-100'
              }`}
            >
              {p.label}
            </button>
          ))}
        </div>
      </div>

      {error && <p className="mb-4 text-sm text-red-600">{error}</p>}
      {loading ? (
        <p className="text-sm text-muted">Loading dashboard…</p>
      ) : (
        summary && (
          <>
            <div className="mb-8 grid grid-cols-2 gap-4 md:grid-cols-4">
              <StatCard label="Revenue" value={`$${Number(summary.totalRevenue).toFixed(2)}`} />
              <StatCard label="Total Orders" value={summary.totalOrders} />
              <StatCard label="Pending Orders" value={summary.pendingOrders} />
              <StatCard label="Paid Orders" value={summary.paidOrders} />
              <StatCard label="Cancelled Orders" value={summary.cancelledOrders} />
              <StatCard label="Customers" value={summary.totalCustomers} />
              <StatCard label="Products" value={summary.totalProducts} />
              <StatCard label="Low Stock" value={summary.lowStockProductCount} />
            </div>

            <div className="grid grid-cols-1 gap-6 lg:grid-cols-[1fr_320px]">
              <Card>
                <div className="mb-3 flex items-center justify-between">
                  <h2 className="text-sm font-semibold uppercase tracking-wide text-muted">Recent Orders</h2>
                  <Link to="/admin/orders" className="text-xs font-medium text-primary hover:underline">
                    View all
                  </Link>
                </div>
                {recentOrders.length === 0 ? (
                  <p className="text-sm text-muted">No orders in this period.</p>
                ) : (
                  <div className="flex flex-col gap-2">
                    {recentOrders.map((order) => (
                      <Link
                        key={order.id}
                        to={`/admin/orders/${order.id}`}
                        className="flex items-center justify-between rounded-lg px-2 py-2 text-sm hover:bg-slate-50"
                      >
                        <span className="font-medium text-ink">#{order.id}</span>
                        <span className="flex-1 truncate px-3 text-muted">{order.customerEmail}</span>
                        <span className="px-3 text-ink">${Number(order.totalAmount).toFixed(2)}</span>
                        <OrderStatusBadge status={order.status} />
                      </Link>
                    ))}
                  </div>
                )}
              </Card>

              <Card className="h-fit">
                <div className="mb-3 flex items-center justify-between">
                  <h2 className="text-sm font-semibold uppercase tracking-wide text-muted">Low Stock</h2>
                  <Link to="/admin/inventory" className="text-xs font-medium text-primary hover:underline">
                    Manage
                  </Link>
                </div>
                {lowStock.length === 0 ? (
                  <p className="text-sm text-muted">Nothing running low.</p>
                ) : (
                  <div className="flex flex-col gap-2">
                    {lowStock.map((p) => (
                      <div key={p.productId} className="flex items-center justify-between text-sm">
                        <span className="truncate text-ink">{p.productName}</span>
                        <span className="font-semibold text-warning">{p.quantity} left</span>
                      </div>
                    ))}
                  </div>
                )}
              </Card>
            </div>
          </>
        )
      )}
    </div>
  )
}
