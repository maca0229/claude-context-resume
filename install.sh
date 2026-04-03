#!/bin/bash
# Install maca-claude-skills into ~/.claude/skills/

set -e

REPO="https://github.com/maca0229/claude-context-resume"
SKILLS_DIR="$HOME/.claude/skills"
TMP_DIR=$(mktemp -d)

echo "Downloading skills from $REPO..."
git clone --depth=1 --quiet "$REPO" "$TMP_DIR"

mkdir -p "$SKILLS_DIR"

for skill in "$TMP_DIR/skills"/*/; do
  name=$(basename "$skill")
  dest="$SKILLS_DIR/$name"
  if [ -d "$dest" ]; then
    echo "Updating: $name"
  else
    echo "Installing: $name"
  fi
  cp -r "$skill" "$dest"
done

# Add session files to .gitignore if ~/.claude is a git repo
if git -C "$HOME/.claude" rev-parse --git-dir > /dev/null 2>&1; then
  GITIGNORE="$HOME/.claude/.gitignore"
  if ! grep -q "projects/\*\*/\*.jsonl" "$GITIGNORE" 2>/dev/null; then
    echo "projects/**/*.jsonl" >> "$GITIGNORE"
    git -C "$HOME/.claude" add .gitignore
    git -C "$HOME/.claude" commit -m "chore: ignore session jsonl files" --quiet 2>/dev/null || true
    echo "Added session files to .gitignore"
  fi
fi

rm -rf "$TMP_DIR"
echo "Done! Restart Claude Code to use the new skills."

