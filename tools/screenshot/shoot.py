#!/usr/bin/env python3
"""Screenshot pages of the built site for visual review.

Needs the Nix dev shell, which provides python3 with playwright and the
browsers (`nix develop`, or automatically via direnv).

Start the two watchers once, then shoot as often as you like — postcss keeps
`assets/css/tailwind.built.css` current and Hakyll copies it into `_site`:

    cabal run site -- watch &                    # http://127.0.0.1:8000
    (cd tools/tailwind && npm run watch) &
    ./tools/screenshot/shoot.py /tmp/shots --slice 1100 home=/ news=/news/
    ./tools/screenshot/shoot.py /tmp/shots --width 390 --slice 900 mhome=/

For a one-shot look, build by hand and serve without recompiling:

    (cd tools/tailwind && npm run build) && cabal run site -- build
    cabal run site -- server &
    ./tools/screenshot/shoot.py /tmp/shots --slice 1100 home=/

Here you must repeat the first line after every template or CSS edit: `server`
only serves `_site`, it does not rebuild, so it will happily keep serving stale
pages (no need to restart it, though).

Either way the CSS is the real thing — but `npm run watch` only ever *adds*
utilities, so a class you deleted still has styles until the next one-shot
`npm run build`. If a removal seems not to take effect, that is why.

Targets are `name=path` (resolved against --base) or `name=full-url`:

    ./tools/screenshot/shoot.py out/ home=/ news=/news/
    ./tools/screenshot/shoot.py out/ --width 390 --slice 900 news=/news/

Without --slice one full-page PNG per target is written; with it the page is cut
into `--slice`-tall pieces (`name-00.png`, `name-01.png`, …), which keeps long
pages legible instead of downscaling them to nothing.
"""

import argparse
from playwright.sync_api import sync_playwright


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("outdir")
    ap.add_argument("targets", nargs="+", metavar="NAME=PATH")
    ap.add_argument("--base", default="http://127.0.0.1:8000",
                    help="server to resolve relative targets against (`cabal run site -- server`)")
    ap.add_argument("--width", type=int, default=1440)
    ap.add_argument("--slice", type=int, default=0, help="cut into pieces of this height")
    ap.add_argument("--settle", type=int, default=1500, help="ms to wait after load")
    args = ap.parse_args()

    targets = [(name, url if "://" in url else args.base.rstrip("/") + "/" + url.lstrip("/"))
               for name, url in (t.split("=", 1) for t in args.targets)]
    viewport = {"width": args.width, "height": args.slice or 1000}

    with sync_playwright() as pw:
        browser = pw.chromium.launch()
        for name, url in targets:
            page = browser.new_page(viewport=viewport)
            page.goto(url, wait_until="load")
            page.wait_for_timeout(args.settle)
            height = page.evaluate("document.documentElement.scrollHeight")
            if args.slice:
                for i, top in enumerate(range(0, height, args.slice)):
                    page.screenshot(
                        path=f"{args.outdir}/{name}-{i:02d}.png",
                        full_page=True,
                        clip={"x": 0, "y": top, "width": args.width,
                              "height": min(args.slice, height - top)},
                    )
            else:
                page.screenshot(path=f"{args.outdir}/{name}.png", full_page=True)
            print(f"{name}: {args.width}x{height}")
            page.close()
        browser.close()


if __name__ == "__main__":
    main()
