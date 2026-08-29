import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import {
  ResponsiveContainer,
  AreaChart,
  Area,
  BarChart,
  Bar,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from 'recharts'
import {
  getDashboardSummary,
  getRecentOrders,
  getLowStockProducts,
  getOrdersByStatus,
  getRevenueTrend,
} from '../../services/dashboard'
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

const STATUS_COLORS = {
  PENDING: '#f59e0b',
  PAID: '#6366f1',
  CONFIRMED: '#3b82f6',
  PROCESSING: '#8b5cf6',
  SHIPPED: '#06b6d4',
  DELIVERED: '#10b981',
  CANCELLED: '#ef4444',
}

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
  const [customFrom, setCustomFrom] = useState('')
  const [customTo, setCustomTo] = useState('')
  const [customRange, setCustomRange] = useState(null)
  const [summary, setSummary] = useState(null)
  const [recentOrders, setRecentOrders] = useState([])
  const [lowStock, setLowStock] = useState([])
  const [ordersByStatus, setOrdersByStatus] = useState(null)
  const [revenueTrend, setRevenueTrend] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  const rangeParams = customRange
    ? { from: `${customRange.from}T00:00:00`, to: `${customRange.to}T23:59:59` }
    : { period }

  useEffect(() => {
    setLoading(true)
    Promise.all([
      getDashboardSummary(rangeParams),
      getRecentOrders({ limit: 8, ...rangeParams }),
      getLowStockProducts(5),
      getOrdersByStatus(rangeParams),
      getRevenueTrend(rangeParams),
    ])
      .then(([summaryData, orders, lowStockProducts, statusCounts, trend]) => {
        setSummary(summaryData)
        setRecentOrders(orders)
        setLowStock(lowStockProducts)
        setOrdersByStatus(statusCounts)
        setRevenueTrend(trend)
      })
      .catch((err) => setError(extractErrorMessage(err)))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [period, customRange])

  const selectPeriod = (value) => {
    setCustomRange(null)
    setCustomFrom('')
    setCustomTo('')
    setPeriod(value)
  }

  const applyCustomRange = () => {
    if (!customFrom || !customTo) return
    setCustomRange({ from: customFrom, to: customTo })
  }

  return (
    <div>
      <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-xl font-bold text-ink">Dashboard</h1>
        <div className="flex flex-wrap items-center gap-3">
          <div className="flex gap-1 rounded-xl border border-slate-200 bg-surface p-1">
            {PERIODS.map((p) => (
              <button
                key={p.value || 'all'}
                onClick={() => selectPeriod(p.value)}
                className={`rounded-lg px-3 py-1.5 text-xs font-medium ${
                  !customRange && period === p.value ? 'bg-primary text-white' : 'text-ink hover:bg-slate-100'
                }`}
              >
                {p.label}
              </button>
            ))}
          </div>

          <div className="flex items-center gap-1.5 rounded-xl border border-slate-200 bg-surface p-1.5">
            <input
              type="date"
              value={customFrom}
              onChange={(e) => setCustomFrom(e.target.value)}
              className="rounded-lg border border-slate-300 px-2 py-1 text-xs text-ink focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
            />
            <span className="text-xs text-muted">to</span>
            <input
              type="date"
              value={customTo}
              min={customFrom || undefined}
              onChange={(e) => setCustomTo(e.target.value)}
              className="rounded-lg border border-slate-300 px-2 py-1 text-xs text-ink focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
            />
            <button
              onClick={applyCustomRange}
              disabled={!customFrom || !customTo}
              className="rounded-lg bg-primary px-3 py-1 text-xs font-medium text-white hover:bg-primary-dark disabled:opacity-50"
            >
              Apply
            </button>
          </div>
        </div>
      </div>

      {customRange && (
        <p className="mb-4 text-xs text-muted">
          Showing {customRange.from} to {customRange.to}
        </p>
      )}

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

            <div className="mb-8 grid grid-cols-1 gap-6 lg:grid-cols-[1fr_1fr]">
              <Card>
                <h2 className="mb-4 text-sm font-semibold uppercase tracking-wide text-muted">Revenue Trend</h2>
                {revenueTrend.length === 0 ? (
                  <p className="text-sm text-muted">No orders in this period.</p>
                ) : (
                  <ResponsiveContainer width="100%" height={220}>
                    <AreaChart data={revenueTrend} margin={{ top: 5, right: 10, left: 0, bottom: 0 }}>
                      <defs>
                        <linearGradient id="revenueFill" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#4f46e5" stopOpacity={0.35} />
                          <stop offset="95%" stopColor="#4f46e5" stopOpacity={0} />
                        </linearGradient>
                      </defs>
                      <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                      <XAxis dataKey="date" tick={{ fontSize: 11, fill: '#64748b' }} tickLine={false} axisLine={false} />
                      <YAxis
                        tick={{ fontSize: 11, fill: '#64748b' }}
                        tickLine={false}
                        axisLine={false}
                        tickFormatter={(v) => `$${v}`}
                      />
                      <Tooltip
                        formatter={(value, name) => [name === 'revenue' ? `$${Number(value).toFixed(2)}` : value, name === 'revenue' ? 'Revenue' : 'Orders']}
                      />
                      <Area type="monotone" dataKey="revenue" stroke="#4f46e5" strokeWidth={2} fill="url(#revenueFill)" />
                    </AreaChart>
                  </ResponsiveContainer>
                )}
              </Card>

              <Card>
                <h2 className="mb-4 text-sm font-semibold uppercase tracking-wide text-muted">Orders by Status</h2>
                {!ordersByStatus || Object.values(ordersByStatus).every((v) => v === 0) ? (
                  <p className="text-sm text-muted">No orders in this period.</p>
                ) : (
                  <ResponsiveContainer width="100%" height={220}>
                    <BarChart
                      data={Object.entries(ordersByStatus).map(([status, count]) => ({ status, count }))}
                      margin={{ top: 5, right: 10, left: 0, bottom: 0 }}
                    >
                      <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                      <XAxis
                        dataKey="status"
                        tick={{ fontSize: 10, fill: '#64748b' }}
                        tickLine={false}
                        axisLine={false}
                        interval={0}
                        angle={-25}
                        textAnchor="end"
                        height={50}
                      />
                      <YAxis tick={{ fontSize: 11, fill: '#64748b' }} tickLine={false} axisLine={false} allowDecimals={false} />
                      <Tooltip />
                      <Bar dataKey="count" radius={[6, 6, 0, 0]}>
                        {Object.keys(ordersByStatus).map((status) => (
                          <Cell key={status} fill={STATUS_COLORS[status] ?? '#94a3b8'} />
                        ))}
                      </Bar>
                    </BarChart>
                  </ResponsiveContainer>
                )}
              </Card>
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
