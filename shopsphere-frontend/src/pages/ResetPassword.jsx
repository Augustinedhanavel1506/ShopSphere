import { useState } from 'react'
import { Link, useNavigate, useSearchParams } from 'react-router-dom'
import api from '../services/api'
import { extractErrorMessage } from '../services/errorUtils'
import Card from '../components/Card'
import Input from '../components/Input'
import Button from '../components/Button'

export default function ResetPassword() {
  const [searchParams] = useSearchParams()
  const token = searchParams.get('token')
  const navigate = useNavigate()
  const [newPassword, setNewPassword] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')
  const [done, setDone] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setSubmitting(true)
    try {
      await api.post('/api/auth/reset-password', { token, newPassword })
      setDone(true)
    } catch (err) {
      setError(extractErrorMessage(err))
    } finally {
      setSubmitting(false)
    }
  }

  if (!token) {
    return (
      <div className="mx-auto flex min-h-[80vh] max-w-md flex-col justify-center px-4">
        <Card className="text-center">
          <h1 className="mb-2 text-xl font-bold text-ink">Invalid Link</h1>
          <p className="text-sm text-muted">This reset link is missing its token. Please request a new one.</p>
          <Link to="/forgot-password" className="mt-4 inline-block text-sm font-medium text-primary hover:underline">
            Request a new link
          </Link>
        </Card>
      </div>
    )
  }

  if (done) {
    return (
      <div className="mx-auto flex min-h-[80vh] max-w-md flex-col justify-center px-4">
        <Card className="text-center">
          <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-emerald-50 text-2xl">
            ✅
          </div>
          <h1 className="mb-2 text-xl font-bold text-ink">Password Reset</h1>
          <p className="mb-6 text-sm text-muted">You can now log in with your new password.</p>
          <Button onClick={() => navigate('/login')} className="w-full">
            Go to Login
          </Button>
        </Card>
      </div>
    )
  }

  return (
    <div className="mx-auto flex min-h-[80vh] max-w-md flex-col justify-center px-4">
      <Card>
        <h1 className="mb-1 text-2xl font-bold text-ink">Reset Password</h1>
        <p className="mb-6 text-sm text-muted">Choose a new password for your account.</p>

        <form onSubmit={handleSubmit} className="flex flex-col gap-4">
          <Input
            label="New Password"
            type="password"
            required
            minLength={8}
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
            placeholder="At least 8 characters"
          />

          {error && <p className="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600">{error}</p>}

          <Button type="submit" disabled={submitting} className="w-full">
            {submitting ? 'Resetting…' : 'Reset Password'}
          </Button>
        </form>
      </Card>
    </div>
  )
}
