---
name: resume
description: Restore work context from a handoff file saved by another machine
user-invocable: true
allowed-tools: Bash, Read, Write
---

The user just switched to this machine and wants to restore the work context from the previous machine.

**Recovery priority:**
1. Current `handoff.md` has content → show it directly
2. File is empty or cleared (contains `# restored`) → auto-fallback to the most recent handoff entry in git history, shown with note "(from history)"
3. No git history either → tell the user no record was found

## Task

1. Get the real current time first — do not rely on system-provided dates:
   ```bash
   date "+%Y-%m-%d %H:%M:%S %Z"
   ```
   Use this timestamp for all time-based judgments (deadlines, how many days ago, etc.).

2. Pull latest content (if `~/.claude` is a git repo):
   ```bash
   if git -C ~/.claude rev-parse --git-dir > /dev/null 2>&1; then
     cd ~/.claude && git pull 2>/dev/null
   fi
   ```

3. Read `~/.claude/handoff.md`

4. If the file does not exist, is empty, or only contains `# restored`, fall back to git history:
   ```bash
   git -C ~/.claude log --oneline -- handoff.md 2>/dev/null | grep "handoff: save" | head -1 | awk '{print $1}'
   ```
   Use the resulting commit hash to retrieve the content:
   ```bash
   git -C ~/.claude show {commit_hash}:handoff.md 2>/dev/null
   ```
   - If content is found, display it normally but append **(from history)** after the snapshot title
   - If git history has nothing either, tell the user: "No handoff record found. The other machine may not have run `/handoff` yet."

5. If the file exists and has content, present it to the user:

   **Last session snapshot ({updated time})**

   Show each section. Use the real timestamp from step 1 to accurately evaluate any time references in the snapshot (past/future/how many days away). Then ask:
   "Want to pick up from 'Next steps', or is there something else on your mind?"

6. After restoring, clear the handoff file to avoid stale data on next `/resume`:
   ```bash
   echo "# restored" > ~/.claude/handoff.md
   if git -C ~/.claude rev-parse --git-dir > /dev/null 2>&1; then
     cd ~/.claude && git add handoff.md && git commit -m "resume: clear handoff" && git push 2>/dev/null
   fi
   ```
