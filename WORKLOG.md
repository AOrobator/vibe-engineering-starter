# [Feature Name] Worklog

> Copy this template when starting a new feature. Delete these instructions when you fill it in.

## Mission

[One sentence: what are we building and why]

## Milestones

### M1: [First Milestone]

**Tests (RED):**
- [ ] Test: [Expected behavior 1]
- [ ] Test: [Expected behavior 2]

**Implementation (GREEN):**
- [ ] [Implementation task]
- [ ] [Implementation task]

**Commit:** `feat(scope): [description]`

---

### M2: [Second Milestone]

**Tests (RED):**
- [ ] Test: [Expected behavior]

**Implementation (GREEN):**
- [ ] [Implementation task]

**Commit:** `feat(scope): [description]`

---

### M3: [Third Milestone]

**Tests (RED):**
- [ ] Test: [Expected behavior]

**Implementation (GREEN):**
- [ ] [Implementation task]

**Commit:** `feat(scope): [description]`

## Invariants

> Rules that must always be true. Violations are bugs.

- **INV-1:** [Invariant description]
- **INV-2:** [Invariant description]

## Session Log

### [Date] - Session 1

**Goal:** [What we're trying to accomplish this session]

**Progress:**
- [What got done]
- [Commits made]

**Blocked by:**
- [If anything]

**Next session:**
- [What to pick up]

---

### [Date] - Session 2

...

## What Surprised the AI

> Capture surprises in real-time. These often become skills or agent updates.

- [Unexpected behavior or edge case]
- [Assumption that turned out to be wrong]
- [Pattern that worked better than expected]

## Decisions Made

| Decision | Rationale | Date |
|----------|-----------|------|
| [Choice made] | [Why] | [When] |

## Files Changed

> Helps with context restoration in new sessions

- `path/to/file.ts` - [brief description of changes]
- `path/to/other.ts` - [brief description]

---

## Worklog Protocol

1. **TDD rhythm:** Write failing tests first (RED), then implement until they pass (GREEN), then commit.

2. **Atomic commits:** One logical change per commit. Each commit should leave the codebase in a working state.

3. **Update in real-time.** Don't batch updates at the end of a session. Capture decisions and surprises as they happen.

4. **Be specific about blockers.** "Stuck" is not useful. "Stuck because the API returns 403 and I don't know why" is useful.

5. **End sessions with "Next session" notes.** Future you (or future AI) will thank you.
