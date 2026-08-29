import { useEffect, useState } from 'react'
import { useToast } from '../../context/ToastContext'
import { getCoupons, createCoupon, updateCoupon, deleteCoupon } from '../../services/coupons'
import { extractErrorMessage } from '../../services/errorUtils'
import Card from '../../components/Card'
import Button from '../../components/Button'
import Input from '../../components/Input'
import Badge from '../../components/Badge'
import Modal from '../../components/Modal'

const EMPTY_FORM = {
  code: '',
  discountType: 'PERCENTAGE',
  discountValue: '',
  minOrderAmount: '0',
  maxUses: '',
  maxDiscountAmount: '',
  expiresAt: '',
  active: true,
}

export default function AdminCoupons() {
  const { showToast } = useToast()
  const [coupons, setCoupons] = useState([])
  const [loading, setLoading] = useState(true)
  const [editing, setEditing] = useState(null)
  const [form, setForm] = useState(EMPTY_FORM)
  const [saving, setSaving] = useState(false)
  const [showForm, setShowForm] = useState(false)

  const load = () =>
    getCoupons()
      .then(setCoupons)
      .catch((err) => showToast(extractErrorMessage(err), 'error'))

  useEffect(() => {
    load().finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const openCreate = () => {
    setEditing(null)
    setForm(EMPTY_FORM)
    setShowForm(true)
  }

  const openEdit = (coupon) => {
    setEditing(coupon)
    setForm({
      code: coupon.code,
      discountType: coupon.discountType,
      discountValue: coupon.discountValue,
      minOrderAmount: coupon.minOrderAmount ?? '0',
      maxUses: coupon.maxUses ?? '',
      maxDiscountAmount: coupon.maxDiscountAmount ?? '',
      expiresAt: coupon.expiresAt ? coupon.expiresAt.slice(0, 16) : '',
      active: coupon.active,
    })
    setShowForm(true)
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSaving(true)
    const payload = {
      ...form,
      discountValue: Number(form.discountValue),
      minOrderAmount: form.minOrderAmount === '' ? 0 : Number(form.minOrderAmount),
      maxUses: form.maxUses === '' ? null : Number(form.maxUses),
      maxDiscountAmount: form.maxDiscountAmount === '' ? null : Number(form.maxDiscountAmount),
      expiresAt: form.expiresAt === '' ? null : form.expiresAt,
    }
    try {
      if (editing) {
        await updateCoupon(editing.id, payload)
        showToast('Coupon updated', 'success')
      } else {
        await createCoupon(payload)
        showToast('Coupon created', 'success')
      }
      setShowForm(false)
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async (coupon) => {
    if (!confirm(`Delete coupon "${coupon.code}"?`)) return
    try {
      await deleteCoupon(coupon.id)
      showToast('Coupon deleted', 'success')
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  return (
    <div>
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-xl font-bold text-ink">Coupons</h1>
        <Button onClick={openCreate}>New Coupon</Button>
      </div>

      {loading ? (
        <p className="text-sm text-muted">Loading coupons…</p>
      ) : (
        <div className="flex flex-col gap-3">
          {coupons.map((coupon) => (
            <Card key={coupon.id} className="flex items-center justify-between gap-4">
              <div>
                <div className="mb-1 flex items-center gap-2">
                  <span className="font-mono font-semibold text-ink">{coupon.code}</span>
                  <Badge tone={coupon.active ? 'success' : 'neutral'}>{coupon.active ? 'Active' : 'Inactive'}</Badge>
                </div>
                <p className="text-sm text-muted">
                  {coupon.discountType === 'PERCENTAGE' ? `${coupon.discountValue}% off` : `$${coupon.discountValue} off`}
                  {coupon.minOrderAmount > 0 ? ` · min $${Number(coupon.minOrderAmount).toFixed(2)}` : ''}
                  {coupon.maxUses ? ` · ${coupon.usedCount}/${coupon.maxUses} used` : ` · ${coupon.usedCount} used`}
                  {coupon.expiresAt ? ` · expires ${new Date(coupon.expiresAt).toLocaleDateString()}` : ''}
                </p>
              </div>
              <div className="flex shrink-0 gap-2">
                <Button variant="secondary" onClick={() => openEdit(coupon)}>
                  Edit
                </Button>
                <Button variant="danger" onClick={() => handleDelete(coupon)}>
                  Delete
                </Button>
              </div>
            </Card>
          ))}
        </div>
      )}

      {showForm && (
        <Modal title={editing ? 'Edit Coupon' : 'New Coupon'} onClose={() => setShowForm(false)}>
          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <Input
              label="Code"
              required
              value={form.code}
              onChange={(e) => setForm({ ...form, code: e.target.value.toUpperCase() })}
            />

            <label className="block text-left">
              <span className="mb-1.5 block text-sm font-medium text-ink">Discount Type</span>
              <select
                value={form.discountType}
                onChange={(e) => setForm({ ...form, discountType: e.target.value })}
                className="w-full rounded-xl border border-slate-300 px-3.5 py-2.5 text-sm text-ink focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
              >
                <option value="PERCENTAGE">Percentage</option>
                <option value="FIXED">Fixed Amount</option>
              </select>
            </label>

            <div className="grid grid-cols-2 gap-4">
              <Input
                label={form.discountType === 'PERCENTAGE' ? 'Discount %' : 'Discount $'}
                type="number"
                step="0.01"
                min="0"
                required
                value={form.discountValue}
                onChange={(e) => setForm({ ...form, discountValue: e.target.value })}
              />
              <Input
                label="Min Order Amount"
                type="number"
                step="0.01"
                min="0"
                value={form.minOrderAmount}
                onChange={(e) => setForm({ ...form, minOrderAmount: e.target.value })}
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <Input
                label="Max Uses (optional)"
                type="number"
                min="1"
                value={form.maxUses}
                onChange={(e) => setForm({ ...form, maxUses: e.target.value })}
              />
              {form.discountType === 'PERCENTAGE' && (
                <Input
                  label="Max Discount $ (optional)"
                  type="number"
                  step="0.01"
                  min="0"
                  value={form.maxDiscountAmount}
                  onChange={(e) => setForm({ ...form, maxDiscountAmount: e.target.value })}
                />
              )}
            </div>

            <Input
              label="Expires At (optional)"
              type="datetime-local"
              value={form.expiresAt}
              onChange={(e) => setForm({ ...form, expiresAt: e.target.value })}
            />

            <label className="flex items-center gap-2 text-sm text-ink">
              <input
                type="checkbox"
                checked={form.active}
                onChange={(e) => setForm({ ...form, active: e.target.checked })}
              />
              Active
            </label>

            <div className="flex justify-end gap-2">
              <Button type="button" variant="secondary" onClick={() => setShowForm(false)}>
                Cancel
              </Button>
              <Button type="submit" disabled={saving}>
                {saving ? 'Saving…' : 'Save'}
              </Button>
            </div>
          </form>
        </Modal>
      )}
    </div>
  )
}
