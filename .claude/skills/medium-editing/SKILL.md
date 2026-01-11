# Skill: Medium Article Editing via Playwright

## When to Use
When editing Medium articles programmatically using Playwright browser automation.

## Critical Rules

### NEVER Do These
1. **NEVER use backspace to clean up text** — Medium's contenteditable cascades deletions unpredictably
2. **NEVER rely on undo** — Medium's undo buffer is finite (~10-15 operations); old actions fall off permanently
3. **NEVER paste raw markdown/HTML source** — Medium renders it as literal text, not formatted content

### ALWAYS Do These
1. **Keep source HTML open** — Always have `article_rendered.html` or equivalent in a separate tab for recovery
2. **Use triple-click + retype** — To replace a paragraph: triple-click to select all, then type replacement
3. **Paste from rendered browser view** — Copy from rendered HTML in browser, not source code
4. **Embed gists on their own line** — Position cursor, Enter for new line, paste gist URL, Enter again

## Gist Embedding Workflow

### Preparation
1. Create gist files with proper markdown formatting
2. Push to GitHub Gist
3. Copy the gist URL (e.g., `https://gist.github.com/username/hash`)

### In Medium
1. Click at end of paragraph before where gist should appear
2. Press Enter to create new paragraph
3. Paste the gist URL (just the URL, nothing else)
4. Press Enter — Medium auto-embeds as iframe
5. Verify the gist renders with proper formatting

### If Gist Doesn't Embed
- Ensure URL is on its own line (no other text)
- Try: delete the line, create fresh paragraph, paste again
- Check that URL is the main gist URL, not raw/blob variant

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
