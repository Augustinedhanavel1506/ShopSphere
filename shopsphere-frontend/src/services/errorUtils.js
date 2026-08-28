/**
 * The backend returns either { status, message, timestamp } for most errors,
 * or a plain { field: message } map for validation (400) errors.
 */
export function extractErrorMessage(error) {
  const data = error?.response?.data
  if (!data) return 'Something went wrong. Please try again.'
  if (typeof data.message === 'string') return data.message
  if (typeof data === 'object') {
    const firstFieldError = Object.values(data)[0]
    if (typeof firstFieldError === 'string') return firstFieldError
  }
  return 'Something went wrong. Please try again.'
}
