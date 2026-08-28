export default function Input({ label, error, className = '', ...props }) {
  return (
    <label className="block text-left">
      {label && <span className="mb-1.5 block text-sm font-medium text-ink">{label}</span>}
      <input
        className={`w-full rounded-xl border px-3.5 py-2.5 text-sm text-ink placeholder:text-muted
          focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary
          ${error ? 'border-red-400' : 'border-slate-300'} ${className}`}
        {...props}
      />
      {error && <span className="mt-1 block text-xs text-red-600">{error}</span>}
    </label>
  )
}
