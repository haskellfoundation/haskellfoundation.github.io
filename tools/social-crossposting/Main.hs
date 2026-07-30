{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

{- | Draft generator for cross-posting a news item to social channels.

Reads a news item's front matter + first paragraph (the same source the
site itself uses for its OpenGraph description) and prints a ready-to-copy
draft per channel. It only prints text -- there is no posting, no API keys.
-}
module Main (main) where

import Control.Monad (filterM)
import Data.List (intercalate)
import Data.Maybe (fromMaybe, isNothing)
import qualified Data.Text as T
import System.Directory (doesFileExist, listDirectory)
import System.Environment (getArgs, lookupEnv)
import System.Exit (die)
import System.FilePath (dropExtension, (<.>), (</>))
import System.IO (hIsTerminalDevice, stdout)
import Text.Pandoc (
    Block (Para, Plain),
    Extension (Ext_yaml_metadata_block),
    Meta,
    Pandoc (..),
    ReaderOptions (readerExtensions),
    WrapOption (WrapNone),
    WriterOptions (writerWrapText),
    def,
    enableExtension,
    lookupMeta,
    nullMeta,
    pandocExtensions,
    readMarkdown,
    runPure,
    writePlain,
 )
import Text.Pandoc.Shared (stringify)

siteRoot :: String
siteRoot = "https://haskell.foundation"

-- | Hashtags to append; same set for every microblog for now (see the
-- "Hashtag set per channel" open question in the todo).
hashtags :: [T.Text]
hashtags = ["#haskell", "#haskellfoundation"]

data NewsItem = NewsItem
    { niTitle :: T.Text
    , niByline :: Byline
    , niBlurb :: T.Text
    -- ^ First paragraph, plain text.
    , niUrl :: T.Text
    -- ^ Canonical site URL, or the external `link` for a link-out item.
    }

{- | Who to credit, for the channels that name an author. A link-out item
(one with a `link` front matter field) points at somebody else's post, so
with no `author` field there is nobody we know to name: 'Unattributed' says
so loudly in the draft instead of crediting the HF for a post it didn't
write.
-}
data Byline
    = Named T.Text
    | HaskellFoundation
    | Unattributed

main :: IO ()
main = do
    args <- getArgs
    arg <- case args of
        [a] -> pure a
        _ -> die "usage: social-draft <path/to/news-item.markdown | slug>"
    path <- resolvePath arg
    item <- loadNewsItem path
    style <- detectStyle
    putStr (renderDrafts style item)

-- | Accept either a path to a markdown file or a bare slug, looked up under
-- every `news/YYYY-MM-DD/` directory.
resolvePath :: FilePath -> IO FilePath
resolvePath arg = do
    isFile <- doesFileExist arg
    if isFile
        then pure arg
        else do
            dates <- listDirectory "news"
            let candidates = [("news" </> d </> arg) <.> "markdown" | d <- dates]
            matches <- filterM doesFileExist candidates
            case matches of
                [m] -> pure m
                [] -> die ("no news item found for path or slug: " ++ arg)
                ms -> die ("ambiguous slug " ++ arg ++ ", matches: " ++ intercalate ", " ms)

loadNewsItem :: FilePath -> IO NewsItem
loadNewsItem path = do
    src <- T.pack <$> readFile path
    let readerOpts = def{readerExtensions = enableExtension Ext_yaml_metadata_block pandocExtensions}
    Pandoc meta blocks <- case runPure (readMarkdown readerOpts src) of
        Left err -> die (path ++ ": " ++ show err)
        Right doc -> pure doc
    title <- case metaText meta "title" of
        Just t -> pure t
        Nothing -> die (path ++ ": missing 'title' front matter")
    let linkOut = metaText meta "link"
        url = fromMaybe (T.pack (siteRoot </> dropExtension path <.> "html")) linkOut
        byline = case (metaText meta "author", linkOut) of
            (Just author, _) -> Named author
            (Nothing, Just _) -> Unattributed
            (Nothing, Nothing) -> HaskellFoundation
    pure NewsItem{niTitle = title, niByline = byline, niBlurb = plainFirstPara blocks, niUrl = url}

metaText :: Meta -> T.Text -> Maybe T.Text
metaText meta key = stringify <$> lookupMeta key meta

-- | Render a document's first paragraph as plain text. Mirrors
-- `firstPara`/`pandocPlainCompiler` in site.hs, minus the Hakyll `Item`/
-- `Compiler` plumbing that isn't available outside a site build.
plainFirstPara :: [Block] -> T.Text
plainFirstPara blocks = case runPure (writePlain plainOpts (Pandoc nullMeta (firstPara blocks))) of
    Left err -> error ("writePlain: " ++ show err)
    Right t -> T.strip t
  where
    -- WrapNone: keep the blurb on one line, not hard-wrapped at 72 cols,
    -- so it pastes cleanly into a microblog post.
    plainOpts = def{writerWrapText = WrapNone}
    firstPara [] = []
    firstPara (b@Para{} : _) = [b]
    firstPara (b@Plain{} : _) = [b]
    firstPara (_ : bs) = firstPara bs

-- CHANNELS -------------------------------------------------------------------

-- | Where a channel sits in the social landscape; sets the tone expected
-- there as much as the mechanics of posting.
data ChannelKind
    = Forum
    | Microblog
    | MailingList
    | Newsletter
    -- ^ Curated elsewhere: we propose an entry, its editors decide.

-- | The markup a channel renders.
data Format
    = Markdown
    | PlainText

-- | What bounds a channel's length. 'PostAtMost' is the only one the
-- generator enforces (via 'budgetedPost', which trims to the same number it
-- displays); the others are advisory, for the human writing the post.
data Length
    = Unlimited
    | PostAtMost Int
    | TitleAtMost Int

-- | Social norms that shape a draft but can't be checked mechanically.
data Etiquette
    = ListEtiquette
    -- ^ Plain-text list read by humans; a visibly automated blast reads badly.
    | ImportantNewsOnly
    -- ^ Curated by volunteers: propose the milestones, not every item.

-- | How a draft for this channel must be shaped. Shown next to the channel
-- kind in the header.
data Constraint = Constraint
    { conFormat :: Format
    , conLength :: Length
    , conEtiquette :: [Etiquette]
    }

-- | Which account/identity to post from. This is the main thing a human has
-- to get right, so each channel states it explicitly.
data PostAs
    = AsHF
    | AsPrivate
    | AsPrivateEmail
    | AsPrivateGitHub
    | AsUnknown

data Channel = Channel
    { chName :: T.Text
    , chKind :: ChannelKind
    , chConstraint :: Constraint
    , chUrl :: T.Text
    -- ^ Where to post; rendered as a clickable link.
    , chAccount :: PostAs
    , chColor :: Int
    -- ^ 256-colour foreground code for this channel's chrome. Drawn from a
    -- cool, muted palette that is disjoint from the saturated traffic-light
    -- colours 'accountText' uses, so channel hue never clashes with the
    -- "who posts this" flag.
    , chDraft :: NewsItem -> Draft
    }

channels :: [Channel]
channels = [discourse, reddit, twitterX, linkedIn, mastodon, haskellCafe, haskellWeekly]

discourse :: Channel
discourse =
    Channel
        { chName = "Discourse"
        , chKind = Forum
        , chConstraint = Constraint{conFormat = Markdown, conLength = Unlimited, conEtiquette = []}
        , chUrl = "https://discourse.haskell.org/c/haskell-foundation"
        , chAccount = AsPrivate
        , chColor = 74
        , chDraft = \NewsItem{niTitle, niBlurb, niUrl} ->
            [section "post" (T.unlines ["# " <> niTitle, "", niBlurb, "", niUrl])]
        }

reddit :: Channel
reddit =
    Channel
        { chName = "Reddit"
        , chKind = Forum
        , chConstraint = Constraint{conFormat = Markdown, conLength = TitleAtMost 300, conEtiquette = []}
        , chUrl = "https://www.reddit.com/r/haskell/"
        , chAccount = AsPrivate
        , chColor = 173
        , chDraft = \NewsItem{niTitle, niBlurb, niUrl} ->
            [ section "title" niTitle
            , section "link" niUrl
            , section "suggested first comment" niBlurb
            ]
        }

twitterX :: Channel
twitterX =
    Channel
        { chName = "Twitter/X"
        , chKind = Microblog
        , chConstraint = Constraint{conFormat = PlainText, conLength = PostAtMost limit, conEtiquette = []}
        , chUrl = "https://twitter.com/haskellfound"
        , chAccount = AsHF
        , chColor = 80
        , chDraft = \item -> [budgetedPost limit item]
        }
  where
    limit = 280

{- | LinkedIn's limit is high enough that a news draft never approaches it, so
the blurb runs in full and the link gets an introduction instead of a budget.
-}
linkedIn :: Channel
linkedIn =
    Channel
        { chName = "LinkedIn"
        , chKind = Microblog
        , chConstraint = Constraint{conFormat = PlainText, conLength = PostAtMost 3000, conEtiquette = []}
        , chUrl = "https://www.linkedin.com/company/haskell-foundation-inc"
        , chAccount = AsUnknown
        , chColor = 62
        , chDraft = \NewsItem{niTitle, niBlurb, niUrl} ->
            [ section
                "post"
                (T.unlines [niTitle, "", niBlurb, "", "Read more: " <> niUrl, "", T.unwords hashtags])
            ]
        }

mastodon :: Channel
mastodon =
    Channel
        { chName = "Mastodon"
        , chKind = Microblog
        , chConstraint = Constraint{conFormat = PlainText, conLength = PostAtMost limit, conEtiquette = []}
        , chUrl = "https://mastodon.social/@haskell_foundation"
        , chAccount = AsHF
        , chColor = 140
        , chDraft = \item -> [budgetedPost limit item]
        }
  where
    limit = 500

haskellCafe :: Channel
haskellCafe =
    Channel
        { chName = "haskell-cafe"
        , chKind = MailingList
        , chConstraint = Constraint{conFormat = PlainText, conLength = Unlimited, conEtiquette = [ListEtiquette]}
        , chUrl = "mailto:haskell-cafe@haskell.org"
        , chAccount = AsPrivateEmail
        , chColor = 66
        , chDraft = \NewsItem{niTitle, niBlurb, niUrl} ->
            [ section "subject" niTitle
            , section "body" (T.unlines [niBlurb, "", niUrl])
            ]
        }

{- | Haskell Weekly is curated in a Git repository, so an entry is a pull
request against the issue being assembled -- @issue-NNN.markdown@ under the
current year. Its editors sort entries into the issue's sections, so the
draft is just the one list item, in their established shape.
-}
haskellWeekly :: Channel
haskellWeekly =
    Channel
        { chName = "Haskell Weekly"
        , chKind = Newsletter
        , chConstraint = Constraint{conFormat = Markdown, conLength = Unlimited, conEtiquette = [ImportantNewsOnly]}
        , chUrl = "https://github.com/haskellweekly/haskellweekly/tree/main/data/newsletter"
        , chAccount = AsPrivateGitHub
        , chColor = 108
        , chDraft = \NewsItem{niTitle, niByline, niBlurb, niUrl} ->
            [ section
                "entry"
                ( T.unlines
                    [ "- [" <> niTitle <> "](" <> niUrl <> ") by " <> bylineText niByline
                    , "  > " <> niBlurb
                    ]
                )
            ]
        }
  where
    bylineText = \case
        Named author -> author
        HaskellFoundation -> "The Haskell Foundation"
        Unattributed -> "?? (fill in who wrote it)"

-- PRESENTATION -------------------------------------------------------------

{- | One block of a draft to copy as a whole. The label is chrome: it is
printed dim and indented, on its own line, while the block itself starts at
column 0 with blank lines around it -- so selecting by line or by block
grabs exactly the text to paste and nothing else.
-}
data Section = Section
    { secLabel :: T.Text
    , secBody :: T.Text
    }

type Draft = [Section]

section :: T.Text -> T.Text -> Section
section secLabel secBody = Section{secLabel, secBody}

-- | Terminal decoration switches, resolved once at startup. Colour and
-- clickable links are emitted only for an interactive terminal, so piping
-- to a file/pager yields clean plain text (the drafts stay copy-pasteable
-- either way -- decoration lives only in the chrome, never in a draft body).
data Style = Style
    { styColor :: Bool
    , styLinks :: Bool
    }

-- | Colour off when stdout is not a TTY or the standard @NO_COLOR@ env var is
-- set; links off when not a TTY.
detectStyle :: IO Style
detectStyle = do
    tty <- hIsTerminalDevice stdout
    noColor <- lookupEnv "NO_COLOR"
    pure Style{styColor = tty && isNothing noColor, styLinks = tty}

-- | Two blank lines between channels, so a channel's drafts read as one
-- group and the eye finds the next header without hunting.
renderDrafts :: Style -> NewsItem -> String
renderDrafts s item = T.unpack (T.intercalate "\n\n\n" (banner : map (renderChannel s item) channels) <> "\n")
  where
    banner =
        T.intercalate
            "\n"
            [ dim s "Social drafts for"
            , bold s (niTitle item)
            , link s (niUrl item) (dim s (niUrl item))
            ]

renderChannel :: Style -> NewsItem -> Channel -> T.Text
renderChannel s item Channel{chName, chKind, chConstraint, chUrl, chAccount, chColor, chDraft} =
    T.intercalate "\n" (header ++ concatMap renderSection (chDraft item))
  where
    header =
        [ boldFg s chColor ("\x2501\x2501\x2501 " <> chName <> " ") <> fg s chColor (T.replicate (max 3 (24 - T.length chName)) "\x2501") <> "  " <> dim s (kindText chKind) <> dim s " \x00b7 " <> fg s chColor (constraintText chConstraint)
        , "  " <> dim s "account " <> accountText s chAccount
        , "  " <> dim s "post at " <> link s chUrl (fg s chColor (displayUrl chUrl))
        ]
    renderSection Section{secLabel, secBody} = ["", "  " <> dim s secLabel, "", T.stripEnd secBody]

kindText :: ChannelKind -> T.Text
kindText = \case
    Forum -> "forum"
    Microblog -> "microblog"
    MailingList -> "mailing list"
    Newsletter -> "newsletter"

-- | The channel's format, length limit and etiquette as one line of chrome.
constraintText :: Constraint -> T.Text
constraintText Constraint{conFormat, conLength, conEtiquette} =
    T.intercalate " \x00b7 " ([formatText conFormat, lengthText conLength] ++ map etiquetteText conEtiquette)
  where
    formatText = \case
        Markdown -> "Markdown"
        PlainText -> "plain text"
    lengthText = \case
        Unlimited -> "no length limit"
        PostAtMost n -> "\x2264 " <> tshow n <> " chars"
        TitleAtMost n -> "title \x2264 " <> tshow n
    etiquetteText = \case
        ListEtiquette -> "list etiquette"
        ImportantNewsOnly -> "important news only"

-- | Human-readable "who posts this" line, coloured as a traffic light:
-- green = HF-owned/safe, yellow = unconfirmed, red = needs your personal
-- identity (the easy thing to get wrong). These three saturated colours are
-- reserved for this flag and never used for channel chrome (see 'chColor').
accountText :: Style -> PostAs -> T.Text
accountText s = \case
    AsHF -> fg s 40 "Haskell Foundation account"
    AsPrivate -> boldFg s 203 "your PRIVATE account"
    AsPrivateEmail -> boldFg s 203 "your PRIVATE email address"
    AsPrivateGitHub -> boldFg s 203 "your PRIVATE GitHub account (as a pull request)"
    AsUnknown -> boldFg s 220 "HF or private? \x2014 unconfirmed, check before posting"

displayUrl :: T.Text -> T.Text
displayUrl url = fromMaybe url (T.stripPrefix "mailto:" url)

tshow :: (Show a) => a -> T.Text
tshow = T.pack . show

-- ANSI helpers. Each is a no-op when the corresponding Style flag is off.

sgr :: Style -> [Int] -> T.Text -> T.Text
sgr Style{styColor} codes t
    | styColor = "\ESC[" <> T.intercalate ";" (map tshow codes) <> "m" <> t <> "\ESC[0m"
    | otherwise = t

bold :: Style -> T.Text -> T.Text
bold s = sgr s [1]

dim :: Style -> T.Text -> T.Text
dim s = sgr s [2]

fg :: Style -> Int -> T.Text -> T.Text
fg s n = sgr s [38, 5, n]

boldFg :: Style -> Int -> T.Text -> T.Text
boldFg s n = sgr s [1, 38, 5, n]

-- | Wrap @label@ in an OSC 8 hyperlink escape so it's clickable in modern
-- terminals; plain @label@ otherwise.
link :: Style -> T.Text -> T.Text -> T.Text
link Style{styLinks} url label
    | styLinks = "\ESC]8;;" <> url <> "\ESC\\" <> label <> "\ESC]8;;\ESC\\"
    | otherwise = label

{- | Assemble title/blurb/url/hashtags on their own lines, trimming the blurb
(with an ellipsis) so the whole post fits @limit@ characters. Title, url and
hashtags are never trimmed. The character count goes in the section's chrome
label rather than the body, so what you paste is exactly the post.
-}
budgetedPost :: Int -> NewsItem -> Section
budgetedPost limit NewsItem{niTitle, niBlurb, niUrl} =
    section ("post \x00b7 " <> tshow (T.length post) <> "/" <> tshow limit <> " chars") post
  where
    tagsLine = T.unwords hashtags
    sep = "\n\n" :: T.Text
    fixedLen = T.length niTitle + T.length niUrl + T.length tagsLine + 3 * T.length sep
    blurbBudget = limit - fixedLen
    blurb
        | blurbBudget <= 0 = ""
        | T.length niBlurb <= blurbBudget = niBlurb
        | otherwise = T.stripEnd (T.take (blurbBudget - 1) niBlurb) <> "\x2026"
    post = T.intercalate sep (filter (not . T.null) [niTitle, blurb, niUrl, tagsLine])
