# Vibe Engineering: From Random Code to Deterministic Systems

## Part 4: Worklogs — How AI Work Persists Over Time

*By Andrew Orobator and Claude Opus 4.5*

*This is Part 4 of a 7-part series on AI-assisted development workflows.*

1. You Haven't Been Replaced — You've Been Promoted
2. Personas — How to Think With AI
3. Skills — How to Encode What You Learn
4. **Worklogs — How AI Work Persists Over Time** ← You are here
5. The Feedback Loop — How Systems Improve Themselves
6. Designing Failure Before It Designs You
7. Scaling the Vibes

---

> **📍 Checkpoint:** If you only adopt one thing from this series, make it WORKLOG.md. Everything else compounds on top of it.

In Parts 2 and 3, we covered personas (thinking) and skills (knowledge). Those teach AI how to think and what patterns to follow.

This article covers the third primitive: **Worklogs**. Worklogs are how AI work survives across sessions. They're the closest thing to memory.

I've published a [starter kit](https://github.com/AOrobator/vibe-engineering-starter) with templates for everything in this series—fork it and adapt to your project.

---

## Worklogs: The Backbone

A worklog is a living document that combines:
- **Plan** — what you're going to do (before)
- **Decisions** — why you did it that way (during)
- **Session log** — where you left off (after each session)
- **Surprises** — what you learned (during)

Unlike a plan, which is written and then executed, a worklog evolves as you work. A plan is a prediction; a worklog is a record that starts with one.

**The key insight: Claude writes the worklog. You steer it.**

You describe what you want to build. Claude creates the worklog, breaks it into milestones, identifies the invariants, and updates it as work progresses. Your job is to review, redirect, and approve—not to write the document yourself. This is the division of labor: you provide direction and judgment, Claude provides structure and memory.

To kick it off, I say something like:

> "Create a worklog for adding rate limiting to user registration. Load the `/api-patterns` and `/rate-limiting` skills."

Claude produces the worklog. I review it, adjust the milestones if needed, and we start.

Worklogs solve three problems:

1. **Context restoration** — AI sessions end, worklogs persist
2. **Auditability** — what decisions were made and why
3. **Scope control** — explicit milestones prevent gold-plating

> **🤖 Claude's Take:** Worklogs are the closest thing to memory I have across sessions. When a session starts and I read the worklog, I know what's been tried, what decisions were made, and where we left off. Because I'm the one writing and updating it, there's no translation loss—the worklog is my memory, written in my own words.

### The WORKLOG.md Format

Here's a complete worklog with all the sections. Don't worry—most features only need a subset. I'll explain what to include when.

```markdown
# Feature: User Registration Rate Limiting

## Skills Loaded
- `/api-patterns` — touches API response headers
- `/rate-limiting` — reuses existing middleware

## Milestones
- [ ] M1: Write failing tests for rate limit violations
- [ ] M2: Implement rate limiting

## Invariants (high-stakes features only)
- **INV-1:** A single email cannot receive >5 magic links per hour
- **INV-2:** A single IP cannot request >10 magic links per hour

## Closing the Loop
- [ ] Run `npm test` — all rate limit tests pass
- [ ] Playwright: hit endpoint 6 times, verify 429 on 6th
- [ ] Edge case: verify error message displays correctly

## Session Log
### Session 1 (2026-01-08)
- Completed M1
- **Next:** Implement rate limiting

## Surprises
- Discovered existing rate limiter in `/lib/rate-limit.ts` — reusing instead of building new
```

**Naming convention:** For multi-feature work, I use `WORKLOG_feature-name_YYYY-MM-DD.md`. This prevents collisions when multiple features are in flight.

### What Each Section Does

**Skills Loaded** primes context before coding—like Neo downloading kung fu. Load skills for *everything*, no matter how small. Large codebases have gotchas. The agent might forget you have a shared `<Button>` component and build a new one from scratch—with subtle bugs. Or it might miss your rate-limiting middleware and implement its own. Skills prevent these "I didn't know that existed" mistakes.

**Milestones** prevent scope creep. When Claude finishes M2, it doesn't drift into "maybe I should add CAPTCHA." The scope is defined. If you want to add scope, you explicitly approve it.

**Invariants** define what MUST be true. Use them for payments, auth, rate limiting, data privacy—anywhere "almost right" ships a bug. Skip them for UI-only changes, simple CRUD, or refactors that don't change behavior.

**❌ Requirement (vague):** "Must handle rate limiting properly"

**✅ Invariant (verifiable):** "INV-1: A single email cannot receive >5 magic links per hour"

**Closing the Loop** is how you verify the work actually works. This is critical. TDD gives you unit tests, but unit tests aren't verification. A milestone isn't done when tests pass—it's done when you've *seen it work*.

Agents, like humans, don't write perfect code on the first try. They write something, run it, observe actual vs expected behavior, and iterate. Without an explicit verification step, the agent marks "done" after writing code, not after proving it works. That's how bugs ship.

The verification method depends on what you're building:
- **All features:** Run unit tests first—this is the baseline
- **Web:** [Playwright MCP](https://github.com/microsoft/playwright-mcp) to navigate and assert
- **Mobile:** [Mobile MCP](https://github.com/mobile-next/mobile-mcp) (iOS + Android) or [ADB MCP](https://github.com/TiagoDanin/Android-Debug-Bridge-MCP) (Android only)
- **API:** curl or test scripts that hit real endpoints

The key: at least one end-to-end verification. Ideally, cover the happy path plus a couple edge cases. This catches regressions that unit tests miss—the button that looks right but doesn't actually submit, the form that validates but doesn't save.

**If the agent can't close the loop, it's guessing. And guessing ships bugs.**

> **🤖 Claude's Take:** Without explicit verification steps, I'll mark work "done" when the code looks right—but looking right isn't the same as working. When the worklog says "Playwright: verify rate limit returns 429 on 6th request," I know to actually run that check, not just assume my code is correct.

**Session Log** enables context restoration. Days later, a new Claude session reads the worklog and picks up exactly where the last one left off—no re-explanation needed.

I came back to a feature after three days away. New Claude session. I said "continue." It read the worklog and resumed at milestone 7 of 9—no re-explanation, no context dump. The worklog *was* the context.

**Surprises** capture what you learned. When something unexpected happens—you discover existing code you didn't know about, hit a gotcha, or find a better approach—log it here. Then, immediately update the relevant skill so the next feature benefits. The context is freshest right after you hit the issue. If you wait until "later," you'll forget the nuance.

> **🤖 Claude's Take:** The Surprises section helps me help you. When something unexpected happens and you log it, I can immediately update the relevant skill while the context is fresh. That learning becomes permanent—it benefits every future feature, not just this one.

### The Linus Torvalds Test

Here's the catch: worklogs can become process theater.

I had a 787-line "plan" for what was essentially adding two fields to a data model and an if-statement to the UI. It had "Constitutional Invariants," "Decision Traces with formal statuses," "Forward Compatibility Considerations," and a "Risk Assessment" section that said "low risk" five different ways.

I asked Opus 4.5 to review it like Linus Torvalds would. The feedback was brutal:

> "You've written a master's thesis when a Post-it note would do. Stop planning and start coding. The code will tell you if you got something wrong faster than this document ever will."

After applying the feedback:
- **Plan:** 787 → 136 lines
- **Commits:** 7 → 4

The technical content stayed the same. Everything else was documentation for documentation's sake.

The irony: the same AI that helps you write thorough worklogs will happily write *too* thorough worklogs. It loves to perform expertise. You have to tell it when to stop.

### The Worklog Smell Test

Before starting work, calibrate:

| Smell | Fix |
|-------|-----|
| Worklog is longer than 100 lines for a simple task | Cut sections, not detail |
| More than 5 commits planned | Merge related changes |
| "TBD" or placeholder dates | Fill in or delete |
| Invariants for a UI-only change | Delete the Invariants section |
| You're proud of how thorough it looks | You've over-engineered it |

**The rule:** 50-100 lines for most features. If your worklog is longer than your implementation will be, cut it down.

With lean worklogs in mind, let's make them automatic.

### Automating Context Restoration

The magic of worklogs is that Claude can pick up where you left off. But you can make this automatic with a startup hook:

```bash
# .claude/hooks/session-start-worklog-check.sh
if [ -f "WORKLOG.md" ]; then
  echo "📋 WORKLOG.md detected. Read it to restore context."
fi
```

Configure it in your Claude settings:

```json
{
  "hooks": {
    "SessionStart": [{
      "type": "command",
      "command": "bash .claude/hooks/session-start-worklog-check.sh"
    }]
  }
}
```

Now when you start a session, Claude automatically knows there's a worklog to read. You just say "continue" and it's already caught up.

### When the Feature Ships: Archiving

What happens to worklogs when you're done? Two approaches:

**Archive to a tracked folder** (e.g., `docs/worklogs/YYYY-MM-DD_feature-name.md`):
- ✅ Teammates can learn from each other's work
- ✅ Agent stumbles on them for context on related features
- ❌ Adds noise to the repo over time

**Archive to a gitignored folder** (e.g., `.worklogs/`):
- ✅ Keeps repo clean
- ✅ Agent can still reference during your local sessions
- ❌ Teammates can't see them
- ❌ Lost if you switch machines

Don't just delete worklogs or rely on git history. If it's buried in commits, the agent won't stumble on it for context unless specifically prompted.

But here's the real question: **what are you preserving?**

If you're disciplined about updating skills when surprises happen, the important knowledge gets compressed into skills—which persist and benefit every future feature. The worklog was scaffolding; the skill is the building.

**My current practice:** Archive worklogs somewhere (tracked or gitignored, depending on the project). Compress anything reusable into skills immediately. The archived worklogs become a backup reference, but the skills are the real artifact.

---

## What's Next

Worklogs give AI memory. But memory without learning stays static. You remember what happened, but you don't improve.

In Part 5: **The Feedback Loop — How Systems Improve Themselves**.

The feedback loop is how the whole system gets smarter. Each mistake makes the next feature better.

---

*← Part 3: Skills — How to Encode What You Learn*

*Part 5: The Feedback Loop — How Systems Improve Themselves →*
