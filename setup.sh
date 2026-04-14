#!/bin/bash
# rekt-headers plugin — one-time setup
# Run this once: ./setup.sh
set -e

echo "=== rekt-headers plugin setup ==="
echo ""

# 1. Check/install uv (provides uvx)
if command -v uvx &>/dev/null; then
  echo "[ok] uvx found at $(which uvx)"
elif [ -f "$HOME/.local/bin/uvx" ]; then
  echo "[ok] uvx found at $HOME/.local/bin/uvx"
else
  echo "[installing] uv + uvx..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  echo "[ok] uv installed at $HOME/.local/bin/uvx"
fi

# Determine uvx path
if command -v uvx &>/dev/null; then
  UVX_PATH=$(which uvx)
elif [ -f "$HOME/.local/bin/uvx" ]; then
  UVX_PATH="$HOME/.local/bin/uvx"
else
  echo "[error] uvx not found after install. Add ~/.local/bin to your PATH and retry."
  exit 1
fi

# 2. Check for Gemini API key
if [ -z "$GEMINI_API_KEY" ]; then
  echo ""
  echo "[action needed] Set your Gemini API key:"
  echo "  export GEMINI_API_KEY='your-key-here'"
  echo ""
  echo "  Get a free key at: https://aistudio.google.com/apikey"
  echo ""
  echo "  Add it to your shell profile (~/.zshrc or ~/.bashrc) to persist:"
  echo "  echo 'export GEMINI_API_KEY=\"your-key-here\"' >> ~/.zshrc"
  echo ""
else
  echo "[ok] GEMINI_API_KEY is set"
fi

# 3. Pre-download the nanobanana server (so first run is fast)
echo ""
echo "[prefetch] Downloading nanobanana-mcp-server..."
"$UVX_PATH" nanobanana-mcp-server@latest --help &>/dev/null 2>&1 || true
echo "[ok] nanobanana-mcp-server cached"

# 4. Write the .mcp.json with the correct uvx path
PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"
cat > "$PLUGIN_DIR/.mcp.json" <<MCPEOF
{
  "mcpServers": {
    "nanobanana": {
      "command": "$UVX_PATH",
      "args": ["nanobanana-mcp-server@latest"],
      "env": {
        "GEMINI_API_KEY": "\${GEMINI_API_KEY}"
      }
    }
  }
}
MCPEOF
echo "[ok] .mcp.json written with uvx at: $UVX_PATH"

echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Make sure GEMINI_API_KEY is set in your environment"
echo "  2. Restart Claude Code / Cowork"
echo "  3. Say: /rekt-headers  (or just ask for a rekt.news header)"
echo ""
