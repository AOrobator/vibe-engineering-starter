# Vibe Engineering: From Random Code to Deterministic Systems

![Vibe Engineering header image](vibe_engineering_header.jpg)

## Part 2: Personas — How to Think With AI

*By Andrew Orobator and Claude Opus 4.5*

*This is Part 2 of a 7-part series on AI-assisted development workflows.*

1. [You Haven't Been Replaced — You've Been Promoted](01_Part1_You_Havent_Been_Replaced_but_Promoted.md)
2. **Personas — How to Think With AI** ← You are here
3. [Skills — How to Encode What You Learn](03_Part3_Skills.md)
4. [Worklogs — How AI Work Persists Over Time](04_Part4_Worklogs.md)
5. The Feedback Loop — How Systems Improve Themselves
6. Designing Failure Before It Designs You
7. Scaling the Vibes

---

In Part 1, we established the mental model: you're the senior eng, the AI is your brilliant intern. Your job is to define constraints. Their job is to execute within them.

Mental models alone don't ship software. You need tools.

Here's the insight that changed my workflow: **Solo developers can have code review. You just invent the reviewers.**

This is the first primitive in a larger pattern: **externalized judgment**. A persona encodes a perspective—the way a security engineer thinks, the questions a UX advocate asks—into a reusable artifact. You're not just prompting; you're programming how the AI evaluates your work.

I've published a [starter kit](https://github.com/AOrobator/vibe-engineering-starter) with templates for everything in this series—fork it and adapt to your project.

---

## Personas: Your Imaginary Colleagues

When I started building solo, I had tunnel vision. Without teammates to challenge my assumptions, I kept missing things. Security holes. UX friction. Edge cases.

Then I read an Andrej Karpathy tweet about how there's no "you" when addressing an LLM—ask for different perspectives instead. That changed everything.

https://x.com/karpathy/status/1997731268969304070

I created a `PERSONAS.md` file:

> **📝 Naming Note:** I originally called my file `AGENTS.md`, but I recommend `PERSONAS.md` instead. "Agents" now means something specific in AI—autonomous systems, subprocesses, agentic coding. These are different: they're perspectives you invoke, not autonomous actors. The `@Security-Agent` naming convention still works great for invocation; the file just lives in `PERSONAS.md`.

```markdown
## @Security-Agent
You are a paranoid security engineer. Your job is to find vulnerabilities.
- Assume all user input is malicious
- Check for OWASP Top 10 violations
- Flag any secrets, tokens, or credentials that could leak
- Question every authentication and authorization decision

## @UX-Agent
You are a user experience advocate. Your job is to protect the user.
- What happens when things go wrong? Does the user know what to do?
- Is the error message actionable or cryptic?
- Are we making the user think when we could think for them?

## @Machiavelli-Agent
You are an adversarial thinker. Your job is to break things.
- How would a malicious actor exploit this?
- What happens if someone calls this API 10,000 times?
- Where are the race conditions?
```

When I'm working on a feature, I ask: "@Security-Agent, review this authentication flow." The AI shifts into that persona and evaluates through that lens.

The magic is the *perspective shift*. Without @Security-Agent, I ask "does this work?" With @Security-Agent, I ask "how could this be exploited?"

### Full Persona Reviews

For significant features, I run a "full persona review" where every relevant persona weighs in. Each provides a verdict: APPROVE, COMMENT, or VETO. A single VETO blocks the feature.

This sounds theatrical. It works. @Security-Agent caught a session token leak I would have shipped. @UX-Agent flagged an error message that said "Error: null" instead of something helpful. @Machiavelli-Agent found a race condition in my payment flow.

But here's a failure that taught me personas aren't infallible:

### The Race Condition Claude Missed

I'd built an organizer attendee list—lets event organizers see who's coming, with emails and RSVP status. About 400 lines of new code. Claude ran the full persona review: Security, UX, Test, all nine personas. Every single one approved.

Then I asked Codex for a second opinion.

Codex found it in 30 seconds: "Stale data on client-side navigation: `useEffect` doesn't reset state when `eventId` changes." The component would show attendees from the *previous* event while new data loaded. Users could see names and emails they shouldn't.

Claude had implemented the feature, reviewed the feature, and missed it. A fresh set of eyes—different model, different approach—caught what reviewing your own work can't.

**The fix:** Added state reset at `useEffect` start, implemented `AbortController` for request cancellation, updated tests. All 1333 tests passed. But it almost shipped with a data leak.

**The lesson:** Personas are powerful, but they can normalize what they've been staring at. The same AI that writes code can review it, but it may have the same blind spots in both modes. For high-risk features (PII, payments, auth), enforce model diversity: one AI implements, a different AI reviews. Humans stay in the loop for anything with irreversible consequences.

Solo developers can have code review. You just invent the reviewers.

> **🤖 Claude's Take**
>
> Personas genuinely change how I process code. When you ask me to "review this," I apply general best practices. When you invoke @Security-Agent, I'm actively hunting for vulnerabilities. The persona gives me a *goal*, and goals focus attention.
>
> The multi-persona review catches issues any single perspective would miss. @UX-Agent doesn't care about SQL injection; @Security-Agent doesn't care about button placement. Running all of them is the point.

---

## What's Next

Personas teach AI how to think from different perspectives. But thinking without memory resets every session.

In Part 3: **[Skills — How to Encode What You Learn](03_Part3_Skills.md)**.

Skills turn hard-won lessons into reusable knowledge that AI applies automatically. No more re-explaining the same patterns every conversation.

---

*← [Part 1: You Haven't Been Replaced — You've Been Promoted](01_Part1_You_Havent_Been_Replaced_but_Promoted.md)*

*[Part 3: Skills — How to Encode What You Learn](03_Part3_Skills.md) →*
