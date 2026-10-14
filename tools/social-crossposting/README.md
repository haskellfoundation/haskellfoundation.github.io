# Social cross-posting drafts

`social-draft` takes a news item and prints a draft post for each channel we
announce news on. You copy each draft and post it by hand. The tool never
posts anything itself and needs no API keys.

It is a second executable in `haskell-foundation.cabal`. It reads the news
item with `pandoc`, the library `site.hs` uses, so the blurb is the same
first paragraph the site shows in its link previews.

## Usage

Run it from the repo root, with the path to a news item or just its slug:

```bash
cabal run social-draft -- news/2026-07-18/hiw-hew-2026-videos.markdown
cabal run social-draft -- hiw-hew-2026-videos
```

Each channel starts with a header. It names the kind of channel, the format
and length limit, the account to post from, and links to where you post.

Then come the parts of the draft, such as `title`, `link`, `post` or `body`.
Each part has a dim, indented label, followed by the text itself. Copy the
text and leave the label: anything indented or coloured is not part of the
draft. The character count of a microblog post is in its label, too.

## Channels and accounts

Watch the `account` line. Green means the Haskell Foundation account, red
means your own.

| Channel | Post as |
|---|---|
| [Discourse](https://discourse.haskell.org/c/haskell-foundation) | yourself |
| [r/haskell](https://www.reddit.com/r/haskell/) | yourself |
| [Twitter/X](https://twitter.com/haskellfound) | Haskell Foundation |
| [LinkedIn](https://www.linkedin.com/company/haskell-foundation-inc) | Haskell Foundation |
| [Mastodon](https://mastodon.social/@haskell_foundation) | Haskell Foundation |
| haskell-cafe mailing list | yourself, from your own email address |
| [Haskell Weekly](https://github.com/haskellweekly/haskellweekly) | yourself, as a pull request |

Haskell Weekly lives in a Git repository. To suggest an entry, open a pull
request that adds one list item to the issue being put together
(`data/newsletter/<year>/issue-NNN.markdown`). The editors decide where it
goes, and they only want important news.

## Colour and links

Colour and clickable links only appear in a terminal. Pipe the output to a
file or a pager and you get plain text. Set `NO_COLOR` to turn colour off.

## Limitations

- Every microblog gets the same hashtags, `#haskell #haskellfoundation`.
- On Twitter/X (280) and Mastodon (500), the tool shortens the blurb to fit,
  counting the link as 23 characters like both sites do. It never shortens
  the title, so a very long title can still go over. The count then shows
  it, for example `301/280`.
- Reddit allows at most 300 characters in a title. The tool shows the limit
  but does not check it.
- The Haskell Weekly entry names the `author` field as written, including a
  role like "Bryan Richter, DevOps Engineer". The newsletter uses plain
  names, so shorten it if needed. With no `author`, a site article is
  credited to the Haskell Foundation. A link to someone else's post gets a
  `??` instead, because the news item does not say who wrote it.
- The link is the item's `link` field if it has one. Otherwise the tool
  builds `https://haskell.foundation/<path>.html` the same way `site.hs`
  routes news items, without running the site build.

## Why the tool doesn't post for you

We decided against one script that posts everywhere:

- Mastodon and Discourse have simple APIs. haskell-cafe is plain email, but
  people on a mailing list notice an automated post, and it reads badly.
- Twitter/X charges for posting through its API (about $100 a month).
  LinkedIn needs an app review and permissions for the company page.
- On Reddit, automated posts linking to your own site look like spam and
  get caught by spam filters.

So such a script would mean API keys to manage, two awkward APIs to keep
working, and posts that sound like a bot in places where tone matters.

Haskell Weekly is the exception, since its editors review every pull
request. If we suggest entries often, the tool could open the pull request
itself with `gh pr create`.
