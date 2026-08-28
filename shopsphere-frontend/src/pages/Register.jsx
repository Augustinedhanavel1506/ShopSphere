import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { extractErrorMessage } from '../services/errorUtils'
import Card from '../components/Card'
import Input from '../components/Input'
import Button from '../components/Button'

export default function Register() {
  const { register } = useAuth()
  const navigate = useNavigate()
  const [form, setForm] = useState({ firstName: '', lastName: '', email: '', phone: '', password: '' })
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')
  const [done, setDone] = useState(false)

  const handleChange = (e) => setForm((f) => ({ ...f, [e.target.name]: e.target.value }))

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setSubmitting(true)
    try {
      await register(form)
      setDone(true)
    } catch (err) {
      setError(extractErrorMessage(err))
    } finally {
      setSubmitting(false)
    }
  }

  if (done) {
    return (
      <div className="mx-auto flex min-h-[80vh] max-w-md flex-col justify-center px-4">
        <Card className="text-center">
          <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-emerald-50 text-2xl">
            ✉️
          </div>
          <h1 className="mb-2 text-xl font-bold text-ink">Check your email</h1>
          <p className="mb-6 text-sm text-muted">
            We sent a verification link to <span className="font-medium text-ink">{form.email}</span>. Click it to
            activate your account before logging in.
          </p>
          <Button onClick={() => navigate('/login')} className="w-full">
            Go to Login
          </Button>
        </Card>
      </div>
    )
  }

  return (
    <div className="mx-auto flex min-h-[80vh] max-w-md flex-col justify-center px-4 py-10">
      <Card>
        <h1 className="mb-1 text-2xl font-bold text-ink">Create Account</h1>
        <p className="mb-6 text-sm text-muted">Join us today</p>

        <form onSubmit={handleSubmit} className="flex flex-col gap-4">
          <div className="grid grid-cols-2 gap-3">
            <Input
              label="First Name"
              name="firstName"
              required
              value={form.firstName}
              onChange={handleChange}
              placeholder="John"
            />
            <Input
              label="Last Name"
              name="lastName"
              value={form.lastName}
              onChange={handleChange}
              placeholder="Doe"
            />
          </div>
          <Input
            label="Email Address"
            type="email"
            name="email"
            required
            value={form.email}
            onChange={handleChange}
            placeholder="you@example.com"
          />
          <Input label="Phone" name="phone" value={form.phone} onChange={handleChange} placeholder="Optional" />
          <Input
            label="Password"
            type="password"
            name="password"
            required
            minLength={8}
            value={form.password}
            onChange={handleChange}
            placeholder="At least 8 characters"
          />

          {error && <p className="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600">{error}</p>}

          <Button type="submit" disabled={submitting} className="w-full">
            {submitting ? 'Creating account…' : 'Register'}
          </Button>
        </form>

        <p className="mt-6 text-center text-sm text-muted">
          Already have an account?{' '}
          <Link to="/login" className="font-medium text-primary hover:underline">
            Login
          </Link>
        </p>
      </Card>
    </div>
  )
}
