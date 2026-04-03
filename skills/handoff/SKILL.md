---
name: handoff
description: Save current work context to a file and sync it, so another machine can restore it with /resume
user-invocable: true
argument-hint: [optional note]
allowed-tools: Bash, Read, Write, Edit
---

The user is about to switch to another machine and wants to save the current work context.

## Task

Summarize the current conversation's work state into a structured snapshot, write it to `~/.claude/handoff.md`, then attempt to push to remote.

## Snapshot Format

Write the following structure (use the same language as the conversation):

```markdown
---
updated: {current datetime, format YYYY-MM-DD HH:mm}
note: {$ARGUMENTS if provided}
---

## What I'm working on

{1-3 sentences describing the current task and its stage}

## Progress

{bullet list of completed and pending steps, using ✓ and ○}

## Key context

{Important info the Claude on the other machine needs: file paths, decisions made, caveats}

## Next steps

{Up to 3 items — what to do first after resuming}
```

## After writing

Run the following to attempt sync (skip if `~/.claude` is not a git repo):

```bash
if git -C ~/.claude rev-parse --git-dir > /dev/null 2>&1; then
  cd ~/.claude && git add handoff.md && git commit -m "handoff: save session context" && git push 2>/dev/null && echo "Pushed to remote."
else
  echo "~/.claude is not a git repo. Handoff saved locally at ~/.claude/handoff.md — transfer it manually to the other machine."
fi
```

Tell the user the snapshot is saved and they can run `/resume` on the other machine to restore it.
