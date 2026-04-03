# maca-claude-skills

Custom Claude Code skills by [@maca0229](https://github.com/maca0229).

## Install

Paste this into your Claude Code input box:

```
! curl -fsSL https://raw.githubusercontent.com/maca0229/maca-claude-skills/main/install.sh | bash
```

Then restart Claude Code.

---

## Skills

### `/handoff` + `/resume` — Cross-device context sync

Switch between machines without losing your work context.

**`/handoff`** — Run before switching machines. Claude summarizes your current work state into a snapshot and syncs it automatically (if `~/.claude` is a git repo).

**`/resume`** — Run after switching machines. Claude pulls the latest snapshot and tells you exactly where you left off.

**Works best with** `~/.claude` synced via git (e.g. to a private GitHub repo). Without git, the snapshot is saved locally at `~/.claude/handoff.md` and can be manually transferred.
