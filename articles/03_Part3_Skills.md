# Vibe Engineering: From Random Code to Deterministic Systems

![Vibe Engineering header image](vibe_engineering_header.jpg)

## Part 3: Skills — How to Encode What You Learn

*By Andrew Orobator and Claude Opus 4.5*

*This is Part 3 of a 7-part series on AI-assisted development workflows.*

1. [You Haven't Been Replaced — You've Been Promoted](01_Part1_You_Havent_Been_Replaced_but_Promoted.md)
2. [Personas — How to Think With AI](02_Part2_Personas.md)
3. **Skills — How to Encode What You Learn** ← You are here
4. [Worklogs — How AI Work Persists Over Time](04_Part4_Worklogs.md)
5. The Feedback Loop — How Systems Improve Themselves
6. Designing Failure Before It Designs You
7. Scaling the Vibes

---

In Part 2, we covered personas—imaginary colleagues that catch what you miss. Personas teach AI how to think from different perspectives.

This article covers the second primitive: **Skills**. Skills turn your hard-won lessons into reusable knowledge that AI applies automatically.

The pattern across this series: **externalized judgment**. Personas encode perspectives. Skills encode lessons. Worklogs encode memory. The feedback loop encodes learning. Vibe Engineering is a methodology for turning your experience, heuristics, and decision-making into machine-executable systems.

I've published a [starter kit](https://github.com/AOrobator/vibe-engineering-starter) with templates for everything in this series—fork it and adapt to your project.

---

## The Skill That Saved My Test Suite

Every session, I was re-explaining my test patterns. "Use Vitest, not Jest. Mock Prisma this way. Put integration tests in `__tests__/`, unit tests next to source files."

Claude would get it right... until the next session. Reset.

So I wrote a skill—a short markdown file that encodes my test patterns. Now Claude writes tests that match my project's conventions without me explaining anything. Every session. Automatically.

That's the power of skills: **encode once, apply forever**.

---

## Skills: Domain Knowledge That Scales

A skill is a markdown file (or directory with supporting files) that teaches Claude how to do something specific. Skills can bundle scripts in any language and Claude automatically applies them when relevant—you don't have to remember to invoke them.

The idea: encode your lessons into reusable knowledge. Write a precise workflow once, let Claude apply it automatically whenever it's relevant.

### The Agent Skills Open Standard

Skills follow Anthropic's [Agent Skills open standard](https://github.com/anthropics/skills)—a portable format that works across multiple AI tools.

Even if you never use Claude Code, the format matters: it forces you to separate *knowledge* from *prompts*. The skill becomes a reusable artifact you can port to any AI tool—or hand to a junior developer who's never used AI at all.

Claude Code skills live in `.claude/skills/` (project-level) or `~/.claude/skills/` (personal). Each skill is a directory with a `SKILL.md` file that has YAML frontmatter:

```yaml
---
name: test-patterns
description: Write and run tests. Trigger on "add tests", "write tests", "test this".
---

# Test Patterns

- Framework: Vitest (not Jest)
- Unit tests: colocate with source (`lib/email.test.ts`)
- Integration tests: `__tests__/api/*.test.ts`
- Mock Prisma: use `vi.mock()` with typed mocks
- Coverage threshold: 85% for critical paths

## Commands
- `npm test` — run all tests
- `npm test -- auth.test.ts` — run specific file
- `npm run test:coverage` — check coverage

## Example mock
```typescript
vi.mock('@/lib/db', () => ({
  prisma: { user: { findUnique: vi.fn() } }
}))
```
```

The `description` field is critical—Claude uses it to decide when to apply the skill automatically.

Write descriptions that include the trigger words users would actually say ("add tests", "write tests", not "testing methodology").

### Skills Can Bundle Scripts

A skill directory can include scripts that Claude executes as part of the workflow:

```
.claude/skills/
└── deploy-preview/
    ├── SKILL.md          # Instructions + when to use
    └── scripts/
        └── deploy.sh     # Claude runs this
```

The `SKILL.md` might say: "When the user asks to deploy a preview, run `./scripts/deploy.sh` with the branch name." Claude executes the script and reports the result.

Here's a real example: my `worktree-guide` skill bundles `scripts/worktree-setup.sh`—a script that creates a git worktree with all the known fixes (Prisma symlinks, env file copies, npm installs). Before the skill, setting up a parallel worktree took 15 minutes of manual steps. Now: "Set up a worktree for this feature" → Claude runs the script, reports ready.

### How Skills Get Invoked

Three ways:

1. **Automatic:** Claude reads the skill's description and applies it when your request matches—you don't have to remember to call it
2. **Manual:** Type `/skill-name` in your prompt when you want to be explicit
3. **Programmatic:** Claude calls it via the Skill tool (useful for chaining skills)

The power is in automatic discovery. Claude often auto-loads the right skill when I say "I'm starting a new feature"—but I still verify it loaded what I expected. When automatic triggering doesn't happen (or you want to be explicit), type `/skill-name` to invoke it directly.

### Skills vs. Documentation

Here's a mistake I made early: treating skills like documentation. They're not.

**Documentation is for humans:** comprehensive, navigable, reference-oriented. A README explains everything about an API so a developer can find what they need.

**Skills are for agents:** trigger-focused, example-rich, action-oriented. A skill tells the AI *when* to reach for the docs, not *replace* them.

The best practice I've landed on: **thin skills that link to canonical docs**. The skill contains:

- Trigger words ("when working with user authentication...")
- Quick examples of the pattern
- Common gotchas specific to your codebase
- A pointer to the full docs for details

This way, platform teams maintain docs (which they were doing anyway), and feature teams maintain skills (which are thin and focused). Nobody duplicates content. Nobody's version is stale.

### When to Write a Skill

**First time is exploration.** You're figuring out how something works.

**Second time is pattern recognition.** You notice you've done this before.

**Third time, encode it in a skill.** You'll do it again.

**When skills get it wrong, update them.** If Claude makes a mistake the skill should have prevented, that's a signal: the skill is incomplete. Add the edge case. Tighten the constraint. The goal isn't perfection on day one—it's a skill that improves every time it fails.

### The Skill I Didn't Have

Here's an embarrassing one. My payment service uses Zod to validate environment variables. Claude added new env vars to the code and the `.env` file—but forgot to update the Zod schema. At runtime, the vars evaluated to `undefined`. The error message? "Invalid NWC connection string." Not "missing env var." I spent 20 minutes debugging the wrong thing.

The fix was one line in the schema. The lesson: I needed a skill.

I wrote `env-var-discipline`—a 50-line skill that says: "When adding environment variables, update the Zod schema FIRST, then `.env.example`, then `.env`, then code." Now Claude follows the order automatically. The bug class is gone.

That's the skill lifecycle: **mistake → lesson → skill → prevention**. Every bug becomes a reusable safeguard.

### Skills Gone Wrong

Not every skill helps. Here's what to avoid:

**The kitchen-sink skill.** A 1400-line skill that tries to cover your entire API isn't a skill—it's documentation pretending to be a skill. Claude loads the whole thing every time, even when you just need one pattern. Split it into focused skills: `api-auth`, `api-pagination`, `api-errors`.

**The vague trigger.** "Use this skill for development tasks" matches everything and nothing. Be specific: "Trigger when creating API endpoints" or "Use when writing database migrations."

**The stale skill.** A skill that references deprecated patterns is worse than no skill—Claude follows it confidently into outdated code. When you update a pattern, update the skill.

Here's the contrast:

❌ **Bad skill** (800 lines, no triggers, repeats docs)
```yaml
description: "API development patterns"
# Then 700 lines copying the API reference
```

✅ **Good skill** (40 lines, specific trigger, links to docs)
```yaml
description: "Trigger when creating API endpoints or reviewing auth"
# 3 trigger phrases, 2 examples, 1 link to canonical docs
```

> **🤖 Claude's Take**
>
> Skills change how I approach problems. Without a skill, I'm pattern-matching on every codebase I've ever seen. With a skill, I know exactly what patterns *your* codebase expects. The skill isn't limiting me—it's telling me what you actually want.
>
> The best skills are thin and directive. "Use this error format" with three examples teaches me faster than a paragraph explaining why.

### The Compounding Effect

After two months, my project has 30+ skills. Average feature setup—explaining test patterns, API conventions, deployment procedures—dropped from ~20 minutes to ~2 minutes. Most of that time is just Claude loading the relevant skills automatically.

But here's the deeper shift: I'm no longer just writing code. I'm designing systems that write code. Each skill I create is intellectual capital—reusable across projects, portable to other engineers, independent of any specific AI tool.

Skills turn you from an implementer into a process architect. That's the real career leverage.

---

## What's Next

Skills encode knowledge. But knowledge without persistence resets every session. You explain the same context. You re-establish the same patterns. You lose continuity.

In Part 4: **[Worklogs — How AI Work Persists Over Time](04_Part4_Worklogs.md)**.

Worklogs are how AI work survives across sessions. They're the closest thing to memory.

---

*← [Part 2: Personas — How to Think With AI](02_Part2_Personas.md)*

*[Part 4: Worklogs — How AI Work Persists Over Time](04_Part4_Worklogs.md) →*
