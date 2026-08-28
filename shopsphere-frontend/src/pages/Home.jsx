import { Link } from 'react-router-dom'
import Button from '../components/Button'

export default function Home() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-16 text-center">
      <h1 className="mb-4 text-4xl font-extrabold text-ink">Shop Everything You Love</h1>
      <p className="mb-8 text-muted">Top quality products, best prices, fast delivery.</p>
      <Link to="/products">
        <Button variant="cta">Shop Now</Button>
      </Link>
    </div>
  )
}
