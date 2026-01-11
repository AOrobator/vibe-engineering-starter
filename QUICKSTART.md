# First 15 Minutes

Get a tiny win before diving into the theory. This quickstart ends with you running your first agent review.

## Step 1: Copy the Files (2 minutes)

Copy these files to your project root:

```bash
# From this repo to your project
cp AGENTS.md /path/to/your/project/
cp WORKLOG.md /path/to/your/project/
mkdir -p /path/to/your/project/.claude/skills/feature-dev
cp .claude/skills/feature-dev/SKILL.md /path/to/your/project/.claude/skills/feature-dev/
```

Or just fork this repo and start modifying.

## Step 2: Create a Worklog Entry (3 minutes)

Open `WORKLOG.md` and fill in the template for whatever you're currently working on:

```markdown
### M1: [Your current task]

**Tests (RED):**
- [ ] Test that [expected behavior]

**Implementation (GREEN):**
- [ ] [First step]
- [ ] [Second step]

**Commit:** `feat: [description]`
```

Don't overthink it. Pick something small—a bug fix, a minor feature, anything.

## Step 3: Run Your First Agent Review (5 minutes)

Before you commit your next change, ask:

```
@Security-Agent, review this change.
```

The AI will shift into the Security-Agent persona from `AGENTS.md` and evaluate your code through that lens.

Try it with different agents:
- `@UX-Agent, review this error handling`
- `@Machiavelli-Agent, how would you break this?`
- `@Test-Agent, what tests am I missing?`

## Step 4: Write a Decision Trace (5 minutes)

After you make a non-obvious decision, document it:

```markdown
## Decision Trace: [Title]

**Date:** [Today]
**Context:** [What problem were you solving?]
**Options Considered:**
1. [Option A] — [Why rejected or chosen]
2. [Option B] — [Why rejected or chosen]

**Decision:** [What you chose]
**Rationale:** [Why this was the right call]
```

Put this in your worklog or a dedicated `decisions/` folder.

---

## You're Done

In 15 minutes you've:
- ✅ Set up session memory (worklog)
- ✅ Run an agent review (imaginary colleagues)
- ✅ Written a decision trace (institutional reasoning)

These three artifacts survive context loss. When you start a new AI session tomorrow, it can read these files and pick up where you left off.

Now go read the full article series to understand *why* this works:
1. [Part 1: You Haven't Been Replaced — You've Been Promoted](link)
2. [Part 2: Agents, Skills, Worklogs, and the Feedback Loop](link)
3. [Part 3: Designing Failure Before It Designs You](link)
4. [Part 4: Scaling the Vibes](link)
