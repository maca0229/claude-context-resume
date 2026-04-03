---
name: resume
description: Restore work context from a handoff file saved by another machine
user-invocable: true
allowed-tools: Bash, Read, Write
---

The user just switched to this machine and wants to restore the work context from the previous machine.

## Task

1. Attempt to pull latest content (if `~/.claude` is a git repo):
   ```bash
   if git -C ~/.claude rev-parse --git-dir > /dev/null 2>&1; then
     cd ~/.claude && git pull 2>/dev/null
   fi
   ```

2. Read `~/.claude/handoff.md`

3. If the file doesn't exist, is empty, or only contains `# restored`, tell the user:
   "No handoff record found. The other machine may not have run `/handoff` yet."

4. If the file exists and has content, present it to the user:

   **Last session snapshot ({updated time})**

   Show each section, then ask:
   "Want to pick up from 'Next steps', or is there something else on your mind?"

5. After restoring, clear the handoff file to avoid stale data on next `/resume`:
   ```bash
   echo "# restored" > ~/.claude/handoff.md
   if git -C ~/.claude rev-parse --git-dir > /dev/null 2>&1; then
     cd ~/.claude && git add handoff.md && git commit -m "resume: clear handoff" && git push 2>/dev/null
   fi
   ```
