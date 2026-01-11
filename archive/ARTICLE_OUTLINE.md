# AI Workflows for full stack development and how they can translate to Android. aka Vibe Engineering

Over the winter holidays I took a deep dive into claude code and agentic programming. I haven't been writing unit tests by hand for months at work, but I wanted to see how far I could push things without corporate constraints. I spun up a side project that I'm hoping to launch soon, but what I can share now is some of the AI workflow patterns I have discovered and am hoping to use at scale at reddit. What works, what doesn't. What blows my mind and what still irks me. Where I feel with my current skillset and where i still feel behind. you should walk away from this article knowing that if the majority of your code isn't AI generated or assisted going forward, you are at a serious career risk of stagnation and falling behind. 

when i first started out with my side project i was inspired by the following andrej karpathy tweet about how there is no "you" when addressing an LLM and it's better to ask for different perspectives. 

LINK TO TWEET

in my agents.md i have several perspectives and i used them for feedback as a solo builder. in my chats with claude code, i would tag @product-agent or @ux-agent and many times @security-agent to offer me different perspectives on the code that i was generating. i would have regular "full agent reviews" where each agent offered its perspective on the code that i had just written. pretty solid.

then i heard about skills. i think of skills at reusable prompts that are well thought out in order to have a higher likelihood of the LLM understanding what you want it to do. cursor calls these commands, but the basic idea is the same. explain what they are and how they work/how they are formatted.

- feature-dev skill
- feature-worklog skill
- skill creation skill

spec driven development - hardest thing in software is usually specifying what needs to be built. for my project, i have a markdown spec detailing happy and sad paths, and have my agents review it (@machiavelli-agent is especially good for adversarial reviews)

the worklog skill is the backbone of the workflow. always make a plan with TDD and atomic commits so you have checkpoints and auditability into the agent's work. make a template for a worklog or plan so that common concerns are always addressed. for example, in the plan template i have stuff on a11y, security, what machiavelli would think of my plan from a security and product pov, product invariants from the spec that needed to hold and be tested for, and other things.

another massive unlock is having a feedback loop with your AI. when it's implementing stuff and as you're correcting it through features, have it write down what surprised it. after each feature do a @skill/post-mortem where you talk about all the things that went right and wrong. then avoid the mistakes in the future by updating the appropriate skills and agents. i got pretty far just by myself with this and i'm excited to see what it looks like when there's an entire team contributing skills and agent improvements.

something really cool with ai is that it's a random system, but it's interacting with an extremely deterministic system. either the code compiles, the tests pass, lint passes, ... or it doesn't. web dev and full stack was easy, especially with the playwright mcp and claude code chrome extension that allowed claude to easily verify its own work. we don't have something like that for android just yet, but claude and other agents need to learn how to use adb. this can probably be done in a reusable skill and maybe a tool like `scrcpy` to interact with the screen. the agent randomly spins against the gate until it's correct and gets let in.

you as an engineer still need to think though, you can't fully give into the vibes. think of it like you're a senior eng mentoring a super smart fresh college grad. the LLMs are amazing coders, but they don't have real world experience and often cut corners. one time i was telling claude to write something and it told me it took a shortcut because there was a deadline coming up. in my personal project! the way it's connected and disconnected from reality is amusing sometimes. 

the model needs context. all my backlog, product spec, documentation for various services is all documented in markdown so the agent can access this. if we want to keep the same corporate workflows, this would probably look like an giving an agent access to jira and confluence docs via an mcp or even via scripts on the rest api.

## Favorite Workflows I Miss When They're Not There

- **Constitutional Invariants in Worklogs** - When planning complex features, I write down "invariants" that must always hold (e.g., "Lightning payment is source of truth, database is just a cache"). These become guardrails for implementation AND test cases. When you violate one, you immediately know something's wrong architecturally.

- **Multi-Agent Perspectives on Failure Modes** - The WORKLOG pattern of having @BTC-Agent, @Systems-Agent, and @UX-Agent each analyze the same bug from their domain. BTC-Agent sees the Lightning network constraints. Systems-Agent sees connection pool exhaustion. UX-Agent sees the user staring at a spinner. Same problem, three lenses, better solution.

- **Decision Trace Documents** - Every architectural decision gets a trace ID (e.g., `DT-20260108-001`) that links the decision to the code, tests, and backlog items affected. When future-me asks "why is this designed this way?", the trace tells the story.

- **Machiavelli Adversarial Reviews** - Before any payment flow ships, @Machiavelli-Agent asks "how would an attacker exploit this?" The security review in the WORKLOG caught a stale status exploitation attack before it was possible. Thinking like an adversary is a skill the AI can simulate really well.

- **Milestone-Based Worklogs with Explicit Deferral** - Breaking work into M1, M2, M3... with clear scope, and then explicitly marking some milestones as "DEFERRED" with rationale. This prevents gold-plating. M1-M2 shipped, M3-M6 got deferred because they were edge case hardening for a pre-launch MVP. Knowing when to stop is as important as knowing what to build.

- **"Open Questions (Resolved)" Section** - Keeping a running log of design questions with the final decision and reasoning. "Should NWC verification happen on every poll?" with pros, cons, and final call. These become documentation AND onboarding material.

- **Recovery Strategy as First-Class Design** - The WORKLOG has an entire section on "what happens when things go wrong and how do we recover?" with cron job specs, max delays, and guarantees. Not an afterthought - part of the design.

- **Test Coverage Tracking Table** - A before/after coverage table for each file touched. Keeps the testing discipline visible and accountable.

---

## Self-Interview: What I Like and Don't Like About the Sparkpass Process

### What do you genuinely love about this workflow?

**The documentation becomes the product.** PRODUCT_SPEC.md isn't a dusty doc that drifts from reality - it's a living contract that gets updated in the same PR as code changes. When I need to make a decision, I read the spec. When the spec is wrong, I fix it. The AI and I both trust the same source of truth.

**The agent framework forces multi-perspective thinking.** As a solo builder, it's easy to get tunnel vision. Having @Security-Agent, @UX-Agent, @BTC-Agent, etc. as "imaginary colleagues" means I'm constantly asking "what would someone who only cares about X think of this?" It's like having a team review without having a team.

**Constitutional invariants are my favorite pattern.** Writing down "INV-1: Lightning Payment is Source of Truth" and then deriving tests from it is incredibly powerful. It's design-by-contract meets TDD. When I was debugging the database resilience issue, the invariants told me exactly what behavior was required, even in degraded states.

**The skill system scales knowledge.** Once I wrote the `/feature-dev` skill, every feature I build follows the same quality bar. Skills are like runbooks but for AI. They encode hard-won lessons so I don't keep learning them the hard way.

### What frustrates you or feels clunky?

**Context window anxiety is real.** Even with WORKLOG.md for session restoration, I sometimes feel like I'm re-explaining things the AI should already know. Long conversations get summarized and nuance gets lost. I end up front-loading important context in every message "just in case."

**The overhead feels heavy for small changes.** If I'm fixing a typo or adding a log statement, I don't need a full agent review and WORKLOG entry. But the same process that's perfect for "implement database resilience" is overkill for "change this error message." I don't have a great lightweight mode yet.

**Agent personas can be theatrical.** Sometimes I ask for @Security-Agent's perspective and get a three-paragraph monologue when I just need "yeah this is fine" or "no, you're exposing the session token." The AI loves to perform expertise even when concise acknowledgment would be better.

**Remembering what's in which doc is overhead.** Is the rate limit spec in PRODUCT_SPEC.md or AGENTS.md? Was that edge case documented in the WORKLOG or the skill? I've created a lot of documentation surface area and sometimes I'm searching my own docs to find things.

**TDD with AI is a mixed bag.** The AI writes great tests when it knows what behavior it's testing. But sometimes it writes tests that pass by coincidence or test implementation details instead of behavior. I still need to review tests carefully, which sometimes takes as long as writing them myself.

### What surprised you most?

**How well the AI handles complex distributed systems reasoning.** The database resilience WORKLOG involved understanding Lightning payment settlement, NWC protocol, Prisma connection pooling, and user experience during degradation - all at once. The AI not only kept up but identified failure modes I hadn't considered (like the race condition attack where Lightning prevents double-pay at the network layer).

**How the workflow exposed my own blind spots.** I never would have written a section on "Recovery Strategy" unprompted. But the WORKLOG template forced me to think about it, and now I can't imagine shipping a payment flow without one. The structure is smarter than I am.

**How documentation became less painful.** I used to hate writing docs because they immediately became stale. With the AI updating PRODUCT_SPEC.md in the same PR as code, the docs stay accurate. Writing docs is now "tell the AI what changed" instead of "go update that markdown file you forgot about."

### What would you change if you could start over?

**Start with the agent framework and skills from day one.** I added them incrementally, which means some early code doesn't follow the patterns. If I'd started with a skeleton AGENTS.md and a few core skills, everything would be more consistent.

**Be more ruthless about scope.** The "NOT in MVP" section of PRODUCT_SPEC.md saved me multiple times from overbuilding. But I still caught myself gold-plating occasionally. Having @Founder-Agent with explicit veto power over scope would have helped earlier.

**Build the lightweight mode.** Some changes genuinely don't need the full ceremony. I'd create a `/quick-fix` skill for small changes that skips the WORKLOG and agent reviews. Not everything needs a constitutional invariant.

### What's your honest assessment of productivity gain?

**2-3x on complex features, maybe 1.5x overall.** The big wins are on gnarly problems like database resilience where the AI can hold multiple concerns in its head and reason across them. The overhead eats into gains on small stuff. If you're only doing small stuff, the workflow might feel like bureaucracy. If you're doing real architecture work, it's a force multiplier.

**The quality gain is harder to measure but real.** I ship with more confidence. Edge cases get documented. Security concerns get raised before they're exploited. The codebase is more consistent. These things don't show up in "lines of code per day" metrics but they matter.

### What advice would you give someone adopting this workflow?

1. **Start with PRODUCT_SPEC.md.** If you don't have a clear spec, the AI will hallucinate requirements. Garbage in, garbage out.

2. **Create agents for the perspectives you're missing.** Solo? Add @UX-Agent and @Security-Agent. Frontend-heavy team? Add @Backend-Agent. The agents are mirrors for your blind spots.

3. **Write skills for things you do more than twice.** The first time is exploration. The second time is pattern recognition. The third time, encode it in a skill.

4. **Use worklogs for anything that takes more than an hour.** They're your paper trail, your rubber duck, and your onboarding docs all in one.

5. **Trust the process, but verify the output.** The AI is a brilliant junior engineer. It needs code review, not rubber stamps.

### Did writing system specs (like INVOICE_SVC_SPEC.md) before implementation help?

**Absolutely. It's the same insight as product specs, but for systems.**

Writing the invoice-svc spec forced me to think about system design before touching code. How do the pieces fit together? What are the API contracts? What happens when the database goes down? What security controls need to exist at each boundary?

The spec for invoice-svc is almost 800 lines. It covers:
- Architecture diagrams (ASCII art, no dependencies)
- API contracts (every endpoint, every request/response shape)
- Security controls (who can call what, how we validate)
- Flow diagrams (two-invoice payment flow step by step)
- Error handling (what happens when things fail)
- Deployment (how it runs, what env vars it needs)

The fun part of engineering was always the system design. The coding was just necessary. With AI, I get to spend more time on the fun part—the design—and delegate the tedious parts.

**Key insight:** The spec becomes a conversation artifact. When Claude is implementing a feature, I can say "check INVOICE_SVC_SPEC.md section on error handling" and it has everything it needs. No re-explaining. The spec is the context.

### Did CI.md help plan what checks to write?

**Yes—and it prevented us from over-engineering CI.**

Before writing any CI code, I wrote CI.md. What jobs do we need? What should block merge? What failure modes are we catching?

The spec is 390 lines and covers:
- Every CI job (lint, typecheck, prisma validation, tests, env var audit)
- Why each job exists (linked to post-mortems and decision traces)
- What failure modes each job catches
- Troubleshooting guides for when each job fails

Writing this upfront made the actual implementation trivial. The spec says "Prisma Validation job catches P3006 migration ordering errors"—that's the requirement. Claude implements the job to match.

**What we avoided:** We didn't build fancy deployment pipelines or preview environments. CI.md has a "Future Improvements (V1+)" section that explicitly defers e2e tests, deploy previews, security scanning to post-launch. The spec gives us permission to stop.

### What system docs felt like busywork vs. valuable?

**Valuable:**
- INVOICE_SVC_SPEC.md — Referenced constantly. Every time I forget how the two-invoice flow works, I read the spec.
- CI.md — Troubleshooting section saved me hours. "Prisma migrate reset failed (P3006)" has step-by-step fix.
- INFRA.md — Quick reference for "what connects to what" and environment variables.

**Borderline:**
- DATABASE_SECURITY.md — Valuable for the initial setup, but I rarely reference it now. Might be better as a one-time runbook than a living doc.

**The pattern:** Docs you reference repeatedly are worth maintaining. Docs you wrote once and never read again might be better as decision traces (DT-YYYYMMDD-NNN) that capture the reasoning without the maintenance burden.

------------------

# ARTICLE OUTLINE (Draft Structure)

## 1. The Hook (existing intro, tighten up)
- Personal context: side project deep dive over holidays
- The thesis: AI-assisted coding is the new baseline
- Karpathy tweet as inspiration

## 2. The Mental Model: You're a Senior Eng, AI is Your Smart Intern
- LLMs are amazing coders but lack real-world judgment
- The "deadline in my personal project" anecdote
- Your job: architecture, scope, review. Their job: implementation, exploration, drafting.

> **[CLAUDE'S TAKE]** What it feels like from the AI side - the disconnect between pattern-matching and understanding intent

## 3. The Foundation: Spec-Driven Development
- PRODUCT_SPEC.md as the single source of truth
- Why specs matter more with AI (garbage in, garbage out)
- Happy paths AND sad paths documented upfront
- @Machiavelli-Agent for adversarial review of specs

> **[CLAUDE'S TAKE]** Why clear specs make my job dramatically easier

### 3b. System Specs: Not Just Product, but Architecture
- **Spec-first applies to systems too.** INVOICE_SVC_SPEC.md (797 lines) defined architecture before implementation
- System spec contents: API contracts, security controls, flow diagrams, error handling, deployment
- CI.md (390 lines) planned what CI jobs should exist and why—before writing any YAML
- **The fun part was always system design.** AI lets you spend more time on design, less on typing
- System specs become conversation artifacts: "check section X" instead of re-explaining
- **What to include vs. defer:** "Future Improvements (V1+)" sections give permission to stop
- Pattern: Docs you reference repeatedly = worth maintaining. One-time docs = maybe decision traces instead

## 4. The Toolkit: Agents, Skills, and Worklogs

### 4a. Agent Personas (Imaginary Colleagues)
- The Karpathy insight: no "you", ask for perspectives
- @Product-Agent, @UX-Agent, @Security-Agent, @BTC-Agent
- Full agent reviews as solo code review substitute
- How to create agents for YOUR blind spots

> **[CLAUDE'S TAKE]** How agent personas shape my reasoning vs. just answering questions

### 4b. Skills (Reusable Prompts)
- Skills = well-structured prompts with high success rate
- /feature-dev, /feature-worklog, /post-mortem
- How to format them (cursor calls these "commands")
- The skill creation skill (meta!)

### 4c. Worklogs (The Backbone)
- Plan with TDD and atomic commits
- Template for common concerns: a11y, security, invariants
- Milestone-based structure with explicit deferral
- Why "knowing when to stop" is part of the plan

## 5. The Feedback Loop: Learning From Every Feature
- Post-mortems after each feature
- "What surprised the AI" as a section
- Updating skills and agents based on lessons learned
- Vision: team-wide skill libraries

> **[CLAUDE'S TAKE]** The value of being corrected (and remembering the correction)

## 6. DEEP DIVE: Database Resilience WORKLOG (Full Example)
*Walk through one complete workflow end-to-end*

### The Problem
- Demo failure: DB went down, payment UX broke
- The gap between "payment succeeded" and "we can tell the user"

### Multi-Agent Analysis (side by side)
| Agent | Perspective |
|-------|-------------|
| @BTC-Agent | Lightning is source of truth, payment already settled |
| @Systems-Agent | Connection pool exhausted, retry storm |
| @UX-Agent | User staring at spinner, no guidance |

### Constitutional Invariants Defined
- INV-1: Lightning is source of truth
- INV-2: Verify via NWC before displaying any invoice
- INV-3: Audit failures are non-blocking
- INV-4: Users get actionable guidance
- INV-5: Graceful degradation over total failure

### Implementation Options Evaluated
- Option A: Error handling + UX
- Option B: NWC-first + client state
- Option C: Event-driven architecture (deferred)

### What Shipped vs. What Got Deferred
- M1-M2 shipped, M3-M6 deferred with rationale
- "Overengineering for pre-launch MVP" as a valid reason to stop

> **[CLAUDE'S TAKE]** What I learned from this specific workflow

## 7. Deterministic Gates: Why This Works
- AI is random, but compilers/tests/linters are not
- "Spin against the gate until correct"
- Web: Playwright MCP, Chrome extension for visual verification
- Mobile: The gap (adb, scrcpy, future skills)

## 8. Parallelism: The Promise and Reality

### Two Types of Parallelism

**Critical Distinction:** There are two completely different types of "parallel AI work":

1. **Subagents within one Claude session** — Claude Code's Task tool can spawn subagents that run concurrently. These share a context budget and run inside a single session.

2. **Multiple independent Claude sessions** — Separate Claude instances (different terminals, Claude Max tabs, mobile Claude Code) that don't share context at all.

Twitter power users running "12 individual Claudes plus mobile" are doing Type 2. The context limitations I describe below are primarily about Type 1.

### What I Tried: Parallel Domain Analysis (Type 1 - Subagents)
*From the Backlog/Spec Gap Analysis WORKLOG*

**The Plan:**
- 7 independent domains (Auth, Events, Payments, Wallets, Dashboard, Attendee, Admin)
- Each could theoretically run in parallel subagents
- Two-phase approach: Analysis (parallel) → Aggregation (sequential)

**What Actually Happened:**
> "Originally planned for parallel execution, but context/prompt limits make serial execution more practical. Each domain analysis requires substantial context (reading PRODUCT_SPEC.md sections + multiple code files), making parallel subagent launches exceed token limits."

**The Lesson (Type 1):** Subagent parallelism is bounded by shared context. Each subagent needs enough context to do its job, and that context adds up fast within a single session. 7 parallel subagents each needing 50K tokens > your session budget.

**Type 2 is different:** Multiple independent Claude sessions don't share context budget—they share *nothing*. The limitation there is coordination overhead, not context.

### The Context Window Problem

Every Claude session has a context window—a limit on how much text it can "remember" at once. Think of it as working memory. When you're in a long session, the context fills up with:
- Your conversation history
- Files you've read
- Code you've generated
- Instructions from skills and agents

**What happens when context fills up:**
- **Compaction:** Claude Code automatically summarizes older parts of the conversation to make room. This lets you keep working, but summaries are lossy by definition—details get dropped.
- **Context loss:** The AI might forget decisions you made earlier, edge cases you discussed, or patterns you established. You end up re-explaining things.
- **Degraded reasoning:** With less context available, the AI has fewer details to reason about. Complex multi-step work suffers.

**This matters for parallelism because:**
- **Type 1 (Subagents):** All subagents share the parent session's context. Launch 7 subagents and they all compete for the same limited memory. The parent session may get compacted mid-analysis.
- **Type 2 (Independent Sessions):** Each session has its own full context budget. But they can't communicate—each Claude doesn't know what the others are doing.

### The NEXT_AGENT_PROMPT System (Serial Multi-Agent with Managed Context)

**The Problem:** We wanted multiple specialized "agents" analyzing different domains (Auth, Payments, Wallets, etc.). Parallel subagents hit context limits. Independent sessions couldn't coordinate. Compaction would lose critical details.

**The Solution:** Serial execution with a handoff protocol. Each Claude session:
1. Reads the `NEXT_AGENT_PROMPT.md` file (explicit context, not lossy summary)
2. Does its specialized analysis (Auth domain, Payments domain, etc.)
3. Updates `NEXT_AGENT_PROMPT.md` with context for the next session
4. Creates a decision trace documenting what it learned

**Why this beats compaction:** The handoff file is *explicit* context you control. You decide what's important enough to pass forward. Compaction is automatic and lossy—the AI decides what to keep. NEXT_AGENT_PROMPT lets you preserve exactly the details that matter.

**Why decision traces enable learning:** Each agent creates a decision trace documenting what worked, what didn't, and what patterns they discovered. Subsequent agents read prior traces before starting their analysis. By the 7th agent, patterns had cascaded forward through 6 prior post-mortems—each session learned from the ones before it.

**What NEXT_AGENT_PROMPT.md Contains:**
- Clear mission (what this agent should do)
- Files to read first (verified to exist)
- Key questions to answer
- Output format and location
- Context from prior agents (patterns discovered, cross-references)
- Copy-paste prompt section for easy session startup

**Why the Claudes Liked It:**
- From DT-20251229-007 (Dashboard Agent): "Clear mission steps, standardized output format, context survival across sessions"
- From DT-20251229-010 (Aggregation Agent): "All 7 domain agents followed the same findings template, making aggregation trivial"
- From the WORKLOG: "NEXT_AGENT_PROMPT pattern enables context survival across sessions" (noted by 7/9 agents)

**Results:**
- 7 domain analyses completed serially over ~6 sessions
- Each session started fresh with full context budget
- 23 total gaps identified, 70% already in backlog
- 27 patterns codified into skills from the post-mortems

**Key Insight:** Serial execution with explicit handoffs beats both parallel subagents (context-limited) and compaction (lossy). It's slower but nothing important gets lost. The handoff protocol (NEXT_AGENT_PROMPT.md) is the key.

**This is different from Type 2 (worktrees):** Worktrees are for independent parallel work on different branches. NEXT_AGENT_PROMPT is for sequential coordinated work where each session builds on the last.

### Git Worktrees: Parallel Feature Development (Type 2 - Independent Sessions)
*From DT-20251227-001: Git Worktree Feature Development Postmortem*

**The Vision:** Two independent Claude sessions working on different features in parallel using git worktrees. Each Claude has its own terminal, its own context, its own worktree.

**The Reality (Time Breakdown):**
| Phase | Expected | Actual | Why |
|-------|----------|--------|-----|
| Worktree setup | 1 min | 2 min | Branch creation gotcha |
| Code change | 1 min | 1 min | ✓ |
| Browser testing setup | 2 min | **15 min** | Env files, cache, ports, auth |
| Total | ~5 min | **~25 min** | 5x overhead |

**Root Causes:**
1. Worktrees don't copy untracked files (`.env`, `.env.local`)
2. Next.js caches aggressively - stale config persists until `.next` is cleared
3. Dev server port conflicts need manual cleanup
4. Session cookies don't work across different ports

**Key Learning:** The first parallel session takes way longer than expected. You need a `worktree-setup.sh` script that handles all the gotchas, or you'll waste 15+ minutes every time.

> **[CLAUDE'S TAKE]** My perspective on why parallel work is harder than it looks

### Multi-AI Pairing: Claude + Codex
*From DT-20251227-002: Claude + Codex Pairing Postmortem*

**The Experiment:** Claude implements, Codex reviews. Both using the same agent review protocol.

**What Worked:**
- Codex caught a React race condition Claude missed (stale state on navigation)
- Structured protocol gave both AIs a shared language
- Complementary strengths: Claude for implementation, Codex for static analysis

**What Still Needed Work:**
- Even with Claude + Codex reviewing, Greptile and CodeRabbit still found additional issues
- Multiple layers of AI review caught different things—no single AI catches everything
- Setup overhead (same worktree issues)

**Why context loss wasn't an issue:** Codex checked the diff against main and read the worklog to see what was done. The full agent review skill standardized invocation—no custom prompt crafting needed.

**Precedent Set:**
1. One AI implements, one AI reviews (don't have both reviewing)
2. Fix findings immediately rather than deferring
3. Update WORKLOG throughout for context transfer
4. Create joint post-mortem to capture learnings

**External Validation:** [jarrodwatts/claude-delegator](https://github.com/jarrodwatts/claude-delegator) implements this same pattern at the infrastructure level—Claude handles implementation and synthesis, while GPT specialists handle analysis and review via MCP. The multi-model approach treats "implement" and "analyze" as distinct capabilities distributed across models.

### AI PR Reviewers: Greptile and CodeRabbit

**The Setup:** Both run automatically on every PR via GitHub integration. They serve different purposes.

**Greptile: The Confidence Scorer (x/5)**

Greptile provides a confidence score for every PR. This has been a train-stopper.

Example from PR #88 (Magic Link Rate Limiting):
> **Confidence Score: 5/5**
> - This PR is safe to merge with high confidence
> - The implementation follows TDD discipline with comprehensive test coverage, matches PRODUCT_SPEC.md requirements exactly, includes proper security considerations...

What Greptile catches:
- Architectural mismatches with existing patterns
- Missing test coverage for new code paths
- Security concerns (especially in auth/payment flows)
- Discrepancies between PR description and actual changes

**When Greptile scores low (2-3/5), the PR needs work.** I've learned to trust this signal.

**CodeRabbit: The Thorough Nitpicker**

CodeRabbit does deep static analysis and catches issues Greptile might miss.

Example from PR #92 (Capacity-Race Refund Flow):
> _⚠️ Potential issue_ | _🟡 Minor_
> **Worklog archived before post-completion updates were recorded.**
> The capacity-race refund flow is already implemented and tested in code, but the worklog was archived as a template without filling in completed milestones.

What CodeRabbit catches:
- Documentation drift (worklog says incomplete, but code is done)
- Missing commit SHAs in decision traces
- Unresolved TODOs in comments
- Type inconsistencies across service boundaries
- Sequence diagram generation for complex flows

**CodeRabbit's sequence diagrams are genuinely useful** - they auto-generate Mermaid diagrams showing the flow of a feature. Great for understanding complex PRs.

**The Workflow:**
1. Claude writes code + tests
2. Push to branch, open PR
3. Greptile gives confidence score → if low, investigate before asking human review
4. CodeRabbit provides detailed line-by-line comments → address nits
5. CI passes (tests, lint, build)
6. Human reviews with AI analysis already done

**Net effect:** Human reviewers spend time on architecture and product decisions, not catching typos or missing tests. The AI handles the mechanical review.

### Android-Specific Parallelism Concerns

**Gradle's Dirty Secret:** Gradle doesn't like parallel processes accessing the same project.

Unlike npm where you can run `npm install` in multiple worktrees simultaneously, Gradle:
- Locks the build cache
- Has daemon conflicts across worktrees
- Can corrupt incremental compilation state

**The Solution: Git Worktrees**

Worktrees give you separate working directories with their own Gradle daemons. Tested and confirmed—multiple Gradle instances CAN run in separate worktrees simultaneously, enabling parallel AI coding agents.

**What you need to set up:**
- A `worktree-setup.sh` script (or skill) to handle post-worktree setup:
  - Copy `.env` / local config files (not tracked by git)
  - Clear build caches if needed
  - Set up any worktree-specific configuration
- The first worktree setup takes longer than expected—script the gotchas so subsequent setups are fast

**Key insight:** The same worktree friction from web (env files, port conflicts, cache clearing) applies to Android. A setup script or skill with repeatable instructions makes parallel AI sessions practical. The patterns transfer; the setup just needs to be automated.

## 9. Platform Adaptation: What Android Needs

### Current State: No Equivalent to Playwright MCP
- Web: Playwright MCP lets AI see the browser, interact with elements, verify visual changes
- Android: Nothing equivalent exists yet
- The AI is flying blind for UI verification

### What's Needed

**1. ADB Skill**
```markdown
# skills/adb/SKILL.md
Commands the AI should know:
- `adb shell screencap -p > screenshot.png` - Capture screen
- `adb shell input tap X Y` - Tap coordinates
- `adb shell input text "..."` - Type text
- `adb logcat *:E` - View error logs
- `adb shell am start -n ...` - Launch activities
```

**2. scrcpy Integration**
- Real-time screen mirroring to desktop
- AI could potentially "see" the screen via screenshot analysis
- Interaction via adb input commands

**3. Emulator Orchestration**
- Spin up emulators programmatically
- Run UI tests and capture results
- Screenshot comparison for visual regression

**4. Build Verification Skill**
```markdown
# skills/android-build/SKILL.md
- `./gradlew assembleDebug` - Build the app
- `./gradlew test` - Run unit tests
- `./gradlew connectedAndroidTest` - Run instrumentation tests
- Parse build output for errors
- Retry with fixes until green
```

### The Same Patterns Should Transfer

| Web Pattern | Android Equivalent |
|-------------|-------------------|
| Playwright MCP | ADB + scrcpy skill |
| `npm test` | `./gradlew test` |
| ESLint | Detekt / Android Lint |
| TypeScript | Kotlin compiler |
| Vitest watch mode | `./gradlew test --continuous` |
| Browser DevTools | Layout Inspector + Logcat |

The feedback loop is the same: AI generates code → deterministic gate (build/test/lint) → AI fixes → repeat.

## 10. Topics I'm Still Exploring

*These are areas where I have hypotheses but not yet battle-tested patterns.*

### Subagents for Specialized Tasks
- Claude Code can spawn subagents with `Task` tool
- Potential: Security-Agent subagent that only does security review
- Question: How do subagents share context? How do they coordinate?

### Running Multiple Claude Code Instances
- Terminal: Multiple tmux panes with different Claude sessions
- Browser: Claude.ai for research, Claude Code for implementation
- Question: How do they stay in sync? Shared WORKLOG.md?

### Mobile Client Implementation
- The patterns work great for fullstack web
- Mobile adds: build times, device matrix, platform-specific APIs
- Question: Does the overhead/gain ratio change for Android?

### Context Window Management at Scale
- 200K context window sounds huge until you need to read 50 files
- WORKLOG.md for session restoration helps but isn't perfect
- Question: What's the ideal "working set" size for an AI coding session?

## 11. The Honest Assessment: What Works, What Doesn't

### What Works
- Complex features: 2-3x productivity
- Multi-concern reasoning (distributed systems)
- Documentation staying in sync
- Exposing blind spots via structure
- Catching race conditions I would have missed (async/await, React hooks)

### What Doesn't (Yet)
- Small changes: overhead eats the gains
- Context window anxiety
- Theatrical agent responses
- TDD quality variance
- Parallel execution: promise > reality (for now)
- Worktree setup friction

> **[CLAUDE'S TAKE]** My honest frustrations working in this workflow

## 12. Key Learnings Engineers Won't Want to Miss

*Distilled from 26 worklogs and 58 decision traces in Sparkpass*

### From the Trenches

1. **React StrictMode will betray you.** Effects run twice. If your AI writes code that calls an API in useEffect, you'll get double calls. Add refs to guard against this. (DT-20251228: Payment Flow Race Conditions)

2. **Async race conditions are invisible until they're not.** The AI wrote a status poll that captured state at function start. By the time the API returned, state had changed. The fix: re-check state AFTER async operations.

3. **"Planned for parallel, executed serial" is common.** Context limits, dependency chains, and coordination overhead often make serial faster in practice.

4. **P2002 errors are your friend.** Prisma's unique constraint violation tells you a race condition happened. Catch it, handle it gracefully, don't retry. (2025-12-31: Capacity Race Refund Flow)

5. **Concentrated gaps reveal scope creep.** When 5 out of 9 key questions are NO and all relate to one feature (Wallet Health), that feature is bigger than you thought.

6. **Constitutional invariants catch bugs in design, not just code.** Writing "INV-1: Lightning is source of truth" before implementation meant the recovery strategy was obvious.

7. **Post-mortems immediately after, not later.** Context decays fast. Do the decision trace while it's fresh.

8. **NEXT_AGENT_PROMPT.md pattern for multi-session work.** When a feature takes 3+ sessions, leave a prompt for your future self (or the next AI session).

9. **27 patterns from one comprehensive analysis.** The Backlog/Spec Gap Analysis produced 27 reusable patterns and updated 7 skills. Structured post-mortems compound.

10. **"70% already in BACKLOG" is validation, not redundancy.** When your analysis confirms existing backlog items, your tracking is working.

### For Android Engineers Specifically

11. **Gradle daemon conflicts will bite you.** Unlike npm, you can't easily parallel-build in worktrees. Plan for serial builds or isolated projects.

12. **Build times change the feedback loop.** Web: 2s rebuild. Android: 30s+ incremental. This changes how you structure AI interactions.

13. **Layout Inspector is your Playwright MCP... eventually.** We need skills that can read Layout Inspector output, interact via ADB, and verify UI state.

## 13. Getting Started: The 5-Step Adoption Path

1. **Start with PRODUCT_SPEC.md.** If you don't have a clear spec, the AI will hallucinate requirements. Garbage in, garbage out.

2. **Create agents for the perspectives you're missing.** Solo? Add @UX-Agent and @Security-Agent. Frontend-heavy team? Add @Backend-Agent. The agents are mirrors for your blind spots.

3. **Write skills for things you do more than twice.** The first time is exploration. The second time is pattern recognition. The third time, encode it in a skill.

4. **Use worklogs for anything that takes more than an hour.** They're your paper trail, your rubber duck, and your onboarding docs all in one.

5. **Trust the process, but verify the output.** The AI is a brilliant junior engineer. It needs code review, not rubber stamps.

## 14. Closing: The New Baseline

- If majority of code isn't AI-assisted, career risk
- This isn't about replacing engineers, it's about amplifying them
- The skill is knowing what to delegate and what to own
- The workflows are platform-agnostic; the tooling isn't (yet)
- Android is the next frontier

---

## SERIES STRUCTURE (4 Parts)

**Series Title:** "Vibe Engineering: From Random Code to Deterministic Systems"

**Taglines (rotate per post):**
- Why most engineers will stop writing their own code
- How senior engineers ship in the AI era
- Turning chaos into production architecture
- Delegating to machines without losing your soul

---

**Canon Framing (use verbatim in Part 1 intro):**

> *Vibe Engineering is the discipline of harnessing stochastic code generation and forcing it through deterministic gates — compilers, tests, invariants, and specs — until randomness becomes architecture.*

---

**Identity Ladder:**
- Junior engineers write code
- Mid engineers refactor code
- Senior engineers design systems
- **Vibe Engineers design the constraints that machines write inside**

You're not vibe coding. You're vibe engineering.

---

**Philosophy:** This is an AI workflow article, not a web dev article. The mental models, tools, and processes apply to any codebase. Where tooling differs across platforms (build commands, UI verification), we call it out explicitly - but the *workflow* is platform-agnostic.

**Writing Style:** Avoid the "not X, it's Y" / "isn't X, but Y" pattern. AI overuses this construction and it gets exhausting to read. Say what something *is* directly instead of defining it by negation. One or two uses per article max.

---

### Part 1: You Haven't Been Replaced — You've Been Promoted
*~1500 words*

**Opening line:**
> Everyone was worried AI would replace software engineers.
> Instead, it promoted us into the rest of the company.

**Thesis:** Devs didn't get replaced — they absorbed product, QA, design, and ops like some kind of corporate black hole.

**Sections:**
- The Hook (vibe-coded a fullstack app, here's what I learned)
- The Mental Model (Senior Eng + Smart Intern dynamic)
- The Foundation (Spec-Driven Development)

**Core message:** AI coding is the new baseline. You're not just an engineer anymore — you're product, QA, and ops. Here's how to think about it.

**🤖 Claude's Take:** 2 inline callouts
- What it feels like from the AI side (pattern-matching vs. intent)
- Why clear specs make my job dramatically easier

**🔧 Tooling Note:**
> The examples use Next.js/TypeScript, but the mental model is language-agnostic. `PRODUCT_SPEC.md` works whether you're building React components, Kotlin ViewModels, or Go services.

**Ends with:** Teaser for Part 2 - "Now that you have the mental model, here are the four tools that make it work."

---

### Part 2: Agents, Skills, Worklogs, and the Feedback Loop
*~2000 words*

**Sections:**
- Agent Personas (imaginary colleagues)
- Skills (reusable prompts)
- Worklogs (the backbone)
- The Feedback Loop (FIRST-CLASS TOOL, not an afterthought)
  - Post-mortems after every feature
  - Decision traces (DT-YYYYMMDD-NNN) linking decisions to code
  - "What Surprised the AI" section - captures gaps between training data and your codebase
  - Update skills and agents based on lessons learned
  - This is how the system gets smarter over time
- System 1 vs System 2: When Worklogs Are Overkill
  - Worklogs are powerful but heavy for small tasks (fixing a typo doesn't need a WORKLOG)
  - *Thinking Fast and Slow* parallel: System 1 (fast, intuitive) vs System 2 (slow, deliberate)
  - Human brains know when to switch; some problems are trickier than they appear
  - Current gap: AI doesn't have this intuition baked in yet
  - Future models should learn when to reach for the heavy process vs. just do the thing

**Core message:** Here are the four tools. Copy these patterns. The feedback loop is what makes the others improve.

**🤖 Claude's Take:** 2 inline callouts
- How agent personas shape my reasoning vs. just answering questions
- The value of being corrected (and remembering the correction)

**🔧 Tooling Note:**
> Replace `npm test` with `./gradlew test` or `go test ./...` - the TDD rhythm is identical. Agent personas (@Security-Agent, @UX-Agent) don't care what language you're writing.

**Ends with:** "You have the tools. In Part 3, watch me use all of them on a real feature."

---

### Part 3: Designing Failure Before It Designs You
*~2500 words*

**Sections:**
- The Problem (demo failure, payment UX broke)
- Multi-Agent Analysis (BTC-Agent, Systems-Agent, UX-Agent)
- Constitutional Invariants (INV-1 through INV-5)
- What Shipped vs. What Got Deferred
- Deterministic Gates (why AI + tests works)
- Key Learnings (top 10, distilled from 26 worklogs)

**Core message:** Watch me use all of this on a real feature. Here's what I learned.

**🤖 Claude's Take:** 1 inline callout
- What I learned from this specific workflow

**🔧 Tooling Note:**
> The Deterministic Gate pattern: AI generates code → tests → lint → ship. The specific tools (Vitest vs JUnit, ESLint vs Detekt) change; the loop doesn't. "The AI is random. The gate is deterministic. Spin until green."

**Ends with:** "The system works for one feature. In Part 4: what happens when you try to scale it?"

---

### Part 4: Scaling the Vibes: Multi-AI Workflows, PR Reviewers, and What's Next
*~2000 words*

**Sections:**
- Parallelism: Promise vs. Reality
  - Two types: Subagents (Type 1, context-limited) vs. Independent Sessions (Type 2, coordination-limited)
  - The Context Window Problem (compaction is lossy)
  - Type 1: Parallel domain analysis (subagent context limits)
  - The NEXT_AGENT_PROMPT System: Serial multi-agent with explicit handoffs (beats compaction)
  - Type 2: Git worktrees, multiple terminals, mobile (setup/coordination friction)
  - Multi-AI pairing (Claude + Codex)
- AI PR Reviewers (Greptile, CodeRabbit)
- Topics I'm Still Exploring
- The Honest Assessment (what works, what doesn't)
- The Next Generation: Skills as Training Data
  - The models that find a way to take in the best skills and workflows for their next round of training will appear even more magical than this current generation
  - We're not just using AI - we're teaching it how to be used
- Getting Started (5 steps)
- Closing

**Core message:** Here's what's next - and how to get started today.

**🤖 Claude's Take:** 2 inline callouts
- Why parallel work is harder than it looks
- My honest frustrations working in this workflow

**🔧 Tooling Note:**
> Parallelism friction varies by build system. Gradle daemon locks are worse than npm; Go modules are cleaner than both. AI PR reviewers (Greptile, CodeRabbit) work on any GitHub repo regardless of language.

**Ends with:** The 5-step adoption path and the thesis: "The skill is knowing what to delegate and what to own."

---

## Appendix: Tooling Cheat Sheet

Reference table for adapting the workflow to different stacks:

| Workflow Element | This Article (Next.js) | Android | Go Backend |
|------------------|------------------------|---------|------------|
| **Spec file** | PRODUCT_SPEC.md | Same | Same |
| **Agent personas** | @Security-Agent, @UX-Agent | Same | Same |
| **Skills** | /feature-dev, /post-mortem | Same | Same |
| **Test command** | `npm test` | `./gradlew test` | `go test ./...` |
| **Lint** | `npm run lint` (ESLint) | `./gradlew detekt` | `golangci-lint run` |
| **Type check** | TypeScript compiler | Kotlin compiler | `go build` |
| **UI verification** | Playwright MCP | ADB + scrcpy (TBD) | N/A |
| **Watch mode** | Vitest --watch | `--continuous` | fswatch + go test |
| **Worktree friction** | Env files, .next cache | Gradle daemon locks | Low |

**Key insight:** Everything above the line (spec, agents, skills) is identical. Everything below (commands, tools) is just syntax.

---

## Remaining Decisions

- [x] Series title - **"Vibe Engineering: From Random Code to Deterministic Systems"** ✓
- [x] Publication cadence - **Weekly** ✓
- [x] Part titles - **All 4 locked** ✓
- [x] Claude's voice format - **Hybrid approach** ✓
  - **Self-interview content:** Q&A format (preserves the authentic conversation)
  - **Inline [CLAUDE'S TAKE] callouts:** Styled blockquotes with 🤖 label
    ```
    > **🤖 Claude's Take**
    >
    > [Claude's perspective in first person]
    ```
- [x] File excerpts - **Conceptual with toy examples** ✓
  - Keep examples accessible, not Sparkpass-specific
  - Generate simplified examples from our experiences (e.g., generic `@Security-Agent` instead of `@BTC-Agent`)
  - Readers should grok the pattern without domain knowledge
- [x] Where to publish - **Everywhere for maximum visibility** ✓

### Primary Publishing (Canonical Source)
- [ ] **Medium** - @AndrewOrobator personal blog (canonical URL)
  - Submit to publications: Better Programming, Level Up Coding, Towards Data Science

### Cross-Post Platforms (with canonical link back to Medium)
- [ ] **Dev.to** - 1.5M+ developers, easy to trend, strong AI/tooling audience
- [ ] **Hashnode** - Personal branding, own domain option
- [ ] **HackerNoon** - Human editors, strong tech/startup audience
- [ ] **freeCodeCamp** - Massive reach, they promote for you (requires application)

### Newsletter Submissions
- [ ] **Android Weekly** - Curated Android newsletter
- [ ] **Android Digest** - Android-focused content
- [ ] **TLDR** - 1.25M readers, daily tech newsletter
- [ ] **Changelog** - Weekly dev newsletter, broad reach
- [ ] **The Pragmatic Engineer** - #1 tech newsletter on Substack (pitch Gergely)

### Reddit
- [ ] **r/programming** - General programming audience
- [ ] **r/VibeCoding** - Direct target audience
- [ ] **r/ClaudeAI** - Claude users
- [ ] **r/LocalLLaMA** - AI/LLM enthusiasts
- [ ] **r/ExperiencedDevs** - Senior engineers
- [ ] **r/androiddev** - Android developers

### Social Media
- [ ] **Twitter/X** - Thread format, tag @karpathy, @AnthropicAI
- [ ] **LinkedIn** - Post + article, engineering leadership audience
- [ ] **Bluesky** - Growing tech audience

### Discord Communities
- [ ] **Anthropic Discord** - Claude users and developers
- [ ] **Vibe Coders** - AI coding enthusiasts
- [ ] **Vibe Coding Realm** - Projects + hackathons
- [ ] **The Programmer's Hangout** - #ai-and-ml channel

### Hacker News
- [ ] **news.ycombinator.com** - Submit Part 1, engage with comments

### Podcasts (Pitch for Guest Appearances)
- [ ] **Changelog Podcast** - Developer-focused
- [ ] **Software Engineering Daily** - Technical deep dives
- [ ] **Android Developers Backstage** - Google's Android podcast