# System Spec Example: API Contract

This example shows how to document an API contract before implementation. Define the request shape, success response, and every error code upfront. The AI gets everything it needs in one place.

---

## API Contract: POST /invoices

### Request
```json
{
  "quoteId": "uuid",
  "type": "PLATFORM_FEE" | "TICKET"
}
```

### Success Response (201)
```json
{
  "id": "uuid",
  "paymentRequest": "lnbc...",
  "expiresAt": "ISO8601"
}
```

### Error Responses
- 400: Invalid request body
- 404: Quote not found
- 409: Invoice already exists for this quote/type
- 503: Lightning node unavailable

---

## Why This Works

When you define API contracts upfront:
- **Error codes are decided**, not invented during implementation
- **Response shapes are locked**, preventing drift
- **Edge cases are documented** (quote not found, duplicate invoice)

The AI implements the contract. You verify it matches. No surprises.
