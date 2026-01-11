# Vibe Engineering: From Random Code to Deterministic Systems

![Vibe Engineering header image](vibe_engineering_header.jpg)
*Prompt by Claude Opus 5.2, image generated Grok 4.1*

## Part 1: You Haven't Been Replaced — You've Been Promoted

*By Andrew Orobator, Claude Opus 4.5 Editor: Chat GPT 5.2*

*This is Part 1 of a 4-part series on AI-assisted development workflows.*

1. **You Haven't Been Replaced — You've Been Promoted** ← You are here
2. Agents, Skills, Worklogs, and the Feedback Loop: The New Engineering Stack
3. Designing Failure Before It Designs You
4. Scaling the Vibes

---

> **⚠️ Who This Is For**
>
> This series assumes you've shipped production systems and hit the limits of naive AI coding. If you're still in the "wow, it wrote a todo app" phase, this will feel over-engineered. Come back after you've shipped a bug that the AI confidently told you was fine.

---

Everyone was worried AI would replace software engineers.

Instead, it promoted us into the rest of the company.

Over the winter holidays, I vibe-coded a fullstack web app from scratch. I'm an Android engineer by trade — Kotlin, Gradle, the whole ecosystem. I hadn't touched web dev since college. But I wanted to see how far I could push AI-assisted development without corporate constraints, and web seemed like the perfect playground: fast iteration, mature tooling, and no excruciatingly long Gradle builds to break my focus. My one rule was that I wasn't allowed to write code myself, but I could inspect the outputs and make sure things work.

Somewhere along the way, I absorbed product, QA, design, and ops like some kind of corporate black hole. The job changed entirely.

This series is about the workflows that made that possible — the *mental models* and *systems* that turn chaotic AI output into production architecture.

By the end of this series, you'll never start a feature without writing one invariant and one worklog. I'll show you both — and you can steal my templates from the [starter kit](https://github.com/AOrobator/vibe-engineering-starter).

> Vibe Engineering is the discipline of harnessing stochastic code generation and forcing it through deterministic gates — compilers, tests, invariants, and specs — until randomness becomes architecture.

You're not vibe coding. You're vibe engineering 😎

---

## The Identity Ladder

Here's how I think about where we are:

- Junior engineers write code
- Mid-level engineers refactor code
- Senior engineers design systems
- **Vibe Engineers design the constraints that machines write inside**

If that last line sounds abstract, let me make it concrete. By the end of this series, you'll have a system where:

1. You define *what* needs to be built (spec)
2. You define *what must always be true* (invariants)
3. You define *who reviews the work* (agent personas)
4. The AI writes the code, tests, and docs
5. Deterministic gates (compiler, tests, lint, QA) reject anything that doesn't pass
6. You review and ship

The AI is random. The gates are deterministic. Spin until green.

---

## What I Actually Built

I built a Bitcoin-native event ticketing platform. Lightning payments, two-invoice checkout flows, magic link authentication, the works.

**The stats:** In 33 days of nights and weekends (Dec 7 → Jan 9):

- 54 decision traces — every design choice documented and auditable
- 9+ bugs caught pre-production — race conditions, security exposures, API drift — all caught before users saw them
- 7 agent VETOs — Test-Agent, QA-Agent, and Product-Agent blocked broken code from shipping
- 13 postmortems → skills — failures became reusable lessons; process improves every feature
- 27 multi-session worklogs — context survives across sessions; no re-explaining

I could tell you the line counts (94k total, more tests and docs than production code). But lines of code are a vanity metric. The numbers above are *quality* metrics — they're why I ship with confidence, not just speed.

The AI was simultaneously:

- **Acting as product manager** — catching edge cases I hadn't specified ("what happens if the user closes the browser mid-payment?")
- **Acting as QA** — writing tests that found bugs before I could
- **Acting as security reviewer** — flagging session token exposure before I shipped it
- **Acting as tech writer** — keeping docs in sync with code automatically

I didn't ask it to do most of this. The *workflow* made it happen.

The workflow is what this series is about.

---

## The Mental Model: Senior Eng + Smart Intern

Think of it like you're a senior engineer mentoring a brilliant college grad. They can code circles around most people. They learn fast. They're eager.

But they have no real-world judgment.

One time, I was implementing a feature and Claude told me it "took a shortcut because there was a deadline coming up."

In my personal project. With no deadline.

The way AI is connected and disconnected from reality is amusing sometimes. It pattern-matches on millions of codebases where people *did* have deadlines. So it assumed I did too.

This is the core insight: **LLMs are amazing coders, but they lack context about your specific situation.** They don't know your business constraints, your user expectations, your security requirements, or your "we tried that and it broke production" history.

Your job is to provide that context. Their job is to execute within it.

**You:** Architecture, scope, constraints, review.
**AI:** Implementation, exploration, drafting, iteration.

When you invert this — when you let the AI make architectural decisions or define scope — you get technically impressive code that solves the wrong problem. Or the right problem in a way that creates three new problems.

> **🤖 Claude's Take**
>
> From my side, the difference is stark. When you give me a vague request like "build a login system," I'm pattern-matching on every login system I've ever seen. OAuth? Magic links? Username/password? Social auth? I'll pick something plausible, but I'm essentially guessing.
>
> When you give me a spec that says "magic links only, 24-hour expiry, SHA256 hashed tokens, rate limited to 5 per email per hour" — now I'm not guessing. I'm implementing. The constraints aren't limiting me; they're telling me what you actually want.
>
> The best sessions I have are when the human has done the hard thinking about what and I get to focus on how.

---

## The Foundation: Spec-Driven Development

The hardest thing in software is usually specifying what needs to be built.

This is doubly true with AI. If you don't have a clear spec, the AI will hallucinate requirements. Garbage in, garbage out — but now the garbage comes out faster and with more confidence.

For my project, I maintain a single `PRODUCT_SPEC.md` file. It contains:

- **User flows** — step-by-step walkthroughs of every feature
- **Happy paths** — what happens when everything works
- **Sad paths** — what happens when things fail
- **Edge cases** — the weird stuff ("user pays platform fee, then closes browser before paying ticket fee")
- **Business logic** — fee calculations, rate limits, capacity rules
- **NOT in MVP** — explicit list of features we're deferring

That last section is crucial. Half of AI productivity gains get eaten by scope creep. The AI will happily implement features you didn't ask for if they seem related. Having an explicit "NOT in MVP" section gives you — and the AI — a reference point for saying no.

Here's a toy example of what spec-driven development looks like:

```
## User Registration Flow

### Happy Path
1. User enters email on /login
2. System sends magic link email
3. User clicks link within 24 hours
4. System creates session, redirects to /dashboard

### Sad Paths
- Invalid email format → Show inline validation error
- Email send fails → Show error, suggest retry
- Link expired → Redirect to /login?error=expired
- Link already used → Redirect to /login?error=used

### Constraints
- Rate limit: 5 magic links per email per hour
- Rate limit: 10 magic links per IP per hour
- Token storage: SHA256 hash (never store plaintext)
- Session: HTTP-only cookie, 7-day expiry
```

## Beyond Product: System Specs

Spec-driven development applies to more than just product features. For Sparkpass, I wrote system specs before building the systems.

**INVOICE_SVC_SPEC.md** is nearly 800 lines. It describes the invoice microservice — API contracts, security controls, flow diagrams, error handling, deployment configuration — all before I wrote a single line of implementation code.

Here's what that enabled:

```
## API Contract: POST /invoices

### Request

```json
{
  "quoteId": "uuid",
  "type": "PLATFORM_FEE" | "TICKET"
}
```

### Success Response (201)

```json
{
  "id": "uuid",
  "paymentRequest": "lnbc...",
  "expiresAt": "ISO8601"
}
```

### Error Responses
- 400: Invalid request body
- 404: Quote not found
- 409: Invoice already exists for this quote/type
- 503: Lightning node unavailable
```

When I asked Claude to implement this endpoint, it had everything it needed. The error codes were defined. The response shapes were defined. The edge cases (quote not found, duplicate invoice) were already documented.

**CI.md** (390 lines) describes every CI job: what it checks, why it exists, what failure modes it catches, and how to fix common failures. I wrote it before configuring any GitHub Actions.

```
### Prisma Validation

**Why this exists:** Per post-mortem `2025-12-25_migration-ordering-failure.md`:
Two migrations were out of order. Prisma replays migrations into a shadow
DB, so the history could not be applied from empty.

**Failure fix:**
1. Check migration order in `prisma/migrations/`
2. Ensure drops come AFTER backfills (two-step pattern)
3. If history is broken, consider baseline recovery


Every CI job links back to a decision trace or post-mortem explaining *why* it exists. When a job fails, the spec tells you how to fix it.

**The insight:** The fun part of engineering was always system design — thinking about how pieces fit together, what happens when things fail, where the boundaries are. The coding was just necessary to make the design real.

AI inverts this. I spend more time on the fun part — the design — and delegate the tedious typing to Claude. The system specs become conversation artifacts. Instead of re-explaining the two-invoice payment flow every session, I say "check INVOICE_SVC_SPEC.md section 4" and Claude has full context.

One more pattern worth noting: both specs have explicit "Future Improvements" or "V1+" sections listing features we're *not* building yet. CI.md defers e2e tests, deploy previews, and security scanning to post-launch. The spec gives us permission to stop.

---

## The Thesis, Restated

Here's what I want you to take from Part 1:

1. **AI coding is the new baseline.** If you're not using it, you're leaving productivity on the table.
2. **You've been promoted, not replaced.** Your job is now to define the constraints that machines write code inside.
3. **Specs aren't optional.** Without a clear spec, AI amplifies confusion. With a clear spec, AI amplifies execution. This applies to product features *and* system architecture.
4. **You're the senior eng.** The AI is your brilliant, context-free, occasionally hallucinatory intern. Act accordingly.
5. **Design is the fun part again.** AI handles the tedious typing. You get to spend more time thinking about how systems fit together.

This mental model is the foundation. Tools make it real.

---

## What's Next

In Part 2, we'll cover the four tools that make this workflow concrete:

- **Agent Personas** — imaginary colleagues that catch what you miss
- **Skills** — reusable prompts that encode your hard-won lessons
- **Worklogs** — the backbone that keeps AI work auditable and resumable
- **The Feedback Loop** — post-mortems, decision traces, and "what surprised the AI"

That last one is critical. Without it, you make the same mistakes over and over. The feedback loop is how skills and agents evolve — how your system gets smarter with every feature.

> **📝 Before Part 2**
>
> Create a file called `PRODUCT_SPEC.md` in your project. Write exactly three bullet points describing what your current feature must never break. That's it—three invariants.
>
> This takes 2 minutes. When you get to Part 2, you'll already have the foundation.
>
> Or grab the templates from the [starter kit](https://github.com/AOrobator/vibe-engineering-starter).

---

*🔧 Tooling Note: The examples in this series use Next.js and TypeScript, but the mental model is language-agnostic. `PRODUCT_SPEC.md` works whether you're building React components, Kotlin ViewModels, or Go services. The spec doesn't care about your framework—it cares about your product.*

---

*Part 2: Agents, Skills, Worklogs, and the Feedback Loop →*
