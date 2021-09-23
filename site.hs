{-# Language DeriveGeneric #-}
{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language TemplateHaskell #-}

import Hakyll
import Control.Monad (filterM)
import Data.List (sortOn)
import Data.Ord (comparing)

config :: Configuration
config = defaultConfiguration
 { destinationDirectory = "../docs"
 }

main :: IO ()
main = hakyll $ do
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

    match "affiliates/*.markdown" $ do
        compile pandocCompiler

    match "donations/sponsors/*.markdown" $ do
        compile pandocCompiler

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

    match "templates/*" $ compile templateBodyCompiler

-- | Partition affiliates into affiliates and pending
affiliatesCtx :: [Item String] -> Context String
affiliatesCtx tuts =
    listField "affiliated" defaultContext (ofStatus "affiliated") <>
    listField "pending" defaultContext (ofStatus "pending") <>
    defaultContext
  where
    ofStatus ty = filterM (\item -> do
        mbStatus <- getMetadataField (itemIdentifier item) "status"
        return $ Just ty == mbStatus) tuts

-- | Partition sponsors into by level: monad, applicative, and functor
sponsorsCtx :: Context String -> [Item String] -> Context String
sponsorsCtx ctx sponsors =
    listField "monads" defaultContext (ofLevel "Monad") <>
    listField "applicatives" defaultContext (ofLevel "Applicative") <>
    listField "functors" defaultContext (ofLevel "Functor") <>
    ctx
  where
    ofLevel ty = filterM (\item -> do
        mbLevel <- getMetadataField (itemIdentifier item) "level"
        return $ Just ty == mbLevel) sponsors
