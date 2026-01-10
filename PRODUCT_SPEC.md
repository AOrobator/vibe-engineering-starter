# Product Specification

> Replace this template with your actual product specification.
> The more precise your spec, the more precise the AI's implementation.

## Overview

[One paragraph describing what this product does and who it's for]

## Core Flows

### [Flow Name]

**Happy Path:**
1. User does X
2. System responds with Y
3. User sees Z

**Sad Paths:**
- If [condition], show [error message] with [recovery action]
- If [condition], [fallback behavior]

**Edge Cases:**
- [Edge case and how to handle it]

---

### [Another Flow]

**Happy Path:**
1. ...

**Sad Paths:**
- ...

**Edge Cases:**
- ...

---

## Constraints

- [Technical constraint 1]
- [Business rule 1]
- [Performance requirement 1]

## NOT in This Version

> This section is critical. It prevents scope creep and keeps the AI focused.

- [Feature explicitly deferred]
- [Nice-to-have not included]
- [Future enhancement]

## Data Model

### [Entity 1]

| Field | Type | Notes |
|-------|------|-------|
| id | UUID | Primary key |
| ... | ... | ... |

### [Entity 2]

...

## API Contracts

### [Endpoint 1]

```
POST /api/[resource]

Request:
{
  "field": "value"
}

Response (200):
{
  "success": true,
  "data": { ... }
}

Response (400):
{
  "success": false,
  "error": "Description"
}
```

## Rate Limits

- [Endpoint]: [limit] per [period]
- ...

## Security Considerations

- [Authentication requirement]
- [Authorization rule]
- [Data protection requirement]

---

## Tips for Writing Good Specs

1. **Bundle happy/sad/edge together.** Each flow is a complete unit. Don't separate error handling from the flow it belongs to.

2. **Be specific about error states.** "Handle errors gracefully" is vague. "Show 'Payment failed. Please try again or contact support@example.com' with a retry button" is specific.

3. **Define what's NOT included.** This is as important as what IS included. It prevents the AI from adding features you don't want.

4. **Include examples.** Show sample API requests/responses. Show sample data. Concrete examples beat abstract descriptions.

5. **Update as you learn.** The spec is a living document. When you discover edge cases during implementation, add them to the spec.
