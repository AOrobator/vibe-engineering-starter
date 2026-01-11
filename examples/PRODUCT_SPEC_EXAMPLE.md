# Product Spec Example: User Registration Flow

This example shows how to document a user flow in your `PRODUCT_SPEC.md`. Notice how it covers happy paths, sad paths, and constraints—giving the AI everything it needs to implement without guessing.

---

## User Registration Flow

### Happy Path
1. User enters email on /login
2. System sends magic link email
3. User clicks link within 24 hours
4. System creates session, redirects to /dashboard

### Sad Paths
- Invalid email format → Show inline validation error
- Email send fails → Show error, suggest retry
- Link expired → Redirect to /login?error=expired
- Link already used → Redirect to /login?error=used

### Constraints
- Rate limit: 5 magic links per email per hour
- Rate limit: 10 magic links per IP per hour
- Token storage: SHA256 hash (never store plaintext)
- Session: HTTP-only cookie, 7-day expiry

---

## Why This Works

When you give the AI this level of detail:
- **No guessing** about expiry times
- **No inventing** rate limits
- **No "should I hash the token?"** decisions

The spec is the source of truth. The AI implements; you verify it matches the spec.
