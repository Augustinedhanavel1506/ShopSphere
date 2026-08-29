import { useEffect, useState } from 'react'
import { useToast } from '../../context/ToastContext'
import { getCategories, createCategory, updateCategory, deleteCategory } from '../../services/categories'
import { extractErrorMessage } from '../../services/errorUtils'
import Card from '../../components/Card'
import Button from '../../components/Button'
import Input from '../../components/Input'
import Badge from '../../components/Badge'
import Modal from '../../components/Modal'

const EMPTY_FORM = { name: '', description: '', imageUrl: '', active: true }

export default function AdminCategories() {
  const { showToast } = useToast()
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [editing, setEditing] = useState(null)
  const [form, setForm] = useState(EMPTY_FORM)
  const [saving, setSaving] = useState(false)
  const [showForm, setShowForm] = useState(false)

  const load = () =>
    getCategories()
      .then(setCategories)
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

  const openEdit = (category) => {
    setEditing(category)
    setForm({
      name: category.name,
      description: category.description ?? '',
      imageUrl: category.imageUrl ?? '',
      active: category.active,
    })
    setShowForm(true)
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSaving(true)
    try {
      if (editing) {
        await updateCategory(editing.id, form)
        showToast('Category updated', 'success')
      } else {
        await createCategory(form)
        showToast('Category created', 'success')
      }
      setShowForm(false)
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async (category) => {
    if (!confirm(`Delete category "${category.name}"?`)) return
    try {
      await deleteCategory(category.id)
      showToast('Category deleted', 'success')
      await load()
    } catch (err) {
      showToast(extractErrorMessage(err), 'error')
    }
  }

  return (
    <div>
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-xl font-bold text-ink">Categories</h1>
        <Button onClick={openCreate}>New Category</Button>
      </div>

      {loading ? (
        <p className="text-sm text-muted">Loading categories…</p>
      ) : (
        <div className="flex flex-col gap-3">
          {categories.map((category) => (
            <Card key={category.id} className="flex items-center justify-between gap-4">
              <div className="min-w-0">
                <div className="mb-1 flex items-center gap-2">
                  <span className="font-semibold text-ink">{category.name}</span>
                  <Badge tone={category.active ? 'success' : 'neutral'}>
                    {category.active ? 'Active' : 'Inactive'}
                  </Badge>
                </div>
                <p className="truncate text-sm text-muted">{category.description}</p>
              </div>
              <div className="flex shrink-0 gap-2">
                <Button variant="secondary" onClick={() => openEdit(category)}>
                  Edit
                </Button>
                <Button variant="danger" onClick={() => handleDelete(category)}>
                  Delete
                </Button>
              </div>
            </Card>
          ))}
        </div>
      )}

      {showForm && (
        <Modal title={editing ? 'Edit Category' : 'New Category'} onClose={() => setShowForm(false)}>
          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <Input
              label="Name"
              required
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
            />
            <Input
              label="Description"
              value={form.description}
              onChange={(e) => setForm({ ...form, description: e.target.value })}
            />
            <Input
              label="Image URL"
              value={form.imageUrl}
              onChange={(e) => setForm({ ...form, imageUrl: e.target.value })}
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
