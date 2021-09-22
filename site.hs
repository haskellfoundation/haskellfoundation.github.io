{-# Language DeriveGeneric #-}
{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language TemplateHaskell #-}

import Hakyll
import Control.Monad (filterM)
import Data.List (sortBy)
import Data.Ord (comparing)

config :: Configuration
config = defaultConfiguration { destinationDirectory = "docs" }

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
            getResourceBody
                >>= applyAsTemplate defaultContext
                >>= loadAndApplyTemplate "templates/boilerplate.html" defaultContext
                >>= relativizeUrls

    match "affiliates/*.markdown" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/boilerplate.html" defaultContext
            >>= relativizeUrls


    match "affiliates/index.html" $ do
        route idRoute
        compile $ do
            ctx <- affiliatesCtx <$>
                sortBy (comparing itemIdentifier) <$> loadAll "affiliates/*.markdown"

            getResourceBody
                >>= applyAsTemplate ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" ctx
                >>= relativizeUrls

    -- match "**/index.html" $ do
    --     route idRoute
    --     compile $ do
    --         getResourceBody
    --             >>= applyAsTemplate defaultContext
    --             >>= loadAndApplyTemplate "templates/boilerplate.html" defaultContext
    --             >>= relativizeUrls

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
