<p align="center">
<img src="https://haskell.foundation/assets/images/logos/hf-logo-alpha.png" width="350" height="282" alt="Haskell Foundation" title="Haskell Foundation">
</p>

# The Haskell Foundation Website

[![Hackage](https://img.shields.io/static/v1?label=Haskell%20Foundation&message=official&color=purple&style=for-the-badge)](https://haskell.foundation)

This repository is for the [haskell.foundation](https://haskell.foundation) website. It is a proud, Hakyll-based site, built as an in-kind contribution from [Obsidian Systems](https://obsidian.systems), and maintained by the Haskell Foundation and its volunteers. If you would like to get started with a merge request, please consult the documentation below.

## Table Of Contents

- [The Haskell Foundation Website](#the-haskell-foundation-website)
  - [Table Of Contents](#table-of-contents)
  - [Building](#building)
  - [Styling (CSS / Tailwind)](#styling-css--tailwind)
  - [CI](#ci)
  - [License](#license)

## Building

The site can be built with either [Stack](https://docs.haskellstack.org) or
[Cabal](https://www.haskell.org/cabal/) — use whichever you prefer.

To build the project:

```bash
stack build   # with Stack
cabal build   # with Cabal
```

Once the project has built (which can take a while due to the dependencies for Hakyll), generate the site with:

```bash
stack exec -- site build   # with Stack
cabal run site -- build    # with Cabal
```

and for development (a server that rebuilds on change):

```bash
stack exec -- site watch   # with Stack
cabal run site -- watch    # with Cabal
```

The site will be built in the `_site` directory, and you can open the files in your browser of choice. Due to a Hakyll issue, some sponsor logos will not show up correctly. This is expected behavior, and should be fine for the deployed site.

For further information, please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) at the root of this project.

## Styling (CSS / Tailwind)

The site is styled with [Tailwind CSS](https://tailwindcss.com) (v4). Tailwind is a CSS framework whose classes are short abbreviations for inline styles (e.g. `pt-4`, `text-center`), scattered directly across the HTML templates and content. At build time the Tailwind compiler acts as a kind of "CSS tree-shaker": it scans the site for the Tailwind classes actually in use and emits only the CSS needed for them.

Two files matter:

- `assets/css/tailwind.css` — the Tailwind entry point. It holds the v4 CSS-native configuration (`@theme` colors/fonts, `@plugin`, and the `@source` lines that tell the compiler which directories to scan). **New pages that use Tailwind classes must add an `@source` line here**, or those classes will be dropped from the production build.
- `assets/css/main.css` — hand-written CSS that is *not* processed by Tailwind. This is the place for ordinary, non-Tailwind styles.

### Do I need Node installed?

**No, if you are only editing content or Haskell code.** Hakyll concatenates a checked-in snapshot, `dev.css`, onto `assets/css/tailwind.css` at build time (see the `match "assets/css/tailwind.css"` rule in `site.hs`). `dev.css` is a pre-generated copy of the real Tailwind output, so `stack exec -- site build` on its own produces a site that looks close enough to preview — no Node toolchain required. This keeps the site accessible to contributors of all skill sets.

**Yes, if you are changing the appearance.** Because `dev.css` is only a snapshot, it does *not* reflect edits to `assets/css/tailwind.css`, `assets/css/main.css`, `postcss.config.js`, or any *newly used* Tailwind class. To regenerate the real CSS you need [Node.js](https://nodejs.org):

```bash
npm ci                     # once, to install the toolchain
npm run build              # compile -> _site/assets/css/tailwind.css
npm run build:production   # minified build (NODE_ENV=production)
```

If you do not want to install `npm` globally and have `nix` available, drop into
the Nix development shell which provides `npm` and a basic Haskell toolchain.

If your change alters the CSS, regenerate the checked-in `dev.css` snapshot and
commit it:

```bash
npm run build:dev-snapshot   # recompile the dev.css snapshot in place
```

CI runs this same command and fails the build if the committed `dev.css` is out
of date, so a stale snapshot cannot slip through review.

> **Note:** `dev.css` is only an *unminified* snapshot of `npm run build`; it still differs from the minified `npm run build:production` output shipped to production, so verify appearance-critical changes against a real production build.

## CI

We use GitHub Actions `.github/workflows/main.yml` to build the site for production.

The general steps are:

1. Check out the `hakyll` branch
2. Install Haskell and Node.js
3. Restore the cached build artefacts
4. Build the `site` executable
5. Rebuild the site contents using the `site` executable
6. Build the production CSS (`npm ci && npm run build:production`)
7. Check out the `main` branch
8. Copy the `_site` directory over the `main` branch contents
9. Commit and push the site contents to the `main` branch.

Steps 7–9 (the deploy) run only on non-PR pushes to `hakyll`; pull requests build and stop after step 6.

## License

This site is open source, and covered under the Apache 2.0 license.
