# Tailwind / Node toolchain

This directory holds the **Node build tooling** for the site's CSS, kept
separate from the Hakyll project at the repo root so the two build systems
don't get tangled (`node_modules/` no longer sits next to the Haskell source,
and Hakyll's `ignoreFile` just skips all of `tools/`).

It contains only *build config* — `package.json`, `package-lock.json`, and
`postcss.config.js`. The CSS **sources** stay where Hakyll routes them from:

- `assets/css/tailwind.css` — Tailwind v4 entry point (`@theme`, `@source`,
  `@plugin`). New pages using Tailwind classes must add an `@source` line here.
- `assets/css/main.css` — hand-written, non-Tailwind CSS.

## Usage

Run npm **from this directory**:

```bash
npm ci                      # install the toolchain (once)
npm run build               # dev build   -> ../../_site/assets/css/tailwind.css
npm run build:production     # minified    -> ../../_site/assets/css/tailwind.css (NODE_ENV=production)
npm run build:dev-snapshot   # regenerate  -> ../../dev.css  (the Node-less preview snapshot)
```

## Why the scripts `cd ../..`

Two Tailwind v4 constraints force the build to run from the **repo root**, not
from here:

1. **`@source` scanning only reaches files at or below the working directory.**
   The site content (`templates/`, `who-we-are/`, …) lives at the repo root, so
   postcss must run there or the compiled CSS comes out nearly empty (utilities
   silently missing). The npm scripts therefore `cd ../..` first.
2. **`@import "tailwindcss"` resolves `node_modules` by walking up from the CSS
   file.** Because `node_modules` now lives here — not an ancestor of
   `assets/css/tailwind.css` — that file's `@import`/`@plugin` instead point at
   `../../tools/tailwind/node_modules/...` via relative paths. (The
   `@tailwindcss/postcss` `base` option looks like it should decouple these but
   breaks `@source` scanning in v4.2.4, so relative paths it is.)

The `--config tools/tailwind` flag points postcss back here for
`postcss.config.js` after the `cd`.

## dev.css

`dev.css` (at the repo root) is a checked-in snapshot of `npm run build` that
`site.hs` concatenates onto `tailwind.css` so contributors without Node can
still preview the site. CI fails if it drifts; regenerate it with
`npm run build:dev-snapshot` and commit.
