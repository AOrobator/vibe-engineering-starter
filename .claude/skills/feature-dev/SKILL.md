---
name: feature-dev
description: Guide for implementing new features using TDD and worklogs. Use when starting a feature that will take more than one session.
---

# Feature Development

This skill guides you through implementing a feature using test-driven development with atomic commits.

## Before Starting

1. Read `PRODUCT_SPEC.md` for the feature requirements
2. Create a `WORKLOG.md` from the template (or use existing one)
3. Break the feature into milestones with clear test cases

## The TDD Rhythm

For each milestone:

### 1. RED: Write Failing Tests

```bash
# Write tests that describe the expected behavior
# Run tests to confirm they fail
npm test
```

Ask yourself:
- What should this code do when it works?
- What should happen when it fails?
- What edge cases exist?

### 2. GREEN: Implement Until Tests Pass

Write the minimum code to make tests pass. Don't over-engineer.

```bash
# Run tests after each change
npm test
```

### 3. COMMIT: Atomic Commit

```bash
git add -A
git commit -m "feat(scope): description"
```

One logical change per commit. The codebase should work after every commit.

### 4. Repeat

Move to the next milestone. Update the worklog.

## Agent Review Checkpoints

Run agent reviews at these points:
- After completing a milestone that touches security (auth, payments, data access)
- Before merging to main
- When you're unsure about an approach

```
@Security-Agent, review the authentication changes in this milestone
@UX-Agent, review the error handling in this flow
```

## Updating the Worklog

After each session:
1. Mark completed tasks
2. Log any surprises in "What Surprised the AI"
3. Add decisions to the decisions table
4. Write "Next session" notes

## When You're Done

1. Run full agent review
2. Ensure all tests pass
3. Run `/post-mortem` to capture lessons
4. Archive the worklog (move to `docs/worklogs/`)
