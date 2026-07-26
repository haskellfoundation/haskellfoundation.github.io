# Tailwind / Node toolchain

This directory holds the **Node build tooling** for the site's CSS, kept
separate from the Hakyll project at the repo root so the two build systems
don't get tangled (`node_modules/` no longer sits next to the Haskell source,
and Hakyll's `ignoreFile` just skips all of `tools/`).

It contains only *build config* — `package.json`, `package-lock.json`, and
`postcss.config.js`. The CSS itself stays where Hakyll routes it from:

- `assets/css/tailwind.css` — Tailwind v4 entry point (`@theme`, `@source`,
  `@plugin`). New pages using Tailwind classes must add an `@source` line here.
- `assets/css/tailwind.built.css` — this toolchain's output, checked in and
  served as `assets/css/tailwind.css`.
- `assets/css/main.css` — hand-written, non-Tailwind CSS.

## Usage

Run npm **from this directory**:

```bash
npm ci             # install the toolchain (once)
npm run build      # compile -> ../../assets/css/tailwind.built.css
npm run watch      # same, then recompile on source/content changes
```

Pair `npm run watch` with `<stack exec --|cabal run> site -- watch`: postcss
writes the built CSS, Hakyll copies it into `_site` and reloads. Note that
`--watch` only ever *adds* utilities, so finish with a one-shot `npm run build`
before committing (see [../../CONTRIBUTING.md](../../CONTRIBUTING.md)).

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

## Why the output is checked in

`assets/css/tailwind.built.css` is a generated file in version control, which is
a deliberate trade: contributors without a Node toolchain can build and preview
the site with the real CSS, and nothing has to run npm at deploy time. The
price is that it *is* the deployed stylesheet, so it must not go stale — CI
recompiles it on every push and PR and fails on any difference.

There is no minified variant: cssnano saved ~800 bytes gzipped, which is not
worth a single-line file that cannot be diffed or merged.
