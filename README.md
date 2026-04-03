# claude-context-sync

Custom Claude Code skills by [@maca0229](https://github.com/maca0229).

## Install

Paste this into your Claude Code input box:

```
! curl -fsSL https://raw.githubusercontent.com/maca0229/claude-context-sync/main/install.sh | bash
```

Then restart Claude Code.

---

## Skills

### `/handoff` + `/resume` — Never lose context again

Run `/handoff` before closing a session. Run `/resume` when you come back. Works across:

- **Switching machines** — pick up on another device exactly where you left off
- **Shutdown and reboot** — resume the next day without re-explaining the whole project
- **New conversation windows** — start a fresh chat that already knows what you were doing

**`/handoff`** — Claude summarizes your current work state into a snapshot and syncs it automatically (if `~/.claude` is a git repo).

**`/resume`** — Claude pulls the latest snapshot and tells you exactly where you left off. If the snapshot was already cleared, it automatically retrieves the most recent entry from git history.

**Works best with** `~/.claude` synced via git (e.g. to a private GitHub repo). Without git, the snapshot is saved locally at `~/.claude/handoff.md` and can be manually transferred.

