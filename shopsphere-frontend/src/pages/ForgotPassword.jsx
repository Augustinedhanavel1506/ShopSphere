import { useState } from 'react'
import { Link } from 'react-router-dom'
import api from '../services/api'
import { extractErrorMessage } from '../services/errorUtils'
import Card from '../components/Card'
import Input from '../components/Input'
import Button from '../components/Button'

export default function ForgotPassword() {
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [message, setMessage] = useState('')
  const [error, setError] = useState('')

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setSubmitting(true)
    try {
      const { data } = await api.post('/api/auth/forgot-password', { email })
      setMessage(data.message)
    } catch (err) {
      setError(extractErrorMessage(err))
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="mx-auto flex min-h-[80vh] max-w-md flex-col justify-center px-4">
      <Card>
        <h1 className="mb-1 text-2xl font-bold text-ink">Forgot Password?</h1>
        <p className="mb-6 text-sm text-muted">Enter your email and we'll send you a reset link.</p>

        {message ? (
          <p className="rounded-lg bg-emerald-50 px-3 py-2 text-sm text-success">{message}</p>
        ) : (
          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <Input
              label="Email Address"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@example.com"
            />

            {error && <p className="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600">{error}</p>}

            <Button type="submit" disabled={submitting} className="w-full">
              {submitting ? 'Sending…' : 'Send Reset Link'}
            </Button>
          </form>
        )}

        <p className="mt-6 text-center text-sm text-muted">
          <Link to="/login" className="font-medium text-primary hover:underline">
            Back to Login
          </Link>
        </p>
      </Card>
    </div>
  )
}
