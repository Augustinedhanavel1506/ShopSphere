const STEPS = ['PENDING', 'PAID', 'CONFIRMED', 'PROCESSING', 'SHIPPED', 'DELIVERED']

export default function OrderStatusStepper({ status }) {
  if (status === 'CANCELLED') {
    return (
      <div className="rounded-xl bg-red-50 px-4 py-3 text-sm font-semibold text-red-600">This order was cancelled</div>
    )
  }

  const currentIndex = STEPS.indexOf(status)

  return (
    <div className="flex items-center">
      {STEPS.map((step, i) => (
        <div key={step} className="flex flex-1 items-center last:flex-none">
          <div className="flex flex-col items-center gap-1">
            <div
              className={`flex h-8 w-8 items-center justify-center rounded-full text-xs font-bold ${
                i <= currentIndex ? 'bg-primary text-white' : 'bg-slate-200 text-muted'
              }`}
            >
              {i < currentIndex ? '✓' : i + 1}
            </div>
            <span className={`text-[11px] ${i <= currentIndex ? 'font-semibold text-ink' : 'text-muted'}`}>
              {step.charAt(0) + step.slice(1).toLowerCase()}
            </span>
          </div>
          {i < STEPS.length - 1 && (
            <div className={`mx-1 h-0.5 flex-1 ${i < currentIndex ? 'bg-primary' : 'bg-slate-200'}`} />
          )}
        </div>
      ))}
    </div>
  )
}
