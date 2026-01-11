# CI Spec Example: Job Documentation

This example shows how to document CI jobs so that failures are self-explanatory. Each job links back to *why* it exists and *how* to fix common failures.

---

### Prisma Validation

**Why this exists:** Per post-mortem `2025-12-25_migration-ordering-failure.md`:
Two migrations were out of order. Prisma replays migrations into a shadow
DB, so the history could not be applied from empty.

**Failure fix:**
1. Check migration order in `prisma/migrations/`
2. Ensure drops come AFTER backfills (two-step pattern)
3. If history is broken, consider baseline recovery

---

## Why This Works

Every CI job should answer three questions:
1. **What** does this check?
2. **Why** does this check exist? (link to the post-mortem or decision trace)
3. **How** do you fix it when it fails?

When CI fails at 2am, the spec tells you exactly what to do. No archaeology required.
