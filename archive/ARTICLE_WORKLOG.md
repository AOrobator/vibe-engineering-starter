# Vibe Engineering Article Series - Revision Worklog

## Mission
Address ChatGPT feedback to improve readability and adoption of the 4-part article series.

## Milestones

### M1: Part 2 Early Hook (Article Edit) ✅
- [x] Move "Solo developers can have code review. You just invent the reviewers." line up to first 200 words
- [x] Restructure opening to deliver emotional payoff faster
- Note: Kept original line at end of Agent section as callback/reinforcement

### M2: Part 3 Transferable Pattern Callouts (Article Edit) ✅
- [x] Add callout after INV-1: "Substitute Lightning with Stripe webhook or Kafka commit. Network truth beats local state."
- [x] Add callout after INV-2: "Replace NWC with your external API. Always verify upstream before trusting cache."
- Decided: 2 callouts is enough; INV-3/4/5 are already generic enough

### M3: Part 4 Mental Map (Article Edit) ✅
- [x] Add orienting paragraph before parallelism deep dive
- [x] Explain the three approaches upfront: subagents (context-limited), independent sessions (coordination-limited), serial handoffs (the one that worked)
- Added: "Understanding *which* constraint you're hitting is more useful than just 'parallelism is hard'"

### M4: Starter Kit GitHub Repo (New Deliverable) ✅
- [x] Create repo structure at `~/dev/vibe-engineering-starter/`
- [x] AGENTS.md with Security, UX, Systems, Machiavelli, Test agents
- [x] PRODUCT_SPEC.md template (happy/sad/edge bundled per flow)
- [x] WORKLOG.md template (TDD with atomic commits)
- [x] .claude/skills/feature-dev/SKILL.md
- [x] .claude/skills/post-mortem/SKILL.md
- [x] README.md explaining the system
- [x] Git init and push to https://github.com/AOrobator/vibe-engineering-starter
- [x] Link from Part 4 "Getting Started" section

### M5: Part 2 Quick Start Box (Article Edit) ✅
- [x] Add 30-second "minimal setup" callout near the top
- [x] "Copy these 3 files, run one skill, ship one feature"
- [x] Reduces bounce before conceptual stacking pays off

### M6: Part 3 Decision Table (Article Edit) ✅
- [x] Add complexity/risk/time-to-ship table for A/B/C options
- [x] Helps skimmers parse without treating as prose homework

### M7: Starter Repo "First 15 Minutes" Quickstart ✅
- [x] Add QUICKSTART.md to repo
- [x] Steps: create worklog → run agent review → write decision trace → done
- [x] Lowers activation energy (pilot flame before cranking stove)

### M8: Part 1 Micro-Payoff (Article Edit) ✅
- [x] Add promise in first 300 words: "By the end of this series you'll never start a feature without..."
- [x] Reframe Part 1 from essay → promise
- [x] Convert "bookmark this" to "finish this"

### M9: Part 1 Habit Seed CTA (Article Edit) ✅
- [x] Add concrete action before Part 2
- [x] "Create PRODUCT_SPEC.md with 3 bullet points: what your current feature must never break"
- [x] Turns identity-shaping into behavior-shaping

### M10: Part 2 Failure Vignette (Article Edit) ✅
- [x] Add failure story in Agent Reviews section
- [x] "The Race Condition Claude Missed" — Claude + Codex pairing, Codex caught stale useEffect state
- [x] Lesson: "One AI implements, one AI reviews—not both"

### M11: Part 4 Failure Vignette (Article Edit) ✅
- [x] Add failure story about context collapse in Context Window Problem section
- [x] "When Compaction Nuked the Worklog" — TodoWrite ≠ Worklog, session lost milestone tracking
- [x] Lesson: "Compaction will eat your context. Verify persistent state before session ends."

### M12: Part 1 Audience Banner (Article Edit) ✅
- [x] Add explicit "this is not beginner content" banner after TOC
- [x] "Come back after you've shipped a bug that the AI confidently told you was fine"
- [x] Narrowing audience increases adoption among people who matter

### M13: Part 4 Context Banner (Article Edit) ✅
- [x] Add "Prerequisites" banner after TOC
- [x] "If you haven't lost a session to context collapse... Parts 1-3 will serve you better"
- [x] Sets expectations that Part 4 is intellectually strongest but assumes prior pain

### M14: Quantification Framework ✅
- [x] Define metrics that prove the system works (not LOC vanity)
- [x] Backtraced real metrics from decision traces, worklogs, commit history
- [x] Replaced Part 1 LOC stats with quality metrics table:
  - 54 decision traces (auditability)
  - 9+ bugs caught pre-production (prevention)
  - 7 agent VETOs (enforcement)
  - 13 postmortems → skills (learning velocity)
  - 27 multi-session worklogs (context survival)
- [x] LOC mentioned as aside, not headline

### M15: NEXT_AGENT_PROMPT Failure Modes (Article Edit) ✅
- [x] Add "Where NEXT_AGENT_PROMPT Breaks" section after the pattern description
- [x] Include failure modes table: stale pointers, false completion, priority drift, split-brain, checklist bloat
- [x] Add prior art citations: I-PASS/SBAR (clinical handoffs), ADRs, Temporal.io
- [x] Key insight: "a handoff protocol is only as good as its invariants + validation"

### M16: ChatGPT Final Polish (Article Edit) ✅
- [x] Add "Most AI workflows optimize for parallelism. This one optimizes for memory." to NEXT_AGENT_PROMPT section
- [x] Add cognitive compression metric to conclusion: "how little did I have to re-explain myself?"
- [x] Include specs, skills, worklogs, and NEXT_AGENT_PROMPT as the compression tools

## Session Log

### 2026-01-11 - Session 2
- Completed M10-M16 (failure vignettes, audience banners, quantification, NEXT_AGENT_PROMPT failure modes, final polish)
- Added real failure stories from Sparkpass decision traces (Codex race condition, worklog accountability)
- Replaced LOC vanity metrics with quality metrics backtraced from actual artifacts
- Added NEXT_AGENT_PROMPT failure modes with prior art citations
- ChatGPT's final verdict: "ship it"

### 2026-01-10 - Session 1
- Completed Part 4 draft (~2,634 words)
- Fixed Greptile/CodeRabbit accuracy based on actual PR review analysis
- Added Type 2 parallelism "still exploring" section
- Removed fabricated Voice Interfaces section
- Received and analyzed ChatGPT feedback
- Created this worklog to track revisions

## What Surprised the AI
- ChatGPT's "filter not lose" framing: Parts 2-3 don't lose attention, they select the right readers
- The suggested Part 2 opening fix (generic pain story) was weaker than the existing hook line buried in the article
- Starter kit is highest-leverage deliverable for adoption
- ChatGPT's second round: "artifacts that survive context loss" is the defensible edge vs typical agentic content
- ChatGPT's third round: Part 1 is "identity-shaping but not behavior-shaping" — needs urgency + action
- NEXT_AGENT_PROMPT.md is "the single highest-impact idea for advanced readers"
- ChatGPT's fourth round reframe: "AI accountability engineering" > "vibe coding" — this is about making randomness accountable
- NEXT_AGENT_PROMPT is "bigger than vibe coding—a general theory of how humans + LLMs collaborate over time"
- Constitutional invariants are the killer primitive; "truth hierarchy" separates from 95% of AI dev content
- The real audience is narrower than stated: senior+ engineers, solo founders, staff ICs — not "developers"
- ChatGPT's stress test of NEXT_AGENT_PROMPT: failure modes include stale pointers, false completion, priority drift, split-brain, checklist bloat
- Prior art we're reinventing: I-PASS/SBAR (clinical handoffs), ADRs (architectural decisions), Temporal.io (durable execution)
- ChatGPT's final take: "this is not a blog series anymore—it's the first credible articulation of human-AI collaboration as a systems discipline"
- The cognitive compression framing: "how little did I have to re-explain myself?" is the real metric

## Decisions Made
- Starter kit will be linked repo, not in-article (avoids bloat, allows iteration)
- Part 2 hook: use existing "invent the reviewers" line, not fabricated pain story
- Part 3 callouts: 2-3 is enough, more would dilute specificity
