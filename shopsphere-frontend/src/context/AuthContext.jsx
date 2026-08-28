import { createContext, useContext, useEffect, useState, useCallback } from 'react'
import api, { setAccessToken, setUnauthorizedHandler } from '../services/api'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)

  const clearSession = useCallback(() => {
    setAccessToken(null)
    localStorage.removeItem('refreshToken')
    setUser(null)
  }, [])

  useEffect(() => {
    setUnauthorizedHandler(clearSession)
  }, [clearSession])

  useEffect(() => {
    const refreshToken = localStorage.getItem('refreshToken')
    if (!refreshToken) {
      setLoading(false)
      return
    }

    api
      .post('/api/auth/refresh', { refreshToken })
      .then(async ({ data }) => {
        setAccessToken(data.accessToken)
        localStorage.setItem('refreshToken', data.refreshToken)
        const me = await api.get('/api/users/me')
        setUser(me.data)
      })
      .catch(() => clearSession())
      .finally(() => setLoading(false))
  }, [clearSession])

  const login = async (email, password) => {
    const { data } = await api.post('/api/auth/login', { email, password })
    setAccessToken(data.accessToken)
    localStorage.setItem('refreshToken', data.refreshToken)
    const me = await api.get('/api/users/me')
    setUser(me.data)
    return me.data
  }

  const register = async (payload) => {
    const { data } = await api.post('/api/auth/register', payload)
    return data
  }

  const logout = async () => {
    const refreshToken = localStorage.getItem('refreshToken')
    if (refreshToken) {
      try {
        await api.post('/api/auth/logout', { refreshToken })
      } catch {
        // Already invalid/expired — fine to proceed with local cleanup regardless.
      }
    }
    clearSession()
  }

  const isAdmin = user?.roles?.includes('ADMIN') ?? false

  return (
    <AuthContext.Provider value={{ user, loading, login, register, logout, isAdmin }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth must be used within AuthProvider')
  return ctx
}
