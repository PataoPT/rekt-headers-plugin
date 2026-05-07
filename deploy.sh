#!/bin/bash
# deploy.sh — sync SKILL.md from this repo into all Claude Desktop session caches
#
# Run manually:   ./deploy.sh
# Runs automatically via git hook after: git pull / git merge
#
# This is the "Option A" deployment step:
#   merge PR on GitHub → git pull → hook runs deploy.sh → restart Claude → done

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_SRC="$REPO_DIR/skills/rekt-headers/SKILL.md"
SESSION_BASE="$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"

if [ ! -f "$SKILL_SRC" ]; then
  echo "[error] SKILL.md not found at: $SKILL_SRC"
  exit 1
fi

echo "=== rekt-headers deploy ==="
echo "Source: $SKILL_SRC"
echo ""

# Find all rekt-headers SKILL.md copies in the session cache (handles any IDs)
TARGETS=$(find "$SESSION_BASE" -path "*/skills/rekt-headers/SKILL.md" 2>/dev/null)

if [ -z "$TARGETS" ]; then
  echo "[warn] No session cache targets found under:"
  echo "       $SESSION_BASE"
  echo ""
  echo "       This is normal if the plugin hasn't been installed yet."
  echo "       Install the plugin in Claude Desktop, then run deploy.sh again."
  exit 0
fi

COUNT=0
while IFS= read -r target; do
  cp "$SKILL_SRC" "$target"
  echo "[ok] Updated: $target"
  COUNT=$((COUNT + 1))
done <<< "$TARGETS"

echo ""
echo "=== Deployed to $COUNT location(s) ==="
echo ""
echo "Restart Claude Desktop / Cowork to pick up the changes."
