# Skill: Medium Article Editing via Playwright

## When to Use
When editing Medium articles programmatically using Playwright browser automation.

## Critical Rules

### NEVER Do These
1. **NEVER use backspace to clean up text** — Medium's contenteditable cascades deletions unpredictably
2. **NEVER rely on undo** — Medium's undo buffer is finite (~10-15 operations); old actions fall off permanently
3. **NEVER paste raw markdown/HTML source** — Medium renders it as literal text, not formatted content
4. **NEVER use JavaScript DOM manipulation** — Causes "Something is wrong and we cannot save your story" errors
5. **NEVER use triple-click + backspace to delete fragments** — Can cascade-delete entire sections unexpectedly
6. **NEVER use `fill()` method for URLs** — Can split/fragment URLs unpredictably; use `type()` instead

### ALWAYS Do These
1. **Keep source HTML open** — Always have `article_rendered.html` or equivalent in a separate tab for recovery
2. **Use triple-click + retype** — To replace a paragraph: triple-click to select all, then type replacement
3. **Paste from rendered browser view** — Copy from rendered HTML in browser, not source code
4. **Embed gists on their own line** — Position cursor, Enter for new line, paste gist URL, Enter again
5. **Use the + menu for embeds** — Click the + button that appears on empty lines, then select embed option

## Gist Embedding Workflow

### Requirements (from Medium Help Center)
- Gist must be **Public** (not Secret)
- URL must start with `https://` or `http://`
- URL must be on its **own line** with no other text
- Use the main gist URL format: `https://gist.github.com/username/hash`

### Method 1: Paste and Enter (Preferred)
1. Position cursor at end of paragraph before where gist should appear
2. Press Enter to create new empty paragraph
3. Paste the gist URL (just the URL, nothing else on the line)
4. Press Enter — Medium auto-converts to embedded iframe
5. Verify the gist renders with syntax highlighting

### Method 2: Use the + Menu (More Reliable)
1. Click on an empty paragraph to see the + button appear on left
2. Click the + button to open embed menu
3. Select the embed/link option (chain link icon or "</>" icon)
4. Paste the gist URL in the embed dialog
5. Press Enter or click embed button
6. Gist converts to iframe with syntax highlighting

### If Gist Doesn't Embed
- Ensure URL is on its own line (no other text before or after)
- Verify gist is Public, not Secret
- Try: delete the line completely, create fresh paragraph, paste again
- Check that URL is the main gist URL, not raw/blob/file variant
- Try Method 2 (+ menu) if Method 1 fails

### Replacing Existing Code Blocks with Gists

**CRITICAL: This is a high-risk operation. Follow these steps exactly.**

1. **Before touching anything:**
   - Ensure source HTML is open in another tab
   - Screenshot the current article state
   - Identify the exact code block to replace

2. **Safe replacement workflow:**
   - Click at the END of the paragraph BEFORE the code block
   - Press Enter to create a new line
   - Paste the gist URL on this new empty line
   - Press Enter to embed the gist
   - Verify gist renders correctly
   - ONLY THEN delete the old code block

3. **To delete the old code block:**
   - Click inside the code block
   - Use Cmd/Ctrl+A to select all text within the block (NOT the whole article)
   - Press Delete once (this removes the code block content)
   - If an empty code block remains, click it and press Delete/Backspace once
   - **STOP** — do not press multiple times

4. **If something goes wrong:**
   - DO NOT try to undo repeatedly
   - Immediately switch to source HTML tab
   - Copy missing content from rendered view
   - Paste back into Medium

## Recovery Procedures

### If Content Was Deleted
1. Do NOT try to undo repeatedly — you'll exhaust the buffer
2. Switch to the source HTML tab
3. Copy the missing section from rendered HTML
4. Return to Medium, position cursor at insertion point
5. Paste — Medium preserves formatting from rendered HTML

### If Paste Shows Raw Markdown
Medium pasted source instead of rendered content:
1. Triple-click to select the malformed paragraph
2. Delete it (just pressing Delete/Backspace once on selection is safe)
3. Go to rendered HTML in browser
4. Select and copy the formatted content
5. Paste into Medium

## Medium-Specific Behaviors

### Selection
- Triple-click selects entire paragraph
- Shift+click can behave unpredictably in code blocks
- Meta+A in code blocks may select entire article

### Code Blocks
- Medium's native code blocks don't support syntax highlighting
- Gist embeds are preferred for code examples
- Code blocks render markdown literally (no formatting)

### Lists
- Type `• ` (bullet + space) and Medium auto-converts to list on Enter
- Numbered lists: type `1. ` and Medium converts

## Failure Modes to Watch For

| Symptom | Cause | Fix |
|---------|-------|-----|
| Text disappears on backspace | Cascade delete | Recover from source HTML |
| Undo does nothing | Buffer exhausted | Recover from source HTML |
| Gist shows as link | URL not on own line | Delete, new paragraph, repaste |
| Markdown renders literally | Pasted source, not rendered | Re-copy from browser view |
| Selection grabs too much | Code block selection quirk | Click outside, reposition |

## Pre-Flight Checklist

Before starting a Medium editing session:
- [ ] Source HTML file open in separate browser tab
- [ ] Gist URLs documented in worklog
- [ ] Recent backup of article (export or screenshot)
- [ ] Understand exactly what changes need to be made before touching editor
