#!/bin/bash
# Install maca-claude-skills into ~/.claude/skills/

set -e

REPO="https://github.com/maca0229/claude-context-sync"
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

rm -rf "$TMP_DIR"
echo "Done! Restart Claude Code to use the new skills."
