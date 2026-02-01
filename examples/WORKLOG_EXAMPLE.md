# Feature: User Registration Rate Limiting

## Mission

Prevent abuse of magic link emails by rate limiting requests per email and IP address.

## Skills Loaded

- `/api-patterns` — touches API response headers (429 status)
- `/rate-limiting` — reuses existing rate limit middleware

## Milestones

### M1: Write failing tests for rate limit violations

**Tests (RED):**
- [x] Test: 6th request from same email returns 429
- [x] Test: 11th request from same IP returns 429
- [x] Test: Error response includes retry-after header

**Implementation (GREEN):**
- [x] Add rate limit test fixtures
- [x] Write integration tests for both limits

**Commit:** `test(auth): add rate limit violation tests`

---

### M2: Implement rate limiting middleware

**Tests (RED):**
- [x] Test: Rate limits reset after window expires

**Implementation (GREEN):**
- [x] Extend existing `/lib/rate-limit.ts` with email tracking
- [x] Add IP-based rate limiting to magic link endpoint
- [x] Return proper 429 response with retry-after

**Commit:** `feat(auth): add rate limiting to magic link requests`

## Invariants

- **INV-1:** A single email cannot receive >5 magic links per hour
- **INV-2:** A single IP cannot request >10 magic links per hour

## Closing the Loop

- [x] Run `npm test` — all rate limit tests pass
- [x] Playwright: hit endpoint 6 times with same email, verify 429 on 6th
- [x] Verify error message displays "Too many requests. Try again in X minutes."
- [x] Check retry-after header is present and accurate

## Session Log

### 2026-01-15 - Session 1

**Goal:** Implement rate limiting for magic link requests

**Progress:**
- Completed M1: all tests written and failing as expected
- Started M2: found existing rate limiter in `/lib/rate-limit.ts`
- Commits: `test(auth): add rate limit violation tests`

**Blocked by:**
- Nothing

**Next session:**
- Finish M2 implementation
- Run Playwright verification

---

### 2026-01-16 - Session 2

**Goal:** Complete implementation and verify

**Progress:**
- Completed M2: extended existing rate limiter instead of building new
- All tests passing
- Playwright verification complete
- Commits: `feat(auth): add rate limiting to magic link requests`

**Blocked by:**
- Nothing

**Next session:**
- Feature complete, ready for PR

## Surprises

- Discovered existing rate limiter in `/lib/rate-limit.ts` — reusing instead of building new. Updated `/rate-limiting` skill with this pattern.
- The existing limiter used in-memory storage; works for single-server deploy but will need Redis for horizontal scaling (logged in BACKLOG.md).

## Decisions Made

| Decision | Rationale | Date |
|----------|-----------|------|
| Reuse existing rate limiter | Already tested, consistent API, less code to maintain | 2026-01-15 |
| 5/email, 10/IP limits | Matches PRODUCT_SPEC.md requirements, balances UX vs abuse prevention | 2026-01-15 |
| In-memory storage for MVP | Single server for now, Redis migration tracked in backlog | 2026-01-15 |

## Files Changed

- `lib/rate-limit.ts` - Extended with email-based tracking
- `app/api/auth/magic-link/route.ts` - Added rate limit middleware
- `__tests__/api/auth/magic-link.test.ts` - Rate limit test cases
