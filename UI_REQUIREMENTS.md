# ShopSphere — Frontend UI Requirements

This document describes what needs to be designed for ShopSphere's React frontend. The backend (Spring Boot + MySQL) is fully built and running at `http://localhost:8080`. This doc is meant to be handed to a design tool (e.g. ChatGPT, Claude, Figma AI) to produce mockups, wireframes, or component designs.

## Tech context
- Frontend framework: **React**
- Backend: REST API, JSON, JWT bearer-token auth (`Authorization: Bearer <token>`)
- Auth uses **short-lived access tokens (15 min) + long-lived refresh tokens (7 days)** — the frontend must silently call `/api/auth/refresh` when an access token expires (e.g. on a `401`), and store both tokens (refresh token should be handled carefully, e.g. httpOnly cookie if the backend is later adapted, or secure storage)
- Two user roles: **CUSTOMER** and **ADMIN** — the same person could have both roles
- Email verification is **required** — a newly registered user cannot log in until they click the link emailed to them
- No server-side rendering requirement; this is a client-rendered SPA talking to the REST API

---

## 1. Customer-facing UI

### Public pages (no login required)
- **Home / landing page** — featured products or categories, call to action to browse/sign up
- **Category browse** — list of active categories (each may have an image), click into a category to see its products
- **Product listing** — grid/list of products, filterable by category, showing name, price, **original price with strikethrough + discount % badge when on sale**, image, average rating, in-stock/out-of-stock badge
- **Search results page** — text search across product name/description
- **Product detail page** — image gallery, name, description, price (+ original price/discount badge if applicable), **specifications table** (key/value pairs), stock status, average rating + review count, review list, "Add to Cart" and "Add to Wishlist" buttons (prompt login if not authenticated)
- **Login page**
- **Register page** — after submitting, show a "check your email to verify your account" message (don't imply they're logged in yet)
- **Email verification landing** — the emailed link hits a backend GET endpoint; frontend should have a page/route that calls it and shows success/failure, with a "resend verification email" option on failure
- **Forgot password page** — enter email, always shows a generic "if that email exists, we sent a link" message
- **Reset password page** — enter new password using the token from the emailed link

### Authenticated customer pages
- **My Cart** — active line items (image, name, unit price, quantity, line total), quantity +/- controls, remove item, "Save for later" button per item, subtotal, discount (if coupon applied), tax, coupon code input + validate-before-apply, final total, "Checkout" button
- **Saved for later** — a separate section/tab within the cart page showing saved items with "Move to cart" and "Remove" actions (these do NOT count toward cart totals or checkout)
- **Checkout page** — choose a saved address from **My Addresses** or enter one inline, optional coupon code entry, order summary (subtotal, discount, tax, total), "Place Order" button
- **My Addresses** — list of saved addresses with a default badge, add/edit/delete, "Set as default" action
- **My Orders** — list of past orders (id, date, status badge, total), click into an order for detail
- **Order detail page** — shipping address, item list, subtotal/discount/tax/total breakdown, status, **tracking number + carrier (once shipped)**, "Pay Now" button (if PENDING), "Cancel Order" button (only if PENDING), payment info (if paid)
- **Payment page/modal** — choose payment method (CARD / UPI / NET_BANKING / COD), confirm payment
- **My Wishlist** — saved products, "Move to Cart" and "Remove" actions
- **My Profile** — name, email, phone (read-only view is fine for now; edit not yet built on backend)
- **Write/edit a review** — star rating input + comment, shown on product detail page (only visible to users who purchased the product — attempting to review without a purchase returns `403`)

### Order status values (customer-facing)
`PENDING → PAID → CONFIRMED → PROCESSING → SHIPPED → DELIVERED`, or `CANCELLED` (only reachable from PENDING/PAID/CONFIRMED/PROCESSING, not from SHIPPED/DELIVERED). Design a status badge/stepper that reflects this linear progression.

### Key UX notes
- Nav bar should reflect auth state: Login/Register when logged out; Cart icon (with item count), Wishlist icon, Orders, Profile/Logout when logged in
- Cart and Wishlist actions should show clear feedback (toast/snackbar) since some actions are silently idempotent (e.g. re-adding to wishlist) or blocked (e.g. exceeding stock)
- Reviews section on product page should visually distinguish "you must purchase this product to review it" state
- Show clear error messages for validation failures (e.g. "Only 3 left in stock", "Coupon requires minimum order of $50")
- "Cancel order" button should only render when status is PENDING

---

## 2. Admin UI

### Dashboard (landing page for admin)
- Summary cards: total revenue, total orders, pending/paid/cancelled order counts, total customers, total products, low-stock count
- **Date range filter** for the dashboard: quick-select buttons (Today / This Week / This Month / This Year) or a custom from/to date picker — affects revenue and order counts (customer/product counts are always all-time)
- Low-stock product list/table
- Recent orders table (id, customer, status, total, date) with link to order detail — also affected by the date filter

### Management screens (all ADMIN-only)
- **Categories** — table with create/edit/delete; form includes name, description, image URL, active/inactive toggle (inactive categories are hidden from public browsing but still visible here)
- **Products** — table with create/edit/delete; form includes category dropdown, name, description, price, **original price** (optional, for showing a strikethrough/discount), SKU, active toggle, multiple image URLs (add/remove/reorder), **specifications** (add/remove key-value rows)
- **Inventory** — per-product stock view; set absolute quantity or adjust by a delta (+/- restock/correction); **transaction history view** (table of changeQuantity, resultingQuantity, reason [INITIAL/MANUAL_ADJUSTMENT/ORDER_PLACED/ORDER_CANCELLED], timestamp) — should link from the Products table
- **Orders (all customers)** — table of all orders, filter/search by status; view detail; **update order status** (a dropdown/button flow respecting the state machine above) with tracking number + carrier fields shown when transitioning to SHIPPED
- **Coupons** — table with create/edit/delete; form includes code, discount type (percentage/fixed) with conditional UI (percentage caps at 100), discount value, min order amount, **max discount amount** (caps how much a percentage coupon can discount), max uses, expiry date, active toggle
- **Reviews (moderation)** — ability to delete any review (spam/abuse) — no dedicated "list all reviews" endpoint exists yet, so this is scoped per-product for now

### Key UX notes
- Admin should NOT see customer-only screens (cart/wishlist have no meaning for admin-only actions)
- Every mutating action (create/edit/delete) needs a confirmation step for deletes
- Form validation should mirror backend rules (e.g. price ≥ 0, percentage discount ≤ 100)
- Order status transitions should only offer the *next legal* status/statuses, not a free-form dropdown of all statuses

---

## 3. Full API reference

Base URL: `http://localhost:8080`. All request/response bodies are JSON. Endpoints not marked "Public" require `Authorization: Bearer <accessToken>`. Endpoints marked "Admin" additionally require the ADMIN role (customer-only users get `403`).

### Auth
| Method | Path | Access | Notes |
|---|---|---|---|
| POST | `/api/auth/register` | Public | body: `firstName, lastName, email, password, phone`. Sends a verification email; user cannot log in until verified |
| POST | `/api/auth/login` | Public | body: `email, password` → returns `accessToken, refreshToken, tokenType, userId, email, roles`. `403` if email not verified |
| POST | `/api/auth/refresh` | Public | body: `refreshToken` → returns a new token pair (rotation: old refresh token is invalidated) |
| POST | `/api/auth/logout` | Public | body: `refreshToken` → revokes it. Idempotent (always succeeds, even for an already-invalid token). Access tokens are stateless and remain valid until natural 15-min expiry |
| GET | `/api/auth/verify-email?token=` | Public | called from the emailed link |
| POST | `/api/auth/resend-verification` | Public | body: `email` |
| POST | `/api/auth/forgot-password` | Public | body: `email`. Always returns a generic success message, never reveals whether the email exists |
| POST | `/api/auth/reset-password` | Public | body: `token, newPassword` |
| GET | `/api/users/me` | Auth | current user's profile |

### Addresses
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/addresses` | Auth | list, default-first |
| POST | `/api/addresses` | Auth | body: `fullName, phone, line1, line2, city, state, postalCode, country, isDefault`. First address is always forced default |
| PUT | `/api/addresses/{id}` | Auth | |
| DELETE | `/api/addresses/{id}` | Auth | if the default is deleted, another address is auto-promoted |
| PUT | `/api/addresses/{id}/default` | Auth | |

### Categories
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/categories` | Public/Auth | public callers see only `active=true`; ADMIN sees all |
| GET | `/api/categories/{id}` | Public | |
| POST | `/api/categories` | Admin | body: `name, description, imageUrl, active` |
| PUT | `/api/categories/{id}` | Admin | |
| DELETE | `/api/categories/{id}` | Admin | |

### Products
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/products?categoryId=` | Public | `categoryId` optional filter |
| GET | `/api/products/{id}` | Public | |
| GET | `/api/products/search?q=` | Public | matches name or description, case-insensitive |
| POST | `/api/products` | Admin | body: `categoryId, name, description, price, originalPrice, sku, active, images[], specifications[{key,value}]` |
| PUT | `/api/products/{id}` | Admin | replaces image set and specification set |
| DELETE | `/api/products/{id}` | Admin | |

Product response includes `discountPercentage` (computed server-side when `originalPrice > price`).

### Inventory
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/inventory/{productId}` | Public | returns `productId, quantity, inStock, updatedAt` |
| PUT | `/api/inventory/{productId}` | Admin | body: `quantity` (absolute) |
| POST | `/api/inventory/{productId}/adjust` | Admin | body: `delta` (relative, can be negative) |
| GET | `/api/inventory/{productId}/history` | Admin | returns a list of `{id, changeQuantity, resultingQuantity, reason, createdAt}`, newest first |

### Cart
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/cart` | Auth | returns `items[]` (active) and `savedItems[]` (saved for later) separately; totals only reflect `items` |
| POST | `/api/cart/items` | Auth | body: `productId, quantity` — merges with existing active line |
| PUT | `/api/cart/items/{productId}` | Auth | body: `quantity` |
| DELETE | `/api/cart/items/{productId}` | Auth | removes regardless of saved state |
| DELETE | `/api/cart` | Auth | clears active items only; saved-for-later items are untouched |
| POST | `/api/cart/items/{productId}/save-for-later` | Auth | moves an active item to saved |
| POST | `/api/cart/items/{productId}/move-to-cart` | Auth | moves a saved item back to active (re-validates stock) |

### Wishlist
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/wishlist` | Auth | |
| POST | `/api/wishlist/items` | Auth | body: `productId` — adding a duplicate is a silent no-op |
| DELETE | `/api/wishlist/items/{productId}` | Auth | |

### Reviews
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/reviews/products/{productId}` | Public | returns `averageRating, totalReviews, reviews[]` |
| POST | `/api/reviews/products/{productId}` | Auth | body: `rating (1-5), comment`. Requires a verified (non-cancelled) purchase of the product — `403` otherwise |
| PUT | `/api/reviews/products/{productId}` | Auth | edit own review |
| DELETE | `/api/reviews/{reviewId}` | Auth | owner or Admin (moderation) |

### Checkout / Orders
| Method | Path | Access | Notes |
|---|---|---|---|
| POST | `/api/orders` | Auth | checkout — body: **either** `addressId` (a saved address) **or** `shippingAddress {fullName, phone, line1, line2, city, state, postalCode, country}` inline, plus optional `couponCode` |
| GET | `/api/orders` | Auth | current user's order history |
| GET | `/api/orders/{id}` | Auth | owner or Admin |
| PUT | `/api/orders/{id}/cancel` | Auth | owner or Admin; only works on PENDING orders |
| PUT | `/api/orders/{id}/status` | Admin | body: `status, trackingNumber, carrier` (tracking fields only meaningful when moving to SHIPPED). Enforces the state machine — illegal transitions return `400` |

Order response includes: `id, status, subtotal, couponCode, discountAmount, taxAmount, totalAmount, trackingNumber, carrier, shippingAddress, items[], createdAt, updatedAt`. `totalAmount = subtotal − discountAmount + taxAmount`.

### Payments
| Method | Path | Access | Notes |
|---|---|---|---|
| POST | `/api/orders/{orderId}/pay` | Auth | owner only — body: `method (CARD/UPI/NET_BANKING/COD)`. Only works on PENDING orders |
| GET | `/api/orders/{orderId}/payment` | Auth | owner or Admin |

### Coupons
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/coupons` | Admin | list all |
| POST | `/api/coupons` | Admin | body: `code, discountType (PERCENTAGE/FIXED), discountValue, minOrderAmount, maxUses, maxDiscountAmount, expiresAt, active` |
| PUT | `/api/coupons/{id}` | Admin | |
| DELETE | `/api/coupons/{id}` | Admin | |
| GET | `/api/coupons/validate?code=&orderTotal=` | Auth | preview a discount before checkout, without consuming a use |

### Admin dashboard
| Method | Path | Access | Notes |
|---|---|---|---|
| GET | `/api/admin/dashboard/summary?lowStockThreshold=5&period=&from=&to=` | Admin | `period` = `today\|week\|month\|year`, or use explicit ISO `from`/`to` instead. Omit both for all-time |
| GET | `/api/admin/dashboard/low-stock?threshold=5` | Admin | |
| GET | `/api/admin/dashboard/recent-orders?limit=10&period=&from=&to=` | Admin | same date-filter params as summary |

### Common error shape
```json
{ "status": 404, "message": "Product not found with id 5", "timestamp": "2026-08-28T12:00:00" }
```
Validation errors (400) instead return a field → message map, e.g. `{ "email": "Email must be valid" }`.

---

## 4. Suggested design deliverables to ask for
- A component/page inventory matching the lists above
- A color palette + typography system
- Wireframes for: Home, Product Listing/Search, Product Detail, Cart (with saved-for-later), Checkout, Addresses, Order History/Detail, Login/Register/Verify/Forgot-Reset Password (customer) and Dashboard (with date filter), Product/Category/Coupon/Inventory management tables + forms, Order status management (admin)
- Responsive behavior notes (mobile vs desktop) if relevant
