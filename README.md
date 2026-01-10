# Vibe Engineering Starter Kit

A copy-pasteable foundation for AI-assisted development workflows.

From the article series: **Vibe Engineering: From Random Code to Deterministic Systems**

## What's Included

```
.
├── AGENTS.md              # Agent personas for multi-perspective code review
├── PRODUCT_SPEC.md        # Template for defining what you're building
├── WORKLOG.md             # Template for tracking multi-session work
└── .claude/
    └── skills/
        ├── feature-dev/   # Skill for implementing features with TDD
        └── post-mortem/   # Skill for capturing lessons after shipping
```

## Quick Start

1. Copy these files into your project root
2. Fill in `PRODUCT_SPEC.md` with your product's happy paths, sad paths, and constraints
3. When starting a feature, create a `WORKLOG.md` from the template
4. Invoke agents during review: "@Security-Agent, review this change"
5. After shipping, run `/post-mortem` to capture lessons

## The Core Loop

```
Spec → Implement → Agent Review → Ship → Post-Mortem → Update Skills
         ↑                                                    │
         └────────────────────────────────────────────────────┘
```

The feedback loop is what makes this work. Post-mortems improve skills. Skills improve the next feature. The system gets smarter with each iteration.

## Customization

- Add domain-specific agents to `AGENTS.md` (e.g., @Performance-Agent, @Accessibility-Agent)
- Create new skills in `.claude/skills/` for repeatable tasks in your codebase
- Extend `WORKLOG.md` with project-specific sections

## Learn More

Read the full article series for the philosophy behind this workflow:
- Part 1: You Haven't Been Replaced — You've Been Promoted
- Part 2: Agents, Skills, Worklogs, and the Feedback Loop
- Part 3: Designing Failure Before It Designs You
- Part 4: Scaling the Vibes

---

*Created by Andrew Orobator and Claude Opus 4.5*
