# [Feature Name] Worklog

> Copy this template when starting a new feature. Delete these instructions when you fill it in.
>
> **Smell Test:** If your worklog is longer than 100 lines for a simple feature, cut sections, not detail. 50-100 lines is normal. If your worklog is longer than your implementation will be, you've over-engineered it.

## Mission

[One sentence: what are we building and why]

## Skills Loaded

> Load skills for *everything*, no matter how small. Large codebases have gotchas. This prevents "I didn't know that existed" mistakes.

- `/skill-name` — [why this skill applies]
- `/skill-name` — [why this skill applies]

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

## Invariants

> Rules that must always be true. Violations are bugs. Use for payments, auth, rate limiting, data privacy—anywhere "almost right" ships a bug. Skip for UI-only changes or simple CRUD.

- **INV-1:** [Invariant description]
- **INV-2:** [Invariant description]

## Closing the Loop

> A milestone isn't done when tests pass—it's done when you've *seen it work*. Without explicit verification, the agent marks "done" after writing code, not after proving it works.

- [ ] Run `npm test` — all tests pass
- [ ] [Playwright/browser verification step]
- [ ] [Edge case verification]

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

## Surprises

> Capture surprises in real-time. Then immediately update the relevant skill so the next feature benefits. The context is freshest right after you hit the issue.

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

6. **Close the loop.** Don't mark done until you've verified it works—not just that the code looks right.
