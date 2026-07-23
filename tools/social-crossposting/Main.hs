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
import Data.Maybe (fromMaybe)
import qualified Data.Text as T
import System.Directory (doesFileExist, listDirectory)
import System.Environment (getArgs)
import System.Exit (die)
import System.FilePath (dropExtension, (<.>), (</>))
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
    putStr (renderDrafts item)

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

renderDrafts :: NewsItem -> String
renderDrafts item =
    unlines . intercalate [""] $
        [ channel "Discourse" (discourseDraft item)
        , channel "Reddit" (redditDraft item)
        , channel "Twitter/X" (twitterDraft item)
        , channel "LinkedIn" (linkedInDraft item)
        , channel "Mastodon" (mastodonDraft item)
        , channel "haskell-cafe" (haskellCafeDraft item)
        ]
  where
    channel name body = ("=== " ++ name ++ " ===") : lines (T.unpack body)

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

twitterDraft :: NewsItem -> T.Text
twitterDraft NewsItem{niTitle, niBlurb, niUrl} =
    withBudget 280 niTitle niBlurb niUrl hashtags

mastodonDraft :: NewsItem -> T.Text
mastodonDraft NewsItem{niTitle, niBlurb, niUrl} =
    withBudget 500 niTitle niBlurb niUrl hashtags

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
