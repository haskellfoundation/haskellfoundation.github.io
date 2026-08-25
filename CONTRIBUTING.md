# Contributors Guide

## Table Of Contents

- [Bug Reports](#bug-reports)
- [Documentation](#documentation)
- [Style Guide](#style-guide)
- [Code](#code)
- [Building the site](#building-the-site)
- [Styling (CSS / Tailwind)](#styling-css--tailwind)
- [CI](#ci)
- [Code Quality](#code-quality)

## Bug Reports

Please [open an issue](https://github.com/haskellfoundation/haskellfoundation.github.io/issues/new) if you have a bug to report.

The more detailed your report, the faster it can be resolved and will ensure it is resolved in the right way. We appreciate when people not only open issues, but attempt to resolve them on their own by submitting a pull request. We are always open to constructive feedback.

## Documentation

Expansions to the documentation are welcome, and appreciated. Every contribution counts.

## Style Guide

We seek to adhere to the [SIGPLAN Proceedings Format](https://www.sigplan.org/Resources/ProceedingsFormat/).

### Titles and headings

Titles (page titles, news/blog post titles, etc.) and headings (e.g., section headings) should use [AP Title Case](https://titlecaseconverter.com/rules/#AP):

- Capitalize the first word and the last word of the title
- Capitalize the principal words
- Capitalize to in infinitives
- Capitalize all words of four letters or more
- Do not capitalize articles, conjunctions, and prepositions of three letters or fewer

Example: "How the Haskell Foundation Works With Affiliates".

When in doubt, run the title through the [Title Case Converter](https://titlecaseconverter.com/) with the "AP" style selected.

## Code

If you would like to contribute code to fix a bug, add a new feature, or otherwise improve this site, pull requests are most welcome. It's a good idea to [submit an issue](https://github.com/haskellfoundation/haskellfoundation.github.io/issues/new) to discuss the change before plowing into writing code.

> **Note:** Development happens on the `hakyll` branch. The `main` branch holds only the built site and is overwritten by CI.

## Building the site

The site can be built with either [Stack](https://docs.haskellstack.org) or [Cabal](https://www.haskell.org/cabal/) — use whichever you prefer.

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

## Styling (CSS / Tailwind)

The site is styled with [Tailwind CSS](https://tailwindcss.com) (v4). Tailwind is a CSS framework whose classes are short abbreviations for inline styles (e.g. `pt-4`, `text-center`), scattered directly across the HTML templates and content. At build time the Tailwind compiler acts as a kind of "CSS tree-shaker": it scans the site for the Tailwind classes actually in use and emits only the CSS needed for them.

Three files matter:

- `assets/css/tailwind.css` — the Tailwind entry point. It holds the v4 CSS-native configuration (`@theme` colors/fonts, `@plugin`, and the `@source` lines that tell the compiler which directories to scan). **New pages that use Tailwind classes must add an `@source` line here**, or those classes will be dropped from the build. This file is compiler *input*; it is never served.
- `assets/css/tailwind.built.css` — the compiler's output, **checked into the repository** and served as `assets/css/tailwind.css`. This is the CSS the live site loads, so it must be regenerated and committed whenever it changes (see below).
- `assets/css/main.css` — hand-written CSS that is *not* processed by Tailwind. This is the place for ordinary, non-Tailwind styles.

### Do I need Node installed?

**No, if you are only editing content or Haskell code.** Hakyll copies the checked-in `assets/css/tailwind.built.css` into the site, so `stack exec -- site build` alone gives you the real stylesheet — no Node toolchain required. This keeps the site accessible to contributors of all skill sets.

**Yes, if you are changing the appearance** — that is, editing `assets/css/tailwind.css`, `assets/css/main.css`, `tools/tailwind/postcss.config.js`, or *using a Tailwind class the site did not use before* (Tailwind only emits the classes it finds, so a brand-new class has no CSS until the compiler runs). You will need [Node.js](https://nodejs.org). The toolchain lives in [`tools/tailwind/`](tools/tailwind/) (see its README), separate from the Hakyll project, so run npm from there:

```bash
cd tools/tailwind
npm ci            # once, to install the toolchain
npm run build     # compile -> assets/css/tailwind.built.css
npm run watch     # same, then recompile on source/content changes
```

If you do not want to install `npm` globally and have `nix` available, `nix develop` drops you into a shell with `npm` and the Haskell toolchain, including every dependency of the site generator prebuilt — so `cabal build` compiles only `site.hs` instead of spending half an hour on Pandoc. `nix build` alone gives you the `site` executable without a shell.

**Commit the regenerated `assets/css/tailwind.built.css` with your change.** CI reruns `npm run build` on every push and PR and fails if the committed copy has drifted, so a stale stylesheet cannot reach the live site.

### Live preview

Run both watchers and the two chain into each other — postcss writes `assets/css/tailwind.built.css`, which Hakyll then copies into `_site` and reloads:

```bash
cabal run site -- watch &            # or: stack exec -- site watch
cd tools/tailwind && npm run watch
```

> **Note:** `npm run watch` is *additive* — it picks up newly used classes, but a class you removed keeps its CSS until the next one-shot `npm run build`. So finish with `npm run build` before committing, or CI's check will complain about the leftovers.

## CI

We use GitHub Actions `.github/workflows/main.yml` to build the site for production.

The general steps are:

1. Check out the `hakyll` branch
2. Install Haskell and Node.js
3. Restore the cached build artefacts
4. Build the `site` executable
5. Rebuild the site contents using the `site` executable (this copies the checked-in CSS into `_site`)
6. Recompile the CSS (`cd tools/tailwind && npm ci && npm run build`) and fail if the committed `assets/css/tailwind.built.css` has drifted
7. Check out the `main` branch
8. Copy the `_site` directory over the `main` branch contents
9. Commit and push the site contents to the `main` branch.

Steps 7–9 (the deploy) run only on non-PR pushes to `hakyll`; pull requests build and stop after step 6.

## Code Quality

The `haskell.foundation` website intends to focus on integration and usability, balanced with maintainability.

We strive to be an example of best practices for real Haskell. If you believe there is a better way to do something in the code, please let us know or submit a PR for review. We would like the HF website to be a clear example of how to do a Hakyll website right.
