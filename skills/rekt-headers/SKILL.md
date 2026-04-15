---
name: rekt-headers
description: >
  Generate AND create actual header images for rekt.news articles. Full pipeline: read the article
  (auto-fetches Google Docs via the Drive connector — no copy-paste needed), draft 10 on-brand prompts
  in the real rekt visual language, generate all 10 images via Gemini (nanobanana MCP) at 16:9 1K, then
  upload them to the team's Drive folder via browser automation. Trigger on any mention of "rekt",
  "rekt.news", "rekt header", "article header image", or requests for dark noir-style crypto/DeFi
  article artwork. Also trigger on image-prompt requests for investigative crypto journalism even when
  the user doesn't say "rekt" explicitly.
---

# Rekt News Header Image Generator

Generate rekt.news article headers end-to-end: **fetch article → draft 10 prompts → generate 10 images → upload to Drive**. Do the full pipeline without asking for permission between steps.

## The rekt.news Visual Identity

rekt.news is investigative crypto journalism covering exploits, hacks, fraud, and systemic failure. The header carries the sarcasm, the inevitability, and the funeral tone before the reader hits a single word.

The style is **grounded in real observed headers** from the `RektHQ/Assets` public repo. The rules below come from studying the actual archive, not from what "dark crypto art" generically looks like.

### Hard Rules (non-negotiable)

1. **Monochrome / greyscale.** Deep blacks dominate. Near-pure B&W is the default, but subtle grey tones and occasional faint chromatic aberration on glitched edges are acceptable. **Never** saturated color, neon, gradients, or tinted palettes.
2. **No literal crypto imagery.** No Bitcoin logos, no blockchain diagrams, no trading charts, no token glyphs, no candlesticks, no Ethereum polyhedrons. Imagery is metaphorical and narrative, never literal.
3. **Leave the bottom-left corner visually clean.** The rekt frog logo is composited there post-generation. Heavy detail in that corner gets cropped or obscured.
4. **Widescreen 16:9 landscape.** Enforced both in the prompt text and the API config.
5. **No text, no captions, no watermarks, no UI.** Exception: occasional stencil-style single-word labels (white tape, typewriter) are part of the style but should NOT be attempted by the model — we leave any typography to the editorial pass.
6. **No cliché hacker imagery.** No hoodies, no green terminals, no Matrix rain, no balaclava-over-laptop.

### The Six Archetypes (pick from these, don't invent new ones)

Every rekt header in the archive fits into one of these. At least 3 of the 10 generated concepts should cover 3 different archetypes — don't stack all ten in one bucket.

**1. Central Object on Black Void** — The single most common layout. One symbolic object, rendered with sharp lighting or ink detail, floating in near-total blackness. Examples from the archive: an 8-ball on a pool table (`8ight`), a leaking bucket (`bancorlp`), a crossed horseshoe with needles through it (`horsesushi`), a bullet hole in a concrete wall (`moola`), a LEGO grim reaper (`dego`), an anatomical bull skeleton (`mango`). The object is almost always a **visual pun on the protocol name** or a dead-simple funerary symbol.

**2. Repurposed Classic Cinema Frame** — A still or stylistic recreation of a recognizable B&W film moment, recontextualized for the story. Examples: 1940s film-noir lineup (`anyswap` → *The Usual Suspects*), the James Bond gun-barrel opening (`bondly`), shadowed men pursuing across a metal-chain foreground (`chainswap`), a lone figure in a tunnel with a clock-face (`meter`), a figure descending a stairwell drawn from a Hitchcock frame (`ascendex`). When the protocol or the incident has a natural cinematic analogue — heist, conspiracy, double-cross, slow-motion collapse — use this archetype.

**3. Painterly / Ink-Sketch Character Portrait** — Loose, gestural black-ink brushwork over rough texture and halftone. Often an animal-as-villain or a symbolic anonymous figure. Examples: a snarling doberman-like creature rendered in thick black ink splashes (`1inch`), a masked figure with a laptop surrounded by Bitcoin coins rendered through a torn-plastic overlay (`DMM`). Heavy paper grain, visible brushwork, charcoal scratching. Faces often obscured or abstracted.

**4. Pixelated / Censored Face** — Documentary photograph, face digitally obscured with a blocky pixel mosaic. Reserved for named individuals — the *we know who this is but we can't say it* gesture. Canonical example: the SBF portrait (`sbfreg`), a front-facing B&W photograph of curly-haired shoulders-up, face turned into a blunt pixel grid. Use sparingly — this is the sharpest-edged weapon in the toolkit.

**5. Bare Logo / Brand Marker on Void** — The protocol's own logo rendered in white on pure black, spotlit and alone. Minimal, funerary. Examples: the Celsius logo (`celsius`), the BNB chain logomark (`binance`). Use when the story is about the brand's collapse as a whole, not a specific mechanism — when the name itself is the epitaph.

**6. Grid / Tiled Repetition** — A single motif multiplied across the frame in a regular pattern, often chessboard-alternating black and white cells. Examples: a hand clutching a key tiled across a chessboard (`OKX-DEX`, the Judas kiss). Use when the story is about betrayal, duplication, systemic rot — anything that repeats.

### Supplementary Visual Moves (use as accent, not as the main concept)

- **Shattered glass** with faint RGB chromatic fringing at fracture edges (`Lifi`) — for sudden breakage / finality.
- **Black-hole vortex** rendered in rough ink and crumpled-paper texture (`LSC-FSL`) — for value disappearing.
- **Lone figure dwarfed by infrastructure** — tunnels, stairwells, industrial machinery, cathedral voids.
- **Film grain, halftone dots, paper-fold creases, scratches, scanline artifacts** — texture overlays on almost every header. Never a clean digital surface.

### Tone

Always funereal, always after-the-fact. The disaster has already happened and the image is the autopsy photo. Darkly knowing, not melodramatic. One strong concept per frame — never cluttered, never busy, never hedged.

### Explicit Anti-Patterns (will NOT pass as rekt)

- Color of any kind (saturated, tinted, color grading)
- Photorealistic modern renders, 3D CGI, Unreal Engine look
- Literal blockchain / token / chart / UI imagery
- Cluttered compositions, multiple competing subjects
- Stock-photo aesthetic, LinkedIn-banner vibe
- Hoodies, green terminals, Matrix rain, balaclavas
- Cyberpunk neon cities
- AI-slop "intricate detailed masterpiece" default styling
- Text, logos, labels, UI chrome (beyond the occasional white-tape stencil motif that we do NOT ask the model for)
- Heavy detail in the bottom-left corner (reserved for the rekt logo composite)

---

## Workflow

### Step 1 — Read the Article

**If the URL is a Google Doc** (`docs.google.com/document/d/...`), extract the doc ID and call `mcp__c1fc4002-5f49-5f9d-a4e5-93c4ef5d6a75__google_drive_fetch` with `document_ids: ["<id>"]`. Do **not** ask the user to paste — the Drive connector handles auth.

**If WebFetch returns 401 on a Drive URL**, fall back to the Drive connector before asking the user anything.

**If the URL is a public article** (Notion, the published rekt site, Substack, etc.), use `WebFetch`.

**If no URL is given**, ask the user for one. Don't make up an article.

From the article, identify in one internal pass:

- **Protocol name** — is it a pun? (horse+sushi → horseshoe, 8ight → 8-ball, etc.) This unlocks Archetype #1.
- **Cinematic analogue** — heist, lineup, double-cross, car-over-cliff, vault? This unlocks Archetype #2.
- **Core irony / tension** — what did they claim vs. what happened? The image should sit on the irony.
- **Key actors** — anonymous, named-and-censored, animal-archetype?
- **Mechanism of failure** — sudden (shatter), slow (sinking), systemic (grid), symbolic (broken object)?
- **Emotional register** — darkly funny, bureaucratic horror, tragic, inevitable?

### Step 2 — Draft 10 Diverse Concepts

Distribute across archetypes. A healthy 10-prompt set typically looks like:

- 3–4 × Archetype #1 (Central Object on Void) — each a different object/pun
- 2 × Archetype #2 (Cinema Frame) — each a different film reference
- 1–2 × Archetype #3 (Painterly Portrait)
- 0–1 × Archetype #4 (Pixelated Face) — only if there's a named individual to anonymize
- 0–1 × Archetype #5 (Logo on Void) — only if the story is about brand-level collapse
- 0–1 × Archetype #6 (Grid Repetition) — only if the theme is betrayal/duplication

Do not stack 10 variations of the same idea. Each prompt should feel like it could headline a different article about the same event.

### Step 3 — Write the Prompts

Each prompt: a single paragraph, 2–4 sentences. Include, in order:

1. **Archetype + style direction** — name the visual language explicitly (e.g., "Central object on pure black void, rendered in sharp directional lighting and heavy film grain" or "1940s film-noir B&W photograph recreation")
2. **Scene / subject** — the one thing the frame is about
3. **Key compositional detail** — where it sits, what lights it, what's behind it
4. **Texture / finish** — film grain, halftone dots, rough paper, ink wash, scratches, paper creases
5. **Always include**: "widescreen 16:9 landscape", "greyscale / near-black-and-white", and "bottom-left corner kept clean and uncluttered for logo placement"

Format for presentation: short evocative title (2–4 words), then the prompt as a blockquote. After all 10, recommend top 3 picks with one-line reasoning each, grounded in which archetype they pull from and why it fits the story.

### Step 4 — Generate the Images

Call `mcp__plugin_rekt-headers_nanobanana__generate_image` for each of the 10 prompts with:

- `prompt`: full prompt text from Step 3
- `model_tier`: `"pro"`
- `aspect_ratio`: `"16:9"`
- `resolution`: `"1k"`
- `negative_prompt`: `"color, saturation, text, captions, logos, watermarks, UI elements, charts, blockchain imagery, tokens, hoodies, green terminals, Matrix rain, balaclava, 3D render, CGI, cyberpunk neon, clutter, busy composition"`

Run them in parallel batches of 5 (two tool-call blocks). Collect the saved file paths.

Do **not** ask for permission between steps 3 and 4. The contract of this skill is end-to-end.

### Step 5 — Upload to the Rekt Drive Folder

**Primary target (Google Drive for Desktop synced path):**
`/Users/diogopatao/Library/CloudStorage/GoogleDrive-diogo@stake.capital/O meu disco/Rekt Headers Images`

**Drive web URL (for reference / sharing):** `https://drive.google.com/drive/folders/110nGTMqPN2unaPYuQ6iernlQV9VBgc7Q`

The Google Drive connector (`google_drive_fetch` / `google_drive_search`) is read-only, so the upload goes through the filesystem instead. Try these in order:

**Path A — Local Drive-for-Desktop sync (preferred, fast, reliable):**

1. Derive an article slug from the article title: lowercased, hyphens for spaces, no special characters, max ~40 chars (e.g., `hyperbridge`, `curve-oracle-failure`, `bybit-lazarus-heist`).
2. Create a subfolder at `<primary-target>/<slug>/` via Bash `mkdir -p`.
3. Copy each generated image into that subfolder with a **descriptive, numbered filename**: `NN-concept-title-slug.png` (e.g., `01-the-punchline-arrives.png`). The NN prefix preserves generation order; the title-slug is the concept name from Step 3 (lowercased, hyphenated).
4. Verify with `ls -la` on the destination folder.
5. The Drive client syncs automatically — no API call needed. Mention in the final summary that the files are syncing and may take a few seconds to appear in the web UI.

**Path B — Chrome browser MCP (fallback if the Drive-for-Desktop path is unavailable):**

1. Load `Claude_in_Chrome` tool schemas via `ToolSearch` with `select:mcp__Claude_in_Chrome__tabs_context_mcp,mcp__Claude_in_Chrome__navigate,mcp__Claude_in_Chrome__find,mcp__Claude_in_Chrome__file_upload,mcp__Claude_in_Chrome__read_page`.
2. Open the Drive folder URL in a tab.
3. Use `find` to locate the hidden file input (`input[type="file"]`).
4. Call `file_upload` with the array of all 10 generated local paths.
5. Verify via `read_page`.

**Path C — `rclone` CLI (fallback if configured):**

Check `which rclone` via Bash. If present, run `rclone copy <image_paths> gdrive:<folder>` using a remote the user has already authenticated.

**Path D — Fall back gracefully:**

If none of the above work, report the generation results with local `computer://` links and tell the user plainly: *"I couldn't push to Drive automatically from this session — drop these files into the folder manually."* Do **not** fake the upload or claim it succeeded when it didn't.

### Step 6 — Present Results

- Lead with the top 3 picks at the top, each with its `computer://` link.
- Then the full 10, numbered in the order they were generated, each with its `computer://` link.
- State which upload path was used and the subfolder name (e.g., *"Synced to Drive → `Rekt Headers Images/hyperbridge/`, should appear in the web UI within seconds."*).
- If any generation failed, show the error and offer to retry with an adjusted prompt (don't silently skip).
- If the upload fell through to Path D, say so clearly — don't bury the failure.

---

## Quick Reference: the Archetype Cheatsheet

| # | Archetype | When it fits | Visual cue |
|---|-----------|--------------|------------|
| 1 | Object on Void | Protocol-name pun available, single symbolic failure | One object, spotlit, black background |
| 2 | Cinema Frame | Story has a heist/lineup/double-cross shape | Recognizable B&W movie still |
| 3 | Painterly Portrait | Animal-archetype villain, symbolic figure | Ink splashes, halftone, rough texture |
| 4 | Pixelated Face | Named individual to anonymize | Documentary photo, blocky pixel mosaic over face |
| 5 | Logo on Void | Brand-level collapse, name = epitaph | White logo, pure black, spotlit |
| 6 | Grid Repetition | Betrayal, duplication, systemic rot | Chessboard tiles of one motif |

Don't pick randomly — let the story pick the archetype.
