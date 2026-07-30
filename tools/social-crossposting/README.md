# Social cross-posting draft generator

Prints ready-to-copy-paste drafts of a news item for each external channel
(Discourse, Reddit, Twitter/X, LinkedIn, Mastodon, haskell-cafe, Haskell
Weekly). It only prints text — there is no posting, no API keys, no bot
behavior.

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

Run from the repo root. Each channel gets a colour-coded header stating its
kind (forum / microblog / mailing list / newsletter), its format and length
constraint, **which account to post from**, and a clickable link to the
channel.

Below the header come the draft's sections — `title`, `link`, `post`, `body`,
… — each an indented dim label on its own line, then the text itself at
column 0 with blank lines around it. So a line- or block-select grabs exactly
what you paste and never a label: everything indented or coloured is chrome,
including the microblog character count, which sits in the `post` label
rather than in the post.

## Which account

The header's `account` line says who should post:

- **Haskell Foundation account** — the HF owns this channel. Currently
  Twitter/X ([@haskellfound](https://twitter.com/haskellfound)) and Mastodon
  ([@haskell_foundation](https://mastodon.social/@haskell_foundation)).
- **your PRIVATE account / email / GitHub account** — no HF identity here;
  post from your own account (Discourse, Reddit), send from your own address
  (haskell-cafe), or open the pull request yourself (Haskell Weekly).
- **HF or private? — unconfirmed** — LinkedIn; not yet decided, check before
  posting.

## Colour and links

Two disjoint colour families keep the roles distinct: each channel's chrome
uses a muted, cool hue, while the `account` flag uses saturated traffic-light
colours (green = HF/safe, yellow = unconfirmed, red = your private identity).

Colour and clickable links are emitted only when writing to an interactive
terminal, so piping to a file or pager gives clean plain text. Colour also
honours the standard `NO_COLOR` environment variable.

## Known rough edges (first draft)

- Hashtags are a single fixed set (`#haskell #haskellfoundation`) applied to
  every microblog; not yet varied per channel or per topic.
- Twitter/Mastodon trimming cuts the blurb with an ellipsis to fit the char
  budget (280 / 500). Only the blurb is ever trimmed, so a title long enough
  to blow the budget on its own comes out over — visibly, since the reported
  count is exact (`301/280`).
- Only a whole-post limit is enforced; Reddit's title limit is displayed as
  advice, not checked.
- The Haskell Weekly entry credits the `author` front matter field verbatim,
  including any role ("Bryan Richter, DevOps Engineer") — the newsletter's own
  style is bare names, so trim it when it reads oddly. Without an `author`
  field it credits the HF for a site article, and prints a `??` placeholder
  for a link-out (whoever wrote the linked post isn't recorded in the front
  matter).
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

Newsletter:
- [Haskell Weekly](https://github.com/haskellweekly/haskellweekly) — curated
  in Git, so an entry is a pull request adding one Markdown list item to the
  issue being assembled (`data/newsletter/<year>/issue-NNN.markdown`). Its
  editors sort entries into the issue's sections.

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

Haskell Weekly is the one channel where automation is an option: a pull request
is reviewed by its editors before anything is published. If it ever becomes
routine, opening that pull request could be automated (`gh pr create` against
the current issue file).
