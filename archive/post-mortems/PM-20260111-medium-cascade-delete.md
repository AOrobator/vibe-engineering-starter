# Post-Mortem: Medium Cascade Delete Disaster

**Date:** 2026-01-11
**Severity:** High (data loss, unrecoverable via undo)
**Session:** Article revisions, Session 3

---

## Summary

While embedding GitHub Gists into a Medium article via Playwright, a backspace operation cascade-deleted the entire second half of the article. Medium's undo buffer was exhausted from earlier operations, making the deletion unrecoverable.

## Timeline

1. **17:15** - Successfully embedded first gist (User Registration Flow)
2. **17:18** - Noticed paragraph text was split around gist embed ("Here's a toy example of what spec-driv" / "en development looks like:")
3. **17:20** - Attempted to clean up split fragments using backspace
4. **17:21** - Backspace cascade-deleted "Beyond Product: System Specs" section and everything after it (~40% of article)
5. **17:22** - Attempted undo (Meta+z) 20+ times - no effect
6. **17:25** - Realized undo buffer was exhausted from earlier failed selection attempts
7. **17:30** - Context window compacted, losing session state mid-recovery
8. **17:45** - Recovered content from `article1_rendered.html` source file

## Root Cause

**Immediate:** Medium's contenteditable implementation has unpredictable behavior. Backspace after certain cursor/selection states triggers cascade deletion of entire content blocks rather than single characters.

**Contributing:**
1. Earlier in the session, multiple selection attempts (shift+click, triple-click, Meta+a) had failed and been undone - this exhausted Medium's finite undo buffer
2. No awareness that undo buffer could be "used up"
3. No explicit checkpoint/backup before destructive operations

## What Went Wrong

1. **Violated implicit invariant:** Assumed backspace would delete one character/selection, not cascade to entire sections
2. **Exhausted recovery mechanism:** Didn't know Medium's undo had finite capacity (~10-15 operations)
3. **No defensive backup:** Didn't screenshot or save article state before attempting edits
4. **Context collapse compounded failure:** Session compacted mid-recovery, losing diagnostic context

## What Went Right

1. **Source file existed:** `article1_rendered.html` contained full canonical content
2. **Worklog documented the failure:** Session 3 entry captured what happened for future reference
3. **Skill was created immediately:** Lessons encoded in `.claude/skills/medium-editing/SKILL.md` before continuing

## Lessons Learned

### Technical
- Medium's undo buffer is finite and falls off silently
- Backspace in contenteditable can cascade unpredictably
- Selection behavior in code blocks is inconsistent (Meta+a selects entire article)

### Process
- Always keep source HTML open in separate tab during Medium editing
- Never use backspace to clean up - use triple-click + retype instead
- Create explicit checkpoints before risky operations

### Meta
- This failure mirrors the "When Compaction Nuked the Worklog" vignette in the article being edited
- The article about context collapse was destroyed by context collapse
- Irony is pedagogically useful: real failures teach better than theoretical ones

## Action Items

| Action | Owner | Status |
|--------|-------|--------|
| Create `.claude/skills/medium-editing/SKILL.md` | Claude | ✅ Done |
| Add "What Surprised the AI" entry about cascade delete | Claude | ✅ Done |
| Archive bloated worklog, create focused one | Claude | ✅ Done |
| Recover article content from source HTML | Claude | 🔄 In Progress |
| Add pre-flight checklist to Medium skill | Claude | ✅ Done |

## Skill Updates

Created new skill: `.claude/skills/medium-editing/SKILL.md`

Key rules added:
- NEVER use backspace to clean up text
- NEVER rely on undo (buffer is finite)
- ALWAYS keep source HTML open
- Use triple-click + retype for paragraph replacement

## Prevention

For future Medium editing sessions:
1. Pre-flight checklist in skill (source file open, backup made)
2. Explicit "NEVER" rules for dangerous operations
3. Recovery procedures documented for common failure modes

---

## The Irony Section

This post-mortem exists because of the same failure mode the article describes:

> "Compaction will eat your context. You can't prevent it, but you can detect it."

The article about detecting context collapse was lost to a cascade delete, then the session compacted, and the recovery had to be reconstructed from persistent artifacts (source HTML, worklog).

The system worked exactly as designed - persistent state survived, ephemeral state was lost. The lesson is now encoded in a skill that will prevent this specific failure from recurring.

**This is the feedback loop in action.** Failure → Post-mortem → Skill → Prevention.
