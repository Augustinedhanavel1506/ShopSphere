import { useEffect, useRef, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import api from '../services/api'
import { extractErrorMessage } from '../services/errorUtils'
import Card from '../components/Card'
import Button from '../components/Button'

export default function VerifyEmail() {
  const [searchParams] = useSearchParams()
  const token = searchParams.get('token')
  const [status, setStatus] = useState('loading') // loading | success | error
  const [message, setMessage] = useState('')
  const requestedRef = useRef(null)

  useEffect(() => {
    if (!token) {
      setStatus('error')
      setMessage('No verification token provided.')
      return
    }

    // Guards against React StrictMode's dev-only double-invoke firing this
    // one-time-use request twice for the same token.
    if (requestedRef.current === token) return
    requestedRef.current = token

    api
      .get('/api/auth/verify-email', { params: { token } })
      .then((res) => {
        setStatus('success')
        setMessage(res.data.message)
      })
      .catch((err) => {
        setStatus('error')
        setMessage(extractErrorMessage(err))
      })
  }, [token])

  return (
    <div className="mx-auto flex min-h-[80vh] max-w-md flex-col justify-center px-4">
      <Card className="text-center">
        {status === 'loading' && <p className="text-sm text-muted">Verifying your email…</p>}

        {status === 'success' && (
          <>
            <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-emerald-50 text-2xl">
              ✅
            </div>
            <h1 className="mb-2 text-xl font-bold text-ink">Email Verified</h1>
            <p className="mb-6 text-sm text-muted">{message}</p>
            <Link to="/login">
              <Button className="w-full">Go to Login</Button>
            </Link>
          </>
        )}

        {status === 'error' && (
          <>
            <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-red-50 text-2xl">
              ⚠️
            </div>
            <h1 className="mb-2 text-xl font-bold text-ink">Verification Failed</h1>
            <p className="mb-6 text-sm text-muted">{message}</p>
            <Link to="/resend-verification">
              <Button variant="secondary" className="w-full">
                Resend Verification Email
              </Button>
            </Link>
          </>
        )}
      </Card>
    </div>
  )
}
