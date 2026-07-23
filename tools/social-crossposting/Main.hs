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
    , niBlurb :: T.Text
    -- ^ First paragraph, plain text.
    , niUrl :: T.Text
    -- ^ Canonical site URL, or the external `link` for a link-out item.
    }

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
    let url = fromMaybe (T.pack (siteRoot </> dropExtension path <.> "html")) (metaText meta "link")
        blurb = plainFirstPara blocks
    pure NewsItem{niTitle = title, niBlurb = blurb, niUrl = url}

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

-- PRESENTATION -------------------------------------------------------------

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

-- | Which account/identity to post from. This is the main thing a human has
-- to get right, so each channel states it explicitly.
data PostAs
    = AsHF
    | AsPrivate
    | AsPrivateEmail
    | AsUnknown

data Channel = Channel
    { chName :: T.Text
    , chKind :: T.Text
    -- ^ "forum" / "microblog" / "mailing list".
    , chConstraint :: T.Text
    -- ^ Short note on the channel's main posting constraint (character
    -- limit, format, etiquette), shown next to the kind. For a hard limit
    -- that the draft also enforces, use the 'microblog' smart constructor so
    -- the displayed number and the enforced budget share one source.
    , chUrl :: T.Text
    -- ^ Where to post; rendered as a clickable link.
    , chAccount :: PostAs
    , chColor :: Int
    -- ^ 256-colour foreground code for this channel's chrome. Drawn from a
    -- cool, muted palette that is disjoint from the saturated traffic-light
    -- colours 'accountText' uses, so channel hue never clashes with the
    -- "who posts this" flag.
    , chDraft :: NewsItem -> T.Text
    }

-- | A microblog with a hard character limit. The limit feeds both the
-- displayed constraint and the draft's budget, so the two can't drift.
microblog :: T.Text -> T.Text -> PostAs -> Int -> Int -> Channel
microblog name url account color limit =
    Channel
        { chName = name
        , chKind = "microblog"
        , chConstraint = "plain text \x00b7 \x2264 " <> T.pack (show limit) <> " chars"
        , chUrl = url
        , chAccount = account
        , chColor = color
        , chDraft = \NewsItem{niTitle, niBlurb, niUrl} -> withBudget limit niTitle niBlurb niUrl hashtags
        }

channels :: [Channel]
channels =
    [ Channel
        { chName = "Discourse"
        , chKind = "forum"
        , chConstraint = "Markdown \x00b7 no length limit"
        , chUrl = "https://discourse.haskell.org/c/haskell-foundation"
        , chAccount = AsPrivate
        , chColor = 74
        , chDraft = discourseDraft
        }
    , Channel
        { chName = "Reddit"
        , chKind = "forum"
        , chConstraint = "Markdown \x00b7 title \x2264 300"
        , chUrl = "https://www.reddit.com/r/haskell/"
        , chAccount = AsPrivate
        , chColor = 173
        , chDraft = redditDraft
        }
    , microblog "Twitter/X" "https://twitter.com/haskellfound" AsHF 80 280
    , Channel
        { chName = "LinkedIn"
        , chKind = "microblog"
        , chConstraint = "plain text \x00b7 \x2264 3000 chars"
        , chUrl = "https://www.linkedin.com/company/haskell-foundation-inc"
        , chAccount = AsUnknown
        , chColor = 62
        , chDraft = linkedInDraft
        }
    , microblog "Mastodon" "https://mastodon.social/@haskell_foundation" AsHF 140 500
    , Channel
        { chName = "haskell-cafe"
        , chKind = "mailing list"
        , chConstraint = "plain text \x00b7 list etiquette"
        , chUrl = "mailto:haskell-cafe@haskell.org"
        , chAccount = AsPrivateEmail
        , chColor = 66
        , chDraft = haskellCafeDraft
        }
    ]

renderDrafts :: Style -> NewsItem -> String
renderDrafts s item = T.unpack . T.intercalate "\n\n" $ banner : map (renderChannel s item) channels
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
    T.intercalate
        "\n"
        [ boldFg s chColor ("\x2501\x2501\x2501 " <> chName <> " ") <> fg s chColor (T.replicate (max 3 (24 - T.length chName)) "\x2501") <> "  " <> dim s chKind <> constraint
        , "  " <> dim s "account " <> accountText s chAccount
        , "  " <> dim s "post at " <> link s chUrl (fg s chColor (displayUrl chUrl))
        , ""
        , T.stripEnd (chDraft item)
        ]
  where
    -- Kind stays dim; the constraint gets the channel's own hue so the
    -- useful limit reads a touch louder without leaving the channel palette.
    constraint
        | T.null chConstraint = ""
        | otherwise = dim s " \x00b7 " <> fg s chColor chConstraint

-- | Human-readable "who posts this" line, coloured as a traffic light:
-- green = HF-owned/safe, yellow = unconfirmed, red = needs your personal
-- identity (the easy thing to get wrong). These three saturated colours are
-- reserved for this flag and never used for channel chrome (see 'chColor').
accountText :: Style -> PostAs -> T.Text
accountText s = \case
    AsHF -> fg s 40 "Haskell Foundation account"
    AsPrivate -> boldFg s 203 "your PRIVATE account"
    AsPrivateEmail -> boldFg s 203 "your PRIVATE email address"
    AsUnknown -> boldFg s 220 "HF or private? \x2014 unconfirmed, check before posting"

displayUrl :: T.Text -> T.Text
displayUrl url = fromMaybe url (T.stripPrefix "mailto:" url)

-- ANSI helpers. Each is a no-op when the corresponding Style flag is off.

sgr :: Style -> [Int] -> T.Text -> T.Text
sgr Style{styColor} codes t
    | styColor = "\ESC[" <> T.intercalate ";" (map (T.pack . show) codes) <> "m" <> t <> "\ESC[0m"
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

-- DRAFTS ---------------------------------------------------------------------

discourseDraft :: NewsItem -> T.Text
discourseDraft NewsItem{niTitle, niBlurb, niUrl} =
    T.unlines ["# " <> niTitle, "", niBlurb, "", niUrl]

redditDraft :: NewsItem -> T.Text
redditDraft NewsItem{niTitle, niBlurb, niUrl} =
    T.unlines
        [ "Title: " <> niTitle
        , "Link: " <> niUrl
        , ""
        , "Suggested first comment:"
        , niBlurb
        ]

linkedInDraft :: NewsItem -> T.Text
linkedInDraft NewsItem{niTitle, niBlurb, niUrl} =
    T.unlines
        [ niTitle
        , ""
        , niBlurb
        , ""
        , "Read more: " <> niUrl
        , ""
        , T.unwords hashtags
        ]

haskellCafeDraft :: NewsItem -> T.Text
haskellCafeDraft NewsItem{niTitle, niBlurb, niUrl} =
    T.unlines ["Subject: " <> niTitle, "", niBlurb, "", niUrl]

-- | Assemble title/blurb/url/hashtags on their own lines, trimming the
-- blurb (with an ellipsis) so the whole post fits `budget` characters.
-- Title, url and hashtags are never trimmed.
withBudget :: Int -> T.Text -> T.Text -> T.Text -> [T.Text] -> T.Text
withBudget budget title blurb url tags =
    let tagsLine = T.unwords tags
        sep = "\n\n" :: T.Text
        fixedLen = T.length title + T.length url + T.length tagsLine + 3 * T.length sep
        blurbBudget = budget - fixedLen
        blurb'
            | blurbBudget <= 0 = ""
            | T.length blurb <= blurbBudget = blurb
            | otherwise = T.stripEnd (T.take (blurbBudget - 1) blurb) <> "\x2026"
        post = T.intercalate sep (filter (not . T.null) [title, blurb', url, tagsLine])
     in post <> T.pack ("\n(" ++ show (T.length post) ++ "/" ++ show budget ++ " chars)")
