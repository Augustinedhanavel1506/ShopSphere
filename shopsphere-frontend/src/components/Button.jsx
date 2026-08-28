const variants = {
  primary: 'bg-primary hover:bg-primary-dark text-white',
  cta: 'bg-cta hover:bg-cta-dark text-white',
  secondary: 'bg-white border border-slate-300 text-ink hover:bg-slate-50',
  danger: 'bg-white border border-red-300 text-red-600 hover:bg-red-50',
}

export default function Button({ variant = 'primary', className = '', disabled, children, ...props }) {
  return (
    <button
      className={`inline-flex items-center justify-center gap-2 rounded-xl px-5 py-2.5 font-semibold text-sm
        transition-colors duration-150 disabled:opacity-50 disabled:cursor-not-allowed
        ${variants[variant]} ${className}`}
      disabled={disabled}
      {...props}
    >
      {children}
    </button>
  )
}
