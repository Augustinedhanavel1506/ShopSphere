import { useEffect, useState } from 'react'
import { useToast } from '../context/ToastContext'
import { getAddresses, createAddress, deleteAddress, setDefaultAddress } from '../services/addresses'
import { extractErrorMessage } from '../services/errorUtils'
import Button from '../components/Button'
import Input from '../components/Input'
import Card from '../components/Card'
import Badge from '../components/Badge'

const EMPTY_FORM = { fullName: '', phone: '', line1: '', line2: '', city: '', state: '', postalCode: '', country: '' }

export default function Addresses() {
  const { showToast } = useToast()
  const [addresses, setAddresses] = useState([])
  const [loading, setLoading] = useState(true)
  const [showForm, setShowForm] = useState(false)
  const [form, setForm] = useState(EMPTY_FORM)
  const [submitting, setSubmitting] = useState(false)

  const load = () => getAddresses().then(setAddresses)

  useEffect(() => {
    load()
      .catch((err) => showToast(extractErrorMessage(err), 'error'))
      .finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleChange = (e) => setForm((f) => ({ ...f, [e.target.name]: e.target.value }))

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSubmitting(true)
    try {
      await createAddress(form)
      await load()
      setForm(EMPTY_FORM)
      setShowForm(false)
      showToast('Address added', 'success')
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setSubmitting(false)
    }
  }

  const handleDelete = async (id) => {
    try {
      await deleteAddress(id)
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  const handleSetDefault = async (id) => {
    try {
      await setDefaultAddress(id)
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  if (loading) return <p className="px-4 py-16 text-center text-sm text-muted">Loading addresses…</p>

  return (
    <div className="mx-auto max-w-3xl px-4 py-8">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-xl font-bold text-ink">My Addresses</h1>
        <Button onClick={() => setShowForm((s) => !s)}>{showForm ? 'Cancel' : '+ Add Address'}</Button>
      </div>

      {showForm && (
        <Card className="mb-6">
          <form onSubmit={handleSubmit} className="grid grid-cols-1 gap-3 sm:grid-cols-2">
            <Input label="Full Name" name="fullName" required value={form.fullName} onChange={handleChange} />
            <Input label="Phone" name="phone" required value={form.phone} onChange={handleChange} />
            <Input
              label="Address Line 1"
              name="line1"
              required
              value={form.line1}
              onChange={handleChange}
              className="sm:col-span-2"
            />
            <Input
              label="Address Line 2"
              name="line2"
              value={form.line2}
              onChange={handleChange}
              className="sm:col-span-2"
            />
            <Input label="City" name="city" required value={form.city} onChange={handleChange} />
            <Input label="State" name="state" required value={form.state} onChange={handleChange} />
            <Input label="Postal Code" name="postalCode" required value={form.postalCode} onChange={handleChange} />
            <Input label="Country" name="country" required value={form.country} onChange={handleChange} />
            <Button type="submit" disabled={submitting} className="sm:col-span-2">
              {submitting ? 'Saving…' : 'Save Address'}
            </Button>
          </form>
        </Card>
      )}

      {addresses.length === 0 && !showForm ? (
        <p className="text-sm text-muted">No saved addresses yet.</p>
      ) : (
        <div className="flex flex-col gap-3">
          {addresses.map((addr) => (
            <Card key={addr.id} className="flex items-start justify-between gap-4">
              <div>
                <div className="mb-1 flex items-center gap-2">
                  <span className="font-semibold text-ink">{addr.fullName}</span>
                  {addr.isDefault && <Badge tone="info">Default</Badge>}
                </div>
                <p className="text-sm text-muted">
                  {addr.line1}
                  {addr.line2 ? `, ${addr.line2}` : ''}, {addr.city}, {addr.state} {addr.postalCode}, {addr.country}
                </p>
                <p className="text-sm text-muted">{addr.phone}</p>
              </div>
              <div className="flex shrink-0 flex-col items-end gap-1">
                {!addr.isDefault && (
                  <button
                    onClick={() => handleSetDefault(addr.id)}
                    className="text-xs font-medium text-primary hover:underline"
                  >
                    Set as default
                  </button>
                )}
                <button
                  onClick={() => handleDelete(addr.id)}
                  className="text-xs font-medium text-red-600 hover:underline"
                >
                  Delete
                </button>
              </div>
            </Card>
          ))}
        </div>
      )}
    </div>
  )
}
