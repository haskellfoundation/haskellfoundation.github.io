# Social cross-posting draft generator

Prints ready-to-copy-paste drafts of a news item for each external channel
(Discourse, Reddit, Twitter/X, LinkedIn, Mastodon, haskell-cafe). It only prints
text — there is no posting, no API keys, no bot behavior.

It's a second executable in the root `haskell-foundation.cabal` (not a
separate package): it re-parses the news item's front matter + first
paragraph directly with `pandoc`, the same library `site.hs` already uses,
rather than re-implementing Markdown/YAML parsing or standing up a second
build.

## Usage

```bash
cabal run social-draft -- news/2026-07-18/hiw-hew-2026-videos.markdown
# or, equivalently, by slug:
cabal run social-draft -- hiw-hew-2026-videos
```

Run from the repo root. Output is grouped under `=== Channel ===` headers;
copy each block into the corresponding channel by hand.

## Known rough edges (first draft)

- Hashtags are a single fixed set (`#haskell #haskellfoundation`) applied to
  every microblog; not yet varied per channel or per topic.
- Twitter/Mastodon trimming cuts the blurb with an ellipsis to fit the char
  budget (280 / 500); the reported char count is a slight overestimate when
  the blurb is dropped entirely, so it will never come in over budget.
- The canonical URL is the item's `link` front-matter field if present
  (link-out news items), otherwise `https://haskell.foundation/<route>.html`
  mirroring `site.hs`'s route for that item — it isn't computed from the
  actual Hakyll build.

## Channels to serve

Forums:
- Haskell Discourse
- The Haskell subreddit (r/haskell)

Microblogs:
- Twitter (X)
- LinkedIn
- Mastodon

Mailing list:
- haskell-cafe

## Analysis — why not one "post everywhere" script

The channels split into three tiers by how automatable they *should* be,
which differs from how automatable they *can* be:

- **Easy + appropriate**: Mastodon (trivial API, access token), Discourse
  (clean REST API + key; HF already announces there), haskell-cafe (just
  SMTP email — but a plain-text list with etiquette; a visibly automated
  blast reads poorly).
- **Possible but painful/costly**: Twitter/X (write API is now paid,
  ~$100+/mo basic tier), LinkedIn (API needs app review + org-page
  permissions, slow and awkward to maintain).
- **Possible but socially risky**: Reddit (auto-posted self-links look
  spammy, trip spam filters, cut against community norms).

A single "post everywhere" script concentrates the worst APIs, adds
key-management + maintenance burden, and risks damaging automated posts to
community spaces where tone matters. Rejected.
