---
name: post-mortem
description: Capture lessons after shipping a feature. Use after completing a feature or fixing a significant bug.
---

# Post-Mortem

This skill guides you through capturing lessons from a completed feature or bug fix.

## When to Use

- After shipping a feature
- After fixing a significant bug
- After any work that taught you something worth remembering

## The Post-Mortem Template

Create a file: `docs/decision-traces/[DATE]_[feature-name].md`

```markdown
# Post-Mortem: [Feature Name]

**Date:** [YYYY-MM-DD]
**Duration:** [How long did this take?]

## What We Built

[One paragraph summary]

## What Went Well

- [Thing that worked]
- [Thing that worked]

## What Didn't Go Well

- [Thing that was harder than expected]
- [Thing we'd do differently]

## What Surprised Us

- [Unexpected behavior or edge case]
- [Assumption that was wrong]

## Lessons Learned

### Should Become a Skill

- [Repeatable pattern worth encoding]

### Should Update an Agent

- [New check for @Security-Agent]
- [New concern for @UX-Agent]

### Should Update the Spec

- [Edge case to document]
- [Constraint to add]

## Action Items

- [ ] [Concrete action to take]
- [ ] [Concrete action to take]
```

## The Key Questions

Ask yourself:

1. **What would I tell past-me before starting this?**
   - This often reveals what should be in the spec or a skill.

2. **What did the AI get wrong repeatedly?**
   - This reveals gaps in your prompts, agents, or skills.

3. **What did the AI get right that surprised me?**
   - This reveals capabilities you can leverage more.

4. **If I had to do this again, what would I do differently?**
   - This is the core of the lesson.

## After the Post-Mortem

1. **Update skills** if you found a repeatable pattern
2. **Update agents** if you found a new concern to check
3. **Update the spec** if you found undocumented edge cases
4. **Archive the worklog** to `docs/worklogs/`

The post-mortem is only valuable if it changes something. Don't just write it—act on it.
