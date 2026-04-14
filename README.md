# rekt-headers

A Claude Code / Cowork plugin that generates header images for rekt.news articles.

Give it an article (URL, Google Doc, or pasted text) and it produces 10 B&W editorial art concepts in the rekt.news visual style, then generates all 10 images via AI (Gemini Pro Image).

## Quick Start

```bash
# 1. Clone or copy this folder
# 2. Run setup (installs uvx, pre-downloads the image server)
./setup.sh

# 3. Set your Gemini API key (free at https://aistudio.google.com/apikey)
export GEMINI_API_KEY="your-key-here"

# 4. Restart Claude Code / Cowork
# 5. Use it
```

Then just say: **"Generate rekt headers for this article"** and paste/link the article.

## What It Does

1. Reads and analyzes the article's narrative, irony, and tension
2. Generates 10 diverse image prompts across multiple B&W styles (vintage photography, ink wash, crosshatch, manga, pixel art, surrealist)
3. Calls Gemini Pro Image to produce all 10 at 1K 16:9 resolution
4. Recommends top 3 picks

## Requirements

| Requirement | How |
|-------------|-----|
| Claude Code or Cowork | Either works |
| Gemini API key | Free at [aistudio.google.com/apikey](https://aistudio.google.com/apikey) |
| `uvx` (Python package runner) | `setup.sh` installs it automatically |

## Setup Details

The `setup.sh` script handles everything:
- Installs `uv`/`uvx` if not present
- Pre-downloads the `nanobanana-mcp-server` (image generation)
- Writes `.mcp.json` with the correct `uvx` path for your machine

The only manual step is setting `GEMINI_API_KEY` in your environment. Add it to `~/.zshrc` or `~/.bashrc` to persist across sessions:

```bash
echo 'export GEMINI_API_KEY="your-key-here"' >> ~/.zshrc
```

## File Structure

```
rekt-headers-plugin/
  .claude-plugin/plugin.json   — Plugin metadata
  .mcp.json                    — MCP server config (nanobanana)
  manifest.json                — Skill registry
  skills/rekt-headers/SKILL.md — The skill itself
  setup.sh                     — One-time setup script
  README.md                    — This file
```

## Troubleshooting

**nanobanana tools don't appear after restart**
- Run `setup.sh` again — it fixes the `uvx` path
- Check that `GEMINI_API_KEY` is exported in your shell (not just set in a file)

**"uvx not found"**
- Run: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- Then: `source ~/.zshrc` (or restart terminal)

**Images have color / text / wrong style**
- The skill prompt enforces B&W. If Gemini drifts, re-run — results vary per generation.
