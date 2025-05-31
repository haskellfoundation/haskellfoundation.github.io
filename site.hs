{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language ViewPatterns #-}
{-# Language TypeApplications #-}

import Hakyll
import Data.List (sortOn)
import Control.Monad (filterM, guard)
import Control.Monad.ListM (sortByM)
import Hakyll.Web.Template (loadAndApplyTemplate)
import System.IO (SeekMode(RelativeSeek))
import Hakyll.Web.Html.RelativizeUrls (relativizeUrls)
import Hakyll.Web.Template.Context (defaultContext)
import Data.Maybe (isJust, fromJust, fromMaybe)
import Text.Pandoc as Pandoc
    ( Pandoc(..),
      WriterOptions,
      Block(Para, Plain),
      runPure,
      writePlain, ReaderOptions (readerExtensions), disableExtension, Extension (Ext_tex_math_dollars) )
import System.FilePath ((</>), dropExtension, splitFileName, takeBaseName)
import qualified Data.Text as T

import Debug.Trace (trace)

--------------------------------------------------------------------------------------------------------
-- MAIN GENERATION -------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
-- statics ---------------------------------------------------------------------------------------------
    match "assets/css/main.css" $ do
        route   idRoute
        compile compressCssCompiler

    match "assets/**" $ do
        route idRoute
        compile copyFileCompiler

    match "sw.js" $ do
        route idRoute
        compile copyFileCompiler

-- sponsors --------------------------------------------------------------------------------------------
    match "donations/sponsors/*.markdown" $ compile pandocCompiler

-- in-kind donations -----------------------------------------------------------------------------------
    create ["donations/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Sponsorship")
            iks <- loadAll ("donations/inkind/*.markdown" .&&. hasNoVersion)

            let ctx =
                    listField "inkinds" defaultContext (return iks) <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/donations/list.html"  ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"     sponsors
                >>= relativizeUrls

    match "donations/inkind/*.markdown" $ do
        route $ setExtension "html"
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing

            pandocCompiler
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/donations/page.html"  defaultContext
                >>= loadAndApplyTemplate "templates/boilerplate.html"     sponsors
                >>= relativizeUrls

-- affiliates ------------------------------------------------------------------------------------------
    match "affiliates/*.markdown" $ compile pandocCompiler
    create ["affiliates/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Affiliates")
            ctx <- affiliatesCtx . sortOn itemIdentifier <$> loadAll ("affiliates/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/affiliates/list.html"   ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"       sponsors
                >>= relativizeUrls

-- projects --------------------------------------------------------------------------------------------
    match "projects/*.markdown" $ compile pandocCompiler
    create ["projects/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Projects")
            ctx <- projectsCtx . sortOn itemIdentifier <$> loadAll ("projects/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/projects/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

-- news ------------------------------------------------------------------------------------------------
    match "news/**.markdown" $ compile pandocCompiler
    categories <- buildCategories "news/**.markdown" (fromCapture "news/categories/**.html")

    tagsRules categories $ \category catId ->  compile $ do
        news <- recentFirst =<< loadAll catId
        let ctx =
                listField "news" (newsWithCategoriesCtx categories) (pure news) <>
                dateField "category" "%B %e, %Y"                                <>
                defaultContext

        makeItem ""
            >>= loadAndApplyTemplate "templates/news/tile.html" ctx
            >>= relativizeUrls

    create ["news/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "News")
            newsWithCategories <- recentFirst =<< loadAll "news/categories/**.html"

            let ctx =
                    listField "categories" defaultContext (return newsWithCategories) <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/news/list.html"     ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

-- press -----------------------------------------------------------------------------------------------
    match "press/**.markdown" $ compile pandocCompiler
    create ["news/press/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Press")
            press <- recentFirst =<< loadAll ("press/*.markdown" .&&. hasNoVersion)

            let ctx =
                    listField "press_articles" defaultContext (return press) <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/press/list.html"    ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

-- faq ------------------------------------------------------------------------------------------------
    match "faq/*.markdown" $ compile pandocCompiler
    create ["faq/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "FAQ")
            ctx <- faqCtx <$> loadAll ("faq/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/faq/list.html"      ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

-- who we are ------------------------------------------------------------------------------------------
    match "who-we-are/people/*.markdown" $ compile pandocCompiler
    create ["who-we-are/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Who We Are")
            ctx <- whoWeAreCtx <$> loadAll ("who-we-are/people/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/who-we-are/exec-and-board.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"               sponsors
                >>= relativizeUrls

    create ["who-we-are/past-boards/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Past Boards")
            ctx <- whoWeAreCtx <$> loadAll ("who-we-are/people/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/who-we-are/past-board.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"           sponsors
                >>= relativizeUrls

-- podcast ---------------------------------------------------------------------------------------------
    create ["podcast/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Haskell Interlude")
            ctx <- podcastListCtx . sortOn podcastOrd <$> loadAll ("podcast/*/index.markdown" .&&. hasVersion "raw")

            makeItem ""
                >>= loadAndApplyTemplate "templates/podcast/list.html"  ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

    match "podcast/*/index.markdown" $ do
        route $ setExtension "html"
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            -- extract the captures path fragment. really no easier way?
            episode <- head . fromJust . capture "podcast/*/index.markdown" <$> getUnderlying

            let ctxt = mconcat
                  [ field "transcript" $ \_ -> do
                       loadBody (fromCaptures "podcast/*/transcript.markdown" [episode])
                  , field "links" $ \_ -> do
                       loadBody (fromCaptures "podcast/*/links.markdown" [episode])
                  , defaultContext
                  ]

            pandocCompiler
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/podcast/episode.html" ctxt
                >>= loadAndApplyTemplate "templates/boilerplate.html"     sponsors
                >>= relativizeUrls

    match "podcast/*/index.markdown" $ version "raw" $ compile pandocCompiler
    match "podcast/*/transcript.markdown" $ compile pandocCompiler
    match "podcast/*/links.markdown" $ compile pandocCompiler

-- Events

    create ["events/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Events")
            ctx <- allEventsCtx <$> (recentFirst =<< loadAll ("events/*.markdown" .&&. hasNoVersion))

            makeItem ""
                >>= loadAndApplyTemplate "templates/events/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "events/*.markdown" $ do
      route $ setExtension "html"
      let ctxt = mconcat
            [ defaultContext ]
      compile $ do
        sponsors <- buildBoilerplateCtx Nothing
        pandocCompiler
          >>= applyAsTemplate sponsors
          >>= loadAndApplyTemplate "templates/events/page.html" ctxt
          >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
          >>= relativizeUrls

-- Reports
    create ["reports/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Reports")
            ctx <- allReportsCtx <$> (recentFirst =<< loadAll ("reports/*.markdown" .&&. hasNoVersion))

            makeItem ""
                >>= loadAndApplyTemplate "templates/reports/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "reports/*.markdown" $ do
      route . customRoute $ \ ident ->
        let (ctx, nameMd) = splitFileName $ toFilePath ident
        in ctx </> dropExtension nameMd </> "index.html"
      let ctxt = mconcat
            [ defaultContext, reportCtx ]
      compile $ do
        sponsors <- buildBoilerplateCtx Nothing
        let readerOpts = defaultHakyllReaderOptions {
              readerExtensions =
                disableExtension Ext_tex_math_dollars $
                  readerExtensions defaultHakyllReaderOptions
              }
        pandocCompilerWith readerOpts defaultHakyllWriterOptions
          >>= applyAsTemplate sponsors
          >>= loadAndApplyTemplate "templates/reports/page.html" ctxt
          >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
          >>= relativizeUrls

    match "reports/*/*.png" $ do
      route idRoute
      compile copyFileCompiler

-- Description compiler --------------------------------------------------------------------------------
--
-- This identifier compiles the body the file to plain text, to be used in the OpenGraph description field

    match "**/*.markdown" $ version "description" $ compile pandocPlainCompiler

-- home page -------------------------------------------------------------------------------------------
    create ["index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Haskell Foundation")
            podcastsCtx <- podcastListCtx . take 1 . reverse . sortOn podcastOrd <$> loadAll ("podcast/*/index.markdown" .&&. hasVersion "raw")
            careersCtx <- careersCtx . reverse <$> loadAll ("careers/*.markdown" .&&. hasNoVersion)
            announces  <- take 1 <$> (recentFirst =<< loadAll @String ("news/*/**.markdown" .&&. hasNoVersion))
            let announceCtx = announcementsCtx announces
            eventsCtx <- activeEventsCtx <$> (recentFirst =<< loadAll ("events/*.markdown" .&&. hasNoVersion))

            makeItem ""
                >>= loadAndApplyTemplate "templates/homepage.html" (podcastsCtx <> careersCtx <> announceCtx <> eventsCtx)
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

-- general 'static' pages ------------------------------------------------------------------------------
    match "**/index.html" $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            getResourceBody
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

-- resources -------------------------------------------------------------------------------------------
    match "resources/*.markdown" $ compile pandocCompiler
    create ["resources/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Resources")
            resources <- loadAll ("resources/*.markdown" .&&. hasNoVersion)

            let ctx =
                    listField "resources" defaultContext (return resources) <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/resources/list.html"    ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"       sponsors
                >>= relativizeUrls

-- 404 -------------------------------------------------------------------------------------------------
    match "404.html" $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            getResourceBody
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors

-- careers ---------------------------------------------------------------------------------------------
    create ["careers/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Careers")
            ctx <- careersCtx <$> loadAll ("careers/*.markdown" .&&. hasNoVersion)
            hiringSponsors <- hiringSponsorsCtx <$> loadAll ("donations/sponsors/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/careers/list.html" (ctx <> hiringSponsors)
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "careers/*.markdown" $ do
        route $ setExtension "html"
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            pandocCompiler
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/careers/page.html"    defaultContext
                >>= loadAndApplyTemplate "templates/boilerplate.html"     sponsors
                >>= relativizeUrls

-- templates -------------------------------------------------------------------------------------------
    match "templates/*" $ compile templateBodyCompiler
    match "templates/**" $ compile templateBodyCompiler

--------------------------------------------------------------------------------------------------------
-- CONTEXT ---------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- sponsors --------------------------------------------------------------------------------------------

buildBoilerplateCtx :: Maybe String -> Compiler (Context String)
buildBoilerplateCtx mtitle =
    boilerPlateCtx mtitle . sortOn itemIdentifier <$> loadAll ("donations/sponsors/*.markdown" .&&. hasNoVersion)

-- | Partition sponsors into by level: monad, applicative, and functor
-- Sponsors are listed in the footer template, which means we need this
-- context for most pages.
--
-- We set the 'title' based on the title metadata for the item, if present,
-- or use the passed in Maybe title, if it is a Just, or "No title" if not.
boilerPlateCtx :: Maybe String -> [Item String] -> Context String
boilerPlateCtx mtitle sponsors = mconcat
    [ listField "monads" defaultContext (ofMetadataField "level" "Monad" sponsors)
    , listField "applicatives" defaultContext (ofMetadataField "level" "Applicative" sponsors)
    , listField "functors" defaultContext (ofMetadataField "level" "Functor" sponsors)
    , field "title" $ \item -> do
        metadata <- getMetadata (itemIdentifier item)
        return $ fromMaybe (fromMaybe "No title" mtitle) $ lookupString "title" metadata
    , field "description" $ \item -> do
        desc <- loadBody (setVersion (Just "description") (itemIdentifier item))
        if null desc then noResult "Description empty" else pure (escapeHtml desc)
    , defaultContext
    ]

-- affiliates ------------------------------------------------------------------------------------------
-- | Partition affiliates into affiliates and pending
affiliatesCtx :: [Item String] -> Context String
affiliatesCtx affiliates =
    listField "affiliated" defaultContext (ofMetadataField "status" "affiliated" affiliates)  <>
    listField "pending" defaultContext (ofMetadataField "status" "pending" affiliates)        <>
    defaultContext

-- projects --------------------------------------------------------------------------------------------
-- | Partition projects into : Ideation | Proposed | In Progress | Completed
projectsCtx :: [Item String] -> Context String
projectsCtx projects =
    listField "ideas" projectContext (ofMetadataField "status" "ideation" projects)        <>
    listField "proposals" projectContext (ofMetadataField "status" "proposed" projects)    <>
    listField "inprogress" projectContext (ofMetadataField "status" "inprogress" projects) <>
    listField "completed" projectContext (ofMetadataField "status" "completed" projects)   <>
    defaultContext
  where projectContext =
          slugField "id" <>
          defaultContext

slugField :: String -> Context a
slugField name =
  field name $ pure . takeBaseName . toFilePath . itemIdentifier

-- news ------------------------------------------------------------------------------------------------
-- | build group of news inside date of publishing (category)
newsWithCategoriesCtx :: Tags -> Context String
newsWithCategoriesCtx categories =
    listField "categories" categoryCtx getAllCategories <>
    defaultContext
        where
            getAllCategories :: Compiler [Item (String, [Identifier])]
            getAllCategories = pure . map buildItemFromTag $ tagsMap categories
                where
                    buildItemFromTag :: (String, [Identifier]) -> Item (String, [Identifier])
                    buildItemFromTag c@(name, _) = Item (tagsMakeId categories name) c
            categoryCtx :: Context (String, [Identifier])
            categoryCtx =
                listFieldWith "news" newsCtx getNews        <>
                metadataField                               <>
                urlField "url"                              <>
                pathField "path"                            <>
                titleField "title"                          <>
                missingField
                    where
                        getNews:: Item (String, [Identifier]) -> Compiler [Item String]
                        getNews (itemBody -> (_, ids)) = mapM load ids
                        newsCtx :: Context String
                        newsCtx = newsWithCategoriesCtx categories

-- faq -------------------------------------------------------------------------------------------------
faqCtx :: [Item String] -> Context String
faqCtx entries =
    listField "faq_entries" defaultContext (sortFromMetadataField "order" entries) <>
    defaultContext

-- who we are ------------------------------------------------------------------------------------------
whoWeAreCtx :: [Item String] -> Context String
whoWeAreCtx people =
    listField "currentexecutiveteam" defaultContext (ofMetadataFieldCurrent True "executiveTeam" "True" people) <>
    listField "currentboard" defaultContext (ofMetadataFieldCurrent True "executiveTeam" "False" people)        <>
    listField "pastexecutiveteam" defaultContext (ofMetadataFieldCurrent False "executiveTeam" "True" people)   <>
    listField "pastboard" defaultContext  (ofMetadataFieldCurrent False "executiveTeam" "False" people)         <>
    listField "interimboard" defaultContext (ofMetadataField "interimBoard" "True" people)                      <>
    defaultContext
    where
        ofMetadataFieldCurrent :: Bool -> String -> String -> [Item String] -> Compiler [Item String]
        ofMetadataFieldCurrent cur field value items = do
            items' <- ofMetadataField field value items
            filterM (\item -> do
                mbTenureStart <- getMetadataField (itemIdentifier item) "tenureStart"
                mbTenureStop <- getMetadataField (itemIdentifier item) "tenureEnd"
                pure $ case mbTenureStop of
                    Nothing -> cur && isJust mbTenureStart
                    Just date -> not cur
             ) items'

-- podcast ---------------------------------------------------------------------------------------------
podcastListCtx :: [Item String] -> Context String
podcastListCtx episodes =
    listField "episodes" defaultContext (return $ reverse episodes) <>
    defaultContext

podcastOrd :: Item String -> Integer
podcastOrd = read . head . fromJust . capture "podcast/*/index.markdown" . itemIdentifier

-- careers ---------------------------------------------------------------------------------------------
careersCtx :: [Item String] -> Context String
careersCtx reqs =
    listField "openreqs" defaultContext (ofMetadataField "status" "Open" reqs) <>
    listField "closedreqs" defaultContext (ofMetadataField "status" "Closed" reqs) <>
    defaultContext

hiringSponsorsCtx :: [Item String] -> Context String
hiringSponsorsCtx sponsors =
    listField "hiringsponsors" defaultContext (filterMetadataField "careersUrl" sponsors) <>
    defaultContext

-- Anouncements

announcementsCtx :: [Item String] -> Context String
announcementsCtx ads =
  listField "announcements" defaultContext (pure ads)

-- Events

allEventsCtx :: [Item String] -> Context String
allEventsCtx evts =
    listField "events" defaultContext (pure evts) <>
    defaultContext

activeEventsCtx :: [Item String] -> Context String
activeEventsCtx evts =
  listField "events" defaultContext (ofMetadataField "status" "active" evts) <>
  defaultContext

-- Reports

allReportsCtx :: [Item String] -> Context String
allReportsCtx evts =
    listField "reports" (defaultContext <> reportCtx) (pure evts) <>
    defaultContext

reportCtx :: Context String
reportCtx = dateField "date" "%B %d, %0Y"

--------------------------------------------------------------------------------------------------------
-- UTILS -----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- | filter list of item string based on whether or not the field exists
filterMetadataField :: String -> [Item String] -> Compiler [Item String]
filterMetadataField field =
    filterM (\item -> do
        mbField <- getMetadataField (itemIdentifier item) field
        return $ isJust mbField
    )

-- | filter list of item string based on the given value to match on the given metadata field
ofMetadataField :: String -> String -> [Item String] -> Compiler [Item String]
ofMetadataField field value items = do
  matching <- filterM (\item -> do
        mbField <- getMetadataField (itemIdentifier item) field
        return $ Just value == mbField) items
  guard (not (null matching))
  pure matching

-- | sort list of item based on the given metadata field
sortFromMetadataField :: String -> [Item String] -> Compiler [Item String]
sortFromMetadataField field = sortByM (\a b -> do
        a' <- getMetadataField (itemIdentifier a) field
        b' <- getMetadataField (itemIdentifier b) field
        return $ compare a' b'
    )

--------------------------------------------------------------------------------------------------------
-- Pandoc extensions -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- | Read a page render using pandoc, rendering its first paragraph as a plain string
--
-- Cargo-culted from pandocCompiler
pandocPlainCompiler :: Compiler (Item String)
pandocPlainCompiler = cached "pandocPlainCompiler" $
    getResourceBody >>=
      readPandocWith defaultHakyllReaderOptions >>=
      pure . fmap firstPara >>=
      pure . writePandocPlainWith defaultHakyllWriterOptions

-- | Write a document's first paragraph (as plain text) using pandoc, with the supplied options
--
-- Cargo-culted from hakyll’s writePandocWith
writePandocPlainWith :: Pandoc.WriterOptions  -- ^ Writer options for pandoc
                -> Item Pandoc.Pandoc    -- ^ Document to write
                -> Item String    -- ^ Resulting HTML
writePandocPlainWith wopt (Item itemi doc) =
    case runPure $ writePlain wopt doc of
        Left err    -> error $ "Hakyll.Web.Pandoc.writePandocWith: " ++ show err
        Right item' -> Item itemi $ T.unpack item'


-- | Finds the first regular paragraph of a Pandoc doc
firstPara :: Pandoc.Pandoc -> Pandoc.Pandoc
firstPara (Pandoc.Pandoc meta blocks) = Pandoc.Pandoc meta (go blocks)
  where
    go :: [Pandoc.Block] -> [Pandoc.Block]
    go [] = [] -- I tried to use noResult "firstPara: No plain text found", but it made the build fail
    go (block@(Pandoc.Plain _) : _) = [block]
    go (block@(Pandoc.Para _)  : _) = [block]
    go (_ : bs) = go bs
