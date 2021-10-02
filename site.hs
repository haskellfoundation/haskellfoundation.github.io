{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language ViewPatterns #-}

import Hakyll
import Data.List (sortOn)
import Control.Monad (filterM)
import Control.Monad.ListM (sortByM)

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

-- home ------------------------------------------------------------------------------------------------
    match "index.html" $ do
        route idRoute
        compile $ do
            sponsors <- sponsorsCtx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
            getResourceBody
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

-- sponsors --------------------------------------------------------------------------------------------
    match "donations/sponsors/*.markdown" $ compile pandocCompiler

-- affiliates ------------------------------------------------------------------------------------------
    match "affiliates/*.markdown" $ compile pandocCompiler
    create ["affiliates/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- sponsorsCtx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
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
            sponsors <- sponsorsCtx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
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
            sponsors <- sponsorsCtx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
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
            sponsors <- sponsorsCtx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
            press <- recentFirst =<< loadAll "press/*.markdown"

            let ctx =
                    listField "press_articles" defaultContext (return press) <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/press/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

-- faq ------------------------------------------------------------------------------------------------
    match "faq/*.markdown" $ compile pandocCompiler
    create ["faq/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- sponsorsCtx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
            ctx <- faqCtx <$> loadAll "faq/*.markdown"

            makeItem ""
                >>= loadAndApplyTemplate "templates/faq/list.html"      ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

-- resources -------------------------------------------------------------------------------------------
    match "resources/*.markdown" $ compile pandocCompiler
    create ["resources/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- sponsorsCtx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
            ctx <- resourcesCtx <$> loadAll "resources/*.markdown"

            makeItem ""
                >>= loadAndApplyTemplate "templates/resources/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

-- templates -------------------------------------------------------------------------------------------
    match "templates/*" $ compile templateBodyCompiler
    match "templates/**" $ compile templateBodyCompiler


--------------------------------------------------------------------------------------------------------
-- CONTEXT ---------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- sponsors --------------------------------------------------------------------------------------------
-- | Partition sponsors into by level: monad, applicative, and functor
-- Sponsors are listed in the footer template, which means we need this
-- context for most pages.
sponsorsCtx :: [Item String] -> Context String
sponsorsCtx sponsors =
    listField "monads" defaultContext (ofMetadataField "level" "Monad" sponsors)             <>
    listField "applicatives" defaultContext (ofMetadataField "level" "Applicative" sponsors) <>
    listField "functors" defaultContext (ofMetadataField "level" "Functor" sponsors)         <>
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

-- resources -------------------------------------------------------------------------------------------
resourcesCtx :: [Item String] -> Context String
resourcesCtx resources =
    listField "resources" defaultContext (return resources) <>
    defaultContext

--------------------------------------------------------------------------------------------------------
-- UTILS -----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- | filter list of item string based on the given value to match on the given metadata field
ofMetadataField :: String -> String -> [Item String] -> Compiler [Item String]
ofMetadataField field value = filterM (\item -> do
        mbStatus <- getMetadataField (itemIdentifier item) field
        return $ Just value == mbStatus
    )

-- | sort list of item based on the given metadata field
sortFromMetadataField :: String -> [Item String] -> Compiler [Item String]
sortFromMetadataField field = sortByM (\a b -> do
        a' <- getMetadataField (itemIdentifier a) field
        b' <- getMetadataField (itemIdentifier b) field
        return $ compare a' b'
    )
