import Badge from './Badge'

const TONES = {
  PENDING: 'warning',
  PAID: 'info',
  CONFIRMED: 'info',
  PROCESSING: 'info',
  SHIPPED: 'success',
  DELIVERED: 'success',
  CANCELLED: 'danger',
}

export default function OrderStatusBadge({ status }) {
  return <Badge tone={TONES[status] ?? 'neutral'}>{status}</Badge>
}
