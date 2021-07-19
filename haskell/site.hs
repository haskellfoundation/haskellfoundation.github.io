{-# Language DeriveGeneric #-}
{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language TemplateHaskell #-}

import           Control.Monad                  ( when )
import qualified Data.Aeson                    as Aeson
import qualified Data.Aeson.TH                 as Aeson
import           Data.ByteString.Lazy           ( ByteString )
import qualified Data.ByteString.Lazy          as LBS
import           Data.Map                       ( Map )
import qualified Data.Map                      as Map
import           Data.Maybe                     ( fromMaybe )
import           Data.Monoid                    ( mappend )
import           Data.Text                      ( Text )
import           GHC.Generics
import           Hakyll
import           System.Directory
import           System.FilePath.Posix          ( takeBaseName )

config :: Configuration
config = defaultConfiguration { destinationDirectory = "../docs" }

main :: IO ()
main = do
  do
    d <- getCurrentDirectory
    if takeBaseName d == "haskell"
      then setCurrentDirectory "../site"
      else when (takeBaseName d /= "site") $ setCurrentDirectory "./site"
  hakyllWith config $ do
    match "static/**" $ do
      route idRoute
      compile copyFileCompiler

    match "css/main.css" $ do
      route idRoute
      compile postcss

    match "data.json" $ compile $ getResourceLBS

    match "index.html" $ do
      route idRoute
      compile $ do
        getResourceBody
          >>= applyAsTemplate defaultContext
          >>= loadAndApplyTemplate "templates/boilerplate.html" defaultContext
          >>= relativizeUrls

    match "**/index.html" $ do
      route idRoute
      compile $ do
        getResourceBody
          >>= applyAsTemplate defaultContext
          >>= loadAndApplyTemplate "templates/boilerplate.html" defaultContext
          >>= relativizeUrls

    match "podcast/*" $ do
      route idRoute
      compile
        $   getResourceBody
                -- >>= applyAsTemplate podcastContext
        >>= saveSnapshot "content"
        >>= relativizeUrls

    match "podcast.html" $ do
      route idRoute
      compile $ do
        episodes <- recentFirst =<< loadAll "podcast/**"
        let indexContext =
              listField "episodes" podcastContext (pure episodes)
                `mappend` defaultContext

        getResourceBody
          >>= applyAsTemplate indexContext
          >>= loadAndApplyTemplate "templates/boilerplate.html" indexContext
          >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

    create ["podcast.xml"] $ do
      route idRoute
      let feedContext = podcastContext <> bodyField "description"
      compile $ do
        posts <- fmap (take 20) .   recentFirst
          =<< loadAllSnapshots "podcast/*" "content"
        posts' <- loadAndApplyTemplate "templates/episode.xml" podcastContext <$> posts
        renderAtom feedConfiguration feedContext posts'

postcss :: Compiler (Item ByteString)
postcss = getResourceLBS >>= withItemBody (unixFilterLBS "postcss" [])


-------------------------

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
  { feedTitle       = "Haskell Interlude"
  , feedDescription = "The Haskell Foundation Podcast"
  , feedAuthorName  = "The Haskell Foundation"
  , feedAuthorEmail = "example@com"
  , feedRoot        = "https://haskell.foundation/podcast"
  }

podcastContext :: Context String
podcastContext = dateField "date" "%B %e, %Y" `mappend` defaultContext
