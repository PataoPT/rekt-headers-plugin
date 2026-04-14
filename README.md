# rekt-headers

A plugin for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and [Cowork](https://claude.ai/cowork) that generates header images for rekt.news articles.

Give it an article — a URL, a Google Doc link, or pasted text — and it produces 10 black-and-white editorial art concepts in the rekt.news visual style, then generates all 10 images using AI (Gemini Pro Image). No Photoshop, no manual prompting, no design skills needed.

## Quick Start

### 1. Clone this repo

```bash
git clone https://github.com/PataoPT/rekt-headers-plugin.git
cd rekt-headers-plugin
```

### 2. Run the setup script

```bash
./setup.sh
```

This does three things automatically:
- Installs `uvx` (a Python package runner) if you don't have it
- Downloads the image generation server (`nanobanana-mcp-server`) so the first run is fast
- Writes the correct configuration for your machine

### 3. Get a Gemini API key

The plugin uses Google's Gemini Pro Image model to generate images. You need a free API key:

1. Go to [aistudio.google.com/apikey](https://aistudio.google.com/apikey)
2. Click "Create API Key" (no credit card required, generous free tier)
3. Copy the key

### 4. Set the API key in your environment

**Option A — one-time (current terminal session only):**
```bash
export GEMINI_API_KEY="your-key-here"
```

**Option B — persistent (recommended, survives terminal restarts):**
```bash
echo 'export GEMINI_API_KEY="your-key-here"' >> ~/.zshrc
source ~/.zshrc
```

> If you use bash instead of zsh, replace `~/.zshrc` with `~/.bashrc`.

### 5. Restart Claude Code or Cowork

The plugin's MCP server (nanobanana) only starts when Claude Code or Cowork launches. After setting everything up, restart whichever client you use so it picks up the new configuration.

### 6. Use it

Open a conversation and say something like:

- **"Generate rekt headers for this article"** + paste or link the article
- **"Create header images for this rekt.news piece"** + a Google Doc URL
- Just mention **"rekt header"** or **"rekt.news"** in the context of needing images

The plugin will read the article, generate 10 diverse prompts, produce all 10 images, and recommend the top 3.

## What It Does

1. **Reads the article** — understands the narrative, identifies the core irony or tension
2. **Generates 10 diverse image prompts** — across multiple B&W styles: vintage archival photography, ink wash, fine-line crosshatch, manga/graphic impact, pixel art, surrealist/theatrical
3. **Produces all 10 images** — calls Gemini Pro Image at 1K resolution in 16:9 widescreen format
4. **Recommends top 3 picks** — with brief notes on why they work for this specific article

All images follow the rekt.news visual rules: black and white only, no text, no literal crypto imagery, metaphorical and cinematic.

## Requirements

| Requirement | How to get it |
|-------------|---------------|
| **Claude Code or Cowork** | Either client works — [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code), Cowork desktop app, or Claude Code IDE extensions |
| **Gemini API key** | Free at [aistudio.google.com/apikey](https://aistudio.google.com/apikey) — no credit card needed |
| **`uvx`** (Python package runner) | `setup.sh` installs it automatically. If you already have `uv` installed, you're good |

## File Structure

```
rekt-headers-plugin/
  .claude-plugin/plugin.json   — Plugin identity and version
  .mcp.json                    — MCP server config (tells Claude how to start nanobanana)
  manifest.json                — Skill registry (lists the rekt-headers skill)
  skills/rekt-headers/SKILL.md — The skill definition (prompt engineering + generation instructions)
  setup.sh                     — One-time setup script
  README.md                    — This file
```

## Troubleshooting

**nanobanana tools don't appear after restart**
- Run `./setup.sh` again — it re-detects the `uvx` path and rewrites the config
- Make sure `GEMINI_API_KEY` is actually exported in your shell, not just written to a file. Run `echo $GEMINI_API_KEY` to check — if it prints nothing, run `source ~/.zshrc` first
- Try restarting Claude Code / Cowork one more time after confirming the above

**"uvx not found"**
- The setup script should handle this, but if it didn't:
  ```bash
  curl -LsSf https://astral.sh/uv/install.sh | sh
  source ~/.zshrc   # or restart your terminal
  ```
- Then run `./setup.sh` again

**Images have color, text, or wrong style**
- The skill prompt enforces strict B&W with no text. Occasionally Gemini drifts — just re-run and results will vary. This is inherent to generative image models.

**Setup script says "permission denied"**
- Make it executable: `chmod +x setup.sh`
