{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language ViewPatterns #-}

import Hakyll
import Data.List (sortOn)
import Control.Monad (filterM, guard)
import Control.Monad.ListM (sortByM)
import Hakyll.Web.Template (loadAndApplyTemplate)
import System.IO (SeekMode(RelativeSeek))
import Hakyll.Web.Html.RelativizeUrls (relativizeUrls)
import Hakyll.Web.Template.Context (defaultContext)
import Data.Maybe (isJust, fromJust, fromMaybe)

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
            iks <- loadAll "donations/inkind/*.markdown"

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
            ctx <- affiliatesCtx . sortOn itemIdentifier <$> loadAll "affiliates/*.markdown"

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
            ctx <- projectsCtx . sortOn itemIdentifier <$> loadAll "projects/*.markdown"

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
            press <- recentFirst =<< loadAll "press/*.markdown"

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
            ctx <- faqCtx <$> loadAll "faq/*.markdown"

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
            ctx <- whoWeAreCtx <$> loadAll "who-we-are/people/*.markdown"

            makeItem ""
                >>= loadAndApplyTemplate "templates/who-we-are/exec-and-board.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"               sponsors
                >>= relativizeUrls

    create ["who-we-are/past-boards/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Past Boards")
            ctx <- whoWeAreCtx <$> loadAll "who-we-are/people/*.markdown"

            makeItem ""
                >>= loadAndApplyTemplate "templates/who-we-are/past-board.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"           sponsors
                >>= relativizeUrls

-- podcast ---------------------------------------------------------------------------------------------
    create ["podcast/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Haskell Interlude")
            ctx <- podcastCtx . sortOn podcastOrd <$> loadAll ("podcast/*/index.markdown" .&&. hasVersion "raw")

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

-- home page -------------------------------------------------------------------------------------------
    create ["index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Haskell Foundation")
            podcastsCtx <- podcastCtx . take 1 . reverse . sortOn podcastOrd <$> loadAll ("podcast/*/index.markdown" .&&. hasVersion "raw")
            careersCtx <- careersCtx . reverse <$> loadAll "careers/*.markdown"

            makeItem ""
                >>= loadAndApplyTemplate "templates/homepage.html" (podcastsCtx <> careersCtx)
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
            resources <- loadAll "resources/*.markdown"

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
                >>= relativizeUrls

-- Careers ---------------------------------------------------------------------------------------------
    create ["careers/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Careers")
            ctx <- careersCtx <$> loadAll "careers/*.markdown"
            hiringSponsors <- hiringSponsorsCtx <$> loadAll "donations/sponsors/*.markdown"

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
buildBoilerplateCtx mtitle = boilerPlateCtx mtitle . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"

-- | Partition sponsors into by level: monad, applicative, and functor
-- Sponsors are listed in the footer template, which means we need this
-- context for most pages.
--
-- We set the 'title' based on the title metadata for the item, if present,
-- or use the passed in Maybe title, if it is a Just, or "No title" if not.
boilerPlateCtx :: Maybe String -> [Item String] -> Context String
boilerPlateCtx mtitle sponsors =
    listField "monads" defaultContext (ofMetadataField "level" "Monad" sponsors)             <>
    listField "applicatives" defaultContext (ofMetadataField "level" "Applicative" sponsors) <>
    listField "functors" defaultContext (ofMetadataField "level" "Functor" sponsors)         <>
    field "title" (\item -> do
        metadata <- getMetadata (itemIdentifier item)
        return $ fromMaybe (fromMaybe "No title" mtitle) $ lookupString "title" metadata)    <>
    defaultContext

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
    listField "ideas" defaultContext (ofMetadataField "status" "ideation" projects)        <>
    listField "proposals" defaultContext (ofMetadataField "status" "proposed" projects)    <>
    listField "inprogress" defaultContext (ofMetadataField "status" "inprogress" projects) <>
    listField "completed" defaultContext (ofMetadataField "status" "completed" projects)   <>
    defaultContext

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
podcastCtx :: [Item String] -> Context String
podcastCtx episodes =
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
