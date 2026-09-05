import { useEffect, useState } from 'react'
import { useToast } from '../../context/ToastContext'
import { getProducts, createProduct, updateProduct, deleteProduct } from '../../services/products'
import { getCategories } from '../../services/categories'
import { extractErrorMessage } from '../../services/errorUtils'
import Card from '../../components/Card'
import Button from '../../components/Button'
import Input from '../../components/Input'
import Badge from '../../components/Badge'
import Modal from '../../components/Modal'
import ImageUploadField from '../../components/ImageUploadField'

const EMPTY_FORM = {
  categoryId: '',
  name: '',
  description: '',
  price: '',
  originalPrice: '',
  sku: '',
  active: true,
  images: [],
  specifications: [],
}

export default function AdminProducts() {
  const { showToast } = useToast()
  const [products, setProducts] = useState([])
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [editing, setEditing] = useState(null)
  const [form, setForm] = useState(EMPTY_FORM)
  const [saving, setSaving] = useState(false)
  const [showForm, setShowForm] = useState(false)

  const load = () =>
    Promise.all([getProducts({ size: 1000 }), getCategories()])
      .then(([productPage, categoryList]) => {
        setProducts(productPage.content)
        setCategories(categoryList)
      })
      .catch((err) => showToast(extractErrorMessage(err), 'error'))

  useEffect(() => {
    load().finally(() => setLoading(false))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const openCreate = () => {
    setEditing(null)
    setForm({ ...EMPTY_FORM, categoryId: categories[0]?.id ?? '' })
    setShowForm(true)
  }

  const openEdit = (product) => {
    setEditing(product)
    setForm({
      categoryId: product.categoryId,
      name: product.name,
      description: product.description ?? '',
      price: product.price,
      originalPrice: product.originalPrice ?? '',
      sku: product.sku,
      active: product.active,
      images: (product.images ?? []).map((img) => ({ imageUrl: img.imageUrl, displayOrder: img.displayOrder })),
      specifications: (product.specifications ?? []).map((s) => ({ key: s.key, value: s.value })),
    })
    setShowForm(true)
  }

  const addImage = () =>
    setForm({ ...form, images: [...form.images, { imageUrl: '', displayOrder: form.images.length }] })
  const updateImage = (i, imageUrl) => {
    const images = [...form.images]
    images[i] = { ...images[i], imageUrl }
    setForm({ ...form, images })
  }
  const removeImage = (i) => setForm({ ...form, images: form.images.filter((_, idx) => idx !== i) })

  const addSpec = () => setForm({ ...form, specifications: [...form.specifications, { key: '', value: '' }] })
  const updateSpec = (i, field, value) => {
    const specifications = [...form.specifications]
    specifications[i] = { ...specifications[i], [field]: value }
    setForm({ ...form, specifications })
  }
  const removeSpec = (i) => setForm({ ...form, specifications: form.specifications.filter((_, idx) => idx !== i) })

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSaving(true)
    const payload = {
      ...form,
      categoryId: Number(form.categoryId),
      price: Number(form.price),
      originalPrice: form.originalPrice === '' ? null : Number(form.originalPrice),
    }
    try {
      if (editing) {
        await updateProduct(editing.id, payload)
        showToast('Product updated', 'success')
      } else {
        await createProduct(payload)
        showToast('Product created', 'success')
      }
      setShowForm(false)
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async (product) => {
    if (!confirm(`Delete product "${product.name}"?`)) return
    try {
      await deleteProduct(product.id)
      showToast('Product deleted', 'success')
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  return (
    <div>
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-xl font-bold text-ink">Products</h1>
        <Button onClick={openCreate} disabled={categories.length === 0}>
          New Product
        </Button>
      </div>

      {loading ? (
        <p className="text-sm text-muted">Loading products…</p>
      ) : (
        <div className="flex flex-col gap-3">
          {products.map((product) => (
            <Card key={product.id} className="flex items-center justify-between gap-4">
              <div className="min-w-0">
                <div className="mb-1 flex items-center gap-2">
                  <span className="font-semibold text-ink">{product.name}</span>
                  <Badge tone={product.active ? 'success' : 'neutral'}>
                    {product.active ? 'Active' : 'Inactive'}
                  </Badge>
                </div>
                <p className="text-sm text-muted">
                  {product.categoryName} · SKU {product.sku} · ${Number(product.price).toFixed(2)}
                </p>
              </div>
              <div className="flex shrink-0 gap-2">
                <Button variant="secondary" onClick={() => openEdit(product)}>
                  Edit
                </Button>
                <Button variant="danger" onClick={() => handleDelete(product)}>
                  Delete
                </Button>
              </div>
            </Card>
          ))}
        </div>
      )}

      {showForm && (
        <Modal title={editing ? 'Edit Product' : 'New Product'} onClose={() => setShowForm(false)} className="max-w-2xl">
          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <label className="block text-left">
              <span className="mb-1.5 block text-sm font-medium text-ink">Category</span>
              <select
                required
                value={form.categoryId}
                onChange={(e) => setForm({ ...form, categoryId: e.target.value })}
                className="w-full rounded-xl border border-slate-300 px-3.5 py-2.5 text-sm text-ink focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
              >
                <option value="" disabled>
                  Select a category
                </option>
                {categories.map((c) => (
                  <option key={c.id} value={c.id}>
                    {c.name}
                  </option>
                ))}
              </select>
            </label>

            <Input label="Name" required value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} />
            <Input
              label="Description"
              value={form.description}
              onChange={(e) => setForm({ ...form, description: e.target.value })}
            />

            <div className="grid grid-cols-2 gap-4">
              <Input
                label="Price"
                type="number"
                step="0.01"
                min="0"
                required
                value={form.price}
                onChange={(e) => setForm({ ...form, price: e.target.value })}
              />
              <Input
                label="Original Price (optional)"
                type="number"
                step="0.01"
                min="0"
                value={form.originalPrice}
                onChange={(e) => setForm({ ...form, originalPrice: e.target.value })}
              />
            </div>

            <Input label="SKU" required value={form.sku} onChange={(e) => setForm({ ...form, sku: e.target.value })} />

            <label className="flex items-center gap-2 text-sm text-ink">
              <input
                type="checkbox"
                checked={form.active}
                onChange={(e) => setForm({ ...form, active: e.target.checked })}
              />
              Active
            </label>

            <div>
              <div className="mb-2 flex items-center justify-between">
                <span className="text-sm font-medium text-ink">Images</span>
                <button type="button" onClick={addImage} className="text-xs font-medium text-primary hover:underline">
                  + Add Image
                </button>
              </div>
              <div className="flex flex-col gap-2">
                {form.images.map((img, i) => (
                  <div key={i} className="flex items-start gap-2">
                    <div className="w-full">
                      <ImageUploadField value={img.imageUrl} onChange={(url) => updateImage(i, url)} />
                    </div>
                    <button type="button" onClick={() => removeImage(i)} className="mt-2 px-2 text-red-600">
                      ✕
                    </button>
                  </div>
                ))}
              </div>
            </div>

            <div>
              <div className="mb-2 flex items-center justify-between">
                <span className="text-sm font-medium text-ink">Specifications</span>
                <button type="button" onClick={addSpec} className="text-xs font-medium text-primary hover:underline">
                  + Add Spec
                </button>
              </div>
              <div className="flex flex-col gap-2">
                {form.specifications.map((spec, i) => (
                  <div key={i} className="flex gap-2">
                    <input
                      value={spec.key}
                      onChange={(e) => updateSpec(i, 'key', e.target.value)}
                      placeholder="Key"
                      className="w-1/3 rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
                    />
                    <input
                      value={spec.value}
                      onChange={(e) => updateSpec(i, 'value', e.target.value)}
                      placeholder="Value"
                      className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
                    />
                    <button type="button" onClick={() => removeSpec(i)} className="px-2 text-red-600">
                      ✕
                    </button>
                  </div>
                ))}
              </div>
            </div>

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
