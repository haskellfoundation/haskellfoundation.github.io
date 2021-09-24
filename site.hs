{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language ViewPatterns #-}

import Hakyll
import Control.Monad (filterM)
import Data.List (sortOn)
import Data.Ord (comparing)

config :: Configuration
config = defaultConfiguration

main :: IO ()
main = hakyllWith config $ do
    match "assets/css/main.css" $ do
        route   idRoute
        compile compressCssCompiler

    match "assets/**" $ do
        route idRoute
        compile copyFileCompiler

    match "index.html" $ do
        route idRoute
        compile $ do
            sponsors <- sponsorsCtx defaultContext . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
            getResourceBody
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "affiliates/*.markdown" $ compile pandocCompiler

    match "donations/sponsors/*.markdown" $ compile pandocCompiler

    match "affiliates/index.html" $ do
        route idRoute
        compile $ do
            affils <- affiliatesCtx . sortOn itemIdentifier <$> loadAll "affiliates/*.markdown"
            sponsors <- sponsorsCtx affils . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"

            getResourceBody
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "**/index.html" $ do
        route idRoute
        compile $ do
            sponsors <- sponsorsCtx defaultContext . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"
            getResourceBody
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "projects/*.markdown" $ compile pandocCompiler

    create ["projects/index.html"] $ do
        route idRoute
        compile $ do
            ctx <- projectsCtx . sortOn itemIdentifier <$> loadAll "projects/*.markdown"
            sponsors <- sponsorsCtx ctx . sortOn itemIdentifier <$> loadAll "donations/sponsors/*.markdown"

            makeItem ""
                >>= loadAndApplyTemplate "templates/projects/list.html"  sponsors
                >>= loadAndApplyTemplate "templates/boilerplate.html"   sponsors
                >>= relativizeUrls

    match "news/**.markdown" $ compile pandocCompiler
    categories <- buildCategories "news/**.markdown" (fromCapture "news/categories/**.html")

    tagsRules categories $ \category catId ->  compile $ do
        news <- recentFirst =<< loadAll catId
        let ctx =
                listField "news" (newsWithCategoriesCtx categories) (pure news) <>
                constField "category" category <>
                defaultContext

        makeItem ""
            >>= loadAndApplyTemplate "templates/news/tile.html" ctx
            >>= relativizeUrls

    create ["news/index.html"] $ do
        route idRoute
        compile $ do
            newsWithCategories <- recentFirst =<< loadAll "news/categories/**.html"
            let ctx =
                    listField "categories" defaultContext (return newsWithCategories) <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/news/list.html"     ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html"   defaultContext
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
    match "templates/**" $ compile templateBodyCompiler

-- | Partition affiliates into affiliates and pending
affiliatesCtx :: [Item String] -> Context String
affiliatesCtx tuts =
    listField "affiliated" defaultContext (ofStatus "affiliated" tuts)  <>
    listField "pending" defaultContext (ofStatus "pending" tuts)        <>
    defaultContext

-- | Partition projects into : Ideation | Proposed | In Progress | Completed
projectsCtx :: [Item String] -> Context String
projectsCtx p =
    listField "ideas" defaultContext (ofStatus "ideation" p)        <>
    listField "proposals" defaultContext (ofStatus "proposed" p)    <>
    listField "inprogress" defaultContext (ofStatus "inprogress" p) <>
    listField "completed" defaultContext (ofStatus "completed" p)   <>
    defaultContext

ofStatus :: String -> [Item String] -> Compiler [Item String]
ofStatus v = filterM (\item -> do
        mbStatus <- getMetadataField (itemIdentifier item) "status"
        return $ Just v == mbStatus
    )

-- | Partition sponsors into by level: monad, applicative, and functor
-- Sponsors are listed in the footer template, which means we need this
-- context for most pages. The first argument is another context so
-- we can compose them together, and the usage site can pass in the
-- context it is in.
sponsorsCtx :: Context String -> [Item String] -> Context String
sponsorsCtx ctx sponsors =
    listField "monads" defaultContext (ofLevel "Monad")             <>
    listField "applicatives" defaultContext (ofLevel "Applicative") <>
    listField "functors" defaultContext (ofLevel "Functor")         <>
    ctx
  where
    ofLevel ty = filterM (\item -> do
        mbLevel <- getMetadataField (itemIdentifier item) "level"
        return $ Just ty == mbLevel) sponsors

buildNewsCtx :: Tags -> Context String
buildNewsCtx categories =
    tagsField "categories" categories <>
    defaultContext

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
