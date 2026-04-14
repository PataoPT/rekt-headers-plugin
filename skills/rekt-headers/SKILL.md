---
name: rekt-headers
description: >
  Generate AND create actual header images for rekt.news articles. Use this skill whenever the user needs to create
  header art for a rekt.news article, wants image prompts in the rekt.news visual style, or wants to generate
  images for investigative crypto journalism. Trigger on any mention of "rekt", "rekt.news", "rekt header",
  "article header image", or requests for dark noir-style crypto/DeFi article artwork. Also trigger if the user
  asks for image prompts for investigative crypto journalism pieces, even if they don't name rekt.news specifically.
  This skill generates 10 prompts AND automatically calls the Gemini API to produce all 10 images at 1K 16:9.
---

# Rekt News Header Image Generator

You generate image prompts for rekt.news article headers AND immediately call the Gemini API to produce the actual images at 1K resolution in 16:9 format. Your job is to deeply understand the article's narrative, identify its core irony or tension, translate that into striking visual concepts that match the rekt.news brand, and then generate all 10 images without stopping to ask for permission.

## The rekt.news Visual Identity

rekt.news is an investigative journalism publication covering crypto exploits, hacks, fraud, and systemic failures. The header images are a critical part of the storytelling — they set the tone before a single word is read.

### Absolute Rules

- **Black and white only.** No color. No neon. No gradients. Pure B&W with high contrast. This is non-negotiable.
- **No text in the image.** The rekt logo gets added separately. Never include titles, labels, captions, or watermarks in the prompt.
- **No literal crypto imagery.** No Bitcoin logos, no blockchain diagrams, no trading charts, no token symbols. The imagery is metaphorical and narrative, never literal.
- **Widescreen aspect ratio.** All headers are 16:9 landscape format. This is enforced both in the prompt text and via the API config.

### Visual Styles in the Repertoire

rekt.news headers draw from a diverse range of B&W visual languages. Each article gets whichever style best serves its story. The key styles are:

**Painterly Illustration** — Loose, gestural B&W brushwork. Expressive, not precise. Think ink wash or oil sketch. Often used for character-driven pieces. Examples: a snarling wolf in a business suit, a suited figure at a laptop with coins raining down, a rocket splitting apart in the void.

**Vintage Archival Photography** — Real or realistic B&W photographs from the mid-20th century (1930s–1970s). Documentary, institutional, Cold War-era. Heavy film grain. Often combined with digital manipulation — especially pixelated/censored faces (a signature technique). Examples: men in fedoras at a stock exchange board, a lone operator at a nuclear control room console, a suited man at a desk with his face pixelated out.

**Fine Line Illustration / Crosshatch** — Detailed, precise B&W artwork with hatching and crosshatching. Cinematic and noir-influenced. Dramatic lighting, deep shadows, fine grain. Examples: a car hanging off a cliff edge with headlights beaming into void, a silhouetted detective before a blackboard of equations, a torn-paper split dividing two realities.

**Surrealist / Theatrical** — References to early cinema (Méliès), vaudeville, the uncanny. Symbolic objects in impossible arrangements. Slightly horrifying. Examples: a cracked moon face pierced by candles radiating light, surrealist collage, objects with human features.

**Retro Pixel / 8-bit** — Game Boy-era pixel art aesthetic. Pure B&W pixels, no grays. Used sparingly for stories about protocol failures or systematic breakdowns. Examples: a brick wall exploding with coin stacks, a glitchy game-over screen.

**Manga / Graphic Impact** — High-contrast graphic compositions with radiating speed/impact lines. Bold shapes, maximum visual force. Examples: pills or objects mid-explosion with radiating lines, fists or stamps mid-impact.

### Recurring Motifs and Techniques

These appear across styles and are part of the visual vocabulary:

- **Pixelated/censored faces** — Figures whose faces are digitally obscured. Used for stories about hidden identity, anonymous actors, opaque ownership. This is one of the most distinctive rekt.news techniques.
- **Animal heads on human bodies** — Wolves, foxes, cats in suits. Surrealist substitution for predatory or deceptive actors.
- **Vast institutional spaces with lone figures** — Control rooms, boardrooms, registries, vaults. One person dwarfed by the system they operate. Conveys both power and fragility.
- **Objects in the void** — A single dramatic object (rocket, car, stamp, document) floating or hurtling through pure black space. Isolation and inevitability.
- **Torn paper / split reality** — The image literally torn diagonally, dark on one side, white on the other. Two realities coexisting.
- **Dramatic scale mismatch** — Tiny figures against enormous structures, stamps, or documents. Kafkaesque bureaucratic horror.
- **Film grain and texture overlays** — Halftone dots, scanline artifacts, analog grain. Never clean digital renders.

### Tone and Mood

The emotional register is: **ominous, knowing, darkly ironic, cinematic.** These images don't scream — they unsettle. There's usually a single central concept or visual metaphor. Compositions are bold and simple — one strong idea, executed with conviction. Avoid clutter, avoid busy scenes with too many elements competing for attention.

The images often carry a sense of inevitability — like the viewer is looking at a disaster that has already happened, or is about to happen, and nobody noticed.

## How to Generate Prompts

### Step 1: Read the Article

Understand the story deeply. Identify:
- **The core irony or tension** — What's the central absurdity or failure? (e.g., "the identity company couldn't verify its own identity")
- **The key actors** — Who are the villains, victims, bystanders? Are they anonymous?
- **The mechanism of failure** — Was it a breach, a rug pull, a governance failure, negligence?
- **The emotional register** — Is this darkly funny? Infuriating? Tragic? Bureaucratic horror?

### Step 2: Generate 10 Diverse Concepts

Each prompt should be a different visual concept — not variations on the same idea. Aim for diversity across:
- **Style** — Use at least 3-4 different visual styles from the repertoire above
- **Metaphor** — Each prompt should use a different metaphorical angle on the story
- **Composition** — Mix close-ups, wide shots, object studies, character portraits, environmental scenes
- **Mood** — Some more ominous, some more ironic, some more surreal

### Step 3: Write the Prompts

Each prompt should be a single paragraph, 2-4 sentences. Include:
1. **Style direction** — Which visual language (e.g., "Loose painterly B&W illustration" or "Vintage archival photograph, 1960s")
2. **Scene description** — What's in the image, composed how
3. **Key details** — Specific elements that sell the concept (the pixelated face, the empty badge, the torn document)
4. **Texture/finish** — Film grain, halftone, brushwork, crosshatching — whatever fits the style
5. **Format note** — Always include "widescreen 16:9 landscape" in the prompt text

Keep prompts concrete and visual. Don't explain the metaphor — just describe what the image looks like. The viewer should feel the meaning without having it spelled out.

### Prompt Format

Give each prompt a short, evocative title (2-4 words), then the prompt text as a blockquote. After all 10, recommend your top 3 picks with a brief note on why they're strongest for this particular article.

### What to Avoid

- Color of any kind (including "muted" or "desaturated" color — it's B&W or nothing)
- Photorealistic modern renders or 3D CGI aesthetics
- Literal depictions of blockchain, tokens, or trading interfaces
- Busy, cluttered compositions with too many competing elements
- Stock photo aesthetic — clean, corporate, generic
- Any text, logos, labels, or UI elements in the image
- Cliche hacker imagery (hoodies, green terminals, Matrix rain)
- Overly explained metaphors — if you need to explain it, the image isn't working

---

## Step 4: Generate the Actual Images via MCP

After presenting all 10 prompts and top 3 picks, **immediately generate all 10 images** using the `nanobanana` MCP tool — no permission needed, no setup required.

### How to Generate

For each of the 10 prompts, call the `generate_image` MCP tool with these parameters:

- **prompt**: The full prompt text from Step 3
- **aspect_ratio**: `"16:9"`
- **resolution**: `"1k"`
- **model_tier**: `"pro"` (best quality for editorial art)
- **negative_prompt**: `"color, text, labels, watermarks, logos, blockchain diagrams, Bitcoin logos, trading charts, neon, gradients, 3D CGI, stock photo, hooded hacker, Matrix rain, green terminal"`
- **enable_grounding**: `false` (these are artistic/metaphorical, not factual)

Example tool call for one prompt:

```
generate_image(
  prompt="Vintage archival photograph, 1960s. A row of men in dark suits sit at a long boardroom table, all facing forward, all with faces fully pixelated into unrecognizable blocks. Heavy film grain, widescreen 16:9 landscape.",
  aspect_ratio="16:9",
  resolution="1k",
  model_tier="pro",
  negative_prompt="color, text, labels, watermarks, logos, blockchain, Bitcoin, trading charts, neon, gradients, 3D, stock photo",
  enable_grounding=false
)
```

Generate all 10 images in parallel (batch of 5 + batch of 5) for speed. The MCP server handles API keys, model selection, and file saving automatically.

### After Generating

- Show each returned image to the user as it completes.
- Lead with the top 3 picks at the top of the final summary.
- If any failed: show the error and offer to retry with an adjusted prompt.
- Report the output file paths so the user can access all generated images.
