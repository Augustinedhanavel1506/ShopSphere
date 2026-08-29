import { useEffect, useState } from 'react'
import { useToast } from '../../context/ToastContext'
import { getProducts } from '../../services/products'
import { getInventory, setInventoryQuantity, adjustInventoryQuantity, getInventoryHistory } from '../../services/inventory'
import { extractErrorMessage } from '../../services/errorUtils'
import Card from '../../components/Card'
import Button from '../../components/Button'
import Badge from '../../components/Badge'
import Modal from '../../components/Modal'

export default function AdminInventory() {
  const { showToast } = useToast()
  const [rows, setRows] = useState([])
  const [loading, setLoading] = useState(true)
  const [editValues, setEditValues] = useState({})
  const [historyFor, setHistoryFor] = useState(null)
  const [history, setHistory] = useState([])

  const load = async () => {
    const products = await getProducts()
    const withInventory = await Promise.all(
      products.map((p) => getInventory(p.id).then((inv) => ({ product: p, inventory: inv }))),
    )
    setRows(withInventory)
  }

  useEffect(() => {
    load()
      .catch((err) => showToast(extractErrorMessage(err), 'error'))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleAdjust = async (productId, delta) => {
    try {
      await adjustInventoryQuantity(productId, delta)
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleSet = async (productId) => {
    const value = editValues[productId]
    if (value === undefined || value === '') return
    try {
      await setInventoryQuantity(productId, Number(value))
      showToast('Quantity updated', 'success')
      setEditValues({ ...editValues, [productId]: '' })
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const openHistory = async (product) => {
    setHistoryFor(product)
    try {
      const data = await getInventoryHistory(product.id)
      setHistory(data)
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  return (
    <div>
      <h1 className="mb-6 text-xl font-bold text-ink">Inventory</h1>

      {loading ? (
        <p className="text-sm text-muted">Loading inventory…</p>
      ) : (
        <div className="flex flex-col gap-3">
          {rows.map(({ product, inventory }) => (
            <Card key={product.id} className="flex flex-wrap items-center justify-between gap-4">
              <div className="min-w-0">
                <div className="mb-1 flex items-center gap-2">
                  <span className="font-semibold text-ink">{product.name}</span>
                  <Badge tone={inventory.inStock ? 'success' : 'danger'}>
                    {inventory.inStock ? 'In Stock' : 'Out of Stock'}
                  </Badge>
                </div>
                <p className="text-sm text-muted">SKU {product.sku}</p>
              </div>

              <div className="flex items-center gap-3">
                <div className="flex items-center gap-2">
                  <button
                    type="button"
                    onClick={() => handleAdjust(product.id, -1)}
                    className="h-8 w-8 rounded-lg border border-slate-300 text-ink hover:bg-slate-50"
                  >
                    −
                  </button>
                  <span className="w-10 text-center text-base font-bold text-ink">{inventory.quantity}</span>
                  <button
                    type="button"
                    onClick={() => handleAdjust(product.id, 1)}
                    className="h-8 w-8 rounded-lg border border-slate-300 text-ink hover:bg-slate-50"
                  >
                    +
                  </button>
                </div>

                <input
                  type="number"
                  min="0"
                  placeholder="Set qty"
                  value={editValues[product.id] ?? ''}
                  onChange={(e) => setEditValues({ ...editValues, [product.id]: e.target.value })}
                  className="w-24 rounded-lg border border-slate-300 px-2 py-1.5 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
                />
                <Button variant="secondary" onClick={() => handleSet(product.id)}>
                  Set
                </Button>
                <Button variant="secondary" onClick={() => openHistory(product)}>
                  History
                </Button>
              </div>
            </Card>
          ))}
        </div>
      )}

      {historyFor && (
        <Modal title={`History — ${historyFor.name}`} onClose={() => setHistoryFor(null)}>
          {history.length === 0 ? (
            <p className="text-sm text-muted">No transactions yet.</p>
          ) : (
            <div className="flex flex-col gap-2">
              {history.map((tx) => (
                <div key={tx.id} className="flex items-center justify-between border-b border-slate-100 pb-2 text-sm">
                  <div>
                    <p className="text-ink">{tx.reason.replaceAll('_', ' ')}</p>
                    <p className="text-xs text-muted">{new Date(tx.createdAt).toLocaleString()}</p>
                  </div>
                  <div className="text-right">
                    <p className={tx.changeQuantity >= 0 ? 'text-success' : 'text-red-600'}>
                      {tx.changeQuantity >= 0 ? '+' : ''}
                      {tx.changeQuantity}
                    </p>
                    <p className="text-xs text-muted">→ {tx.resultingQuantity}</p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </Modal>
      )}
    </div>
  )
}
