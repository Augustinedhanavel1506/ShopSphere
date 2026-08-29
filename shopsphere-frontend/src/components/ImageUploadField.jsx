import { useRef, useState } from 'react'
import { uploadImage } from '../services/uploads'
import { extractErrorMessage } from '../services/errorUtils'

export default function ImageUploadField({ value, onChange, placeholder = 'Image URL' }) {
  const fileInputRef = useRef(null)
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState('')

  const handleFileChange = async (e) => {
    const file = e.target.files?.[0]
    e.target.value = ''
    if (!file) return
    setUploading(true)
    setError('')
    try {
      const { url } = await uploadImage(file)
      onChange(url)
    } catch (err) {
      setError(extractErrorMessage(err))
    } finally {
      setUploading(false)
    }
  }

  return (
    <div className="flex flex-col gap-1">
      <div className="flex items-center gap-2">
        {value && <img src={value} alt="" className="h-10 w-10 shrink-0 rounded-lg border border-slate-200 object-cover" />}
        <input
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder={placeholder}
          className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/30"
        />
        <button
          type="button"
          onClick={() => fileInputRef.current?.click()}
          disabled={uploading}
          className="shrink-0 rounded-lg border border-slate-300 px-3 py-2 text-xs font-medium text-ink hover:bg-slate-50 disabled:opacity-50"
        >
          {uploading ? 'Uploading…' : 'Upload'}
        </button>
        <input
          ref={fileInputRef}
          type="file"
          accept="image/png,image/jpeg,image/webp,image/gif"
          className="hidden"
          onChange={handleFileChange}
        />
      </div>
      {error && <span className="text-xs text-red-600">{error}</span>}
    </div>
  )
}
