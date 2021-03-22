{-# Language DeriveGeneric #-}
{-# Language ScopedTypeVariables #-}
{-# Language OverloadedStrings #-}
{-# Language TemplateHaskell #-}

import Control.Monad (when)
import qualified Data.Aeson as Aeson
import qualified Data.Aeson.TH as Aeson
import Data.Maybe (fromMaybe)
import Data.Monoid (mappend)
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as LBS
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Text (Text)
import GHC.Generics
import Hakyll
import System.Directory
import System.FilePath.Posix (takeBaseName)

main :: IO ()
main = do
  do
    d <- getCurrentDirectory
    if takeBaseName d == "haskell"
      then setCurrentDirectory "../site"
      else when (takeBaseName d /= "site") $
        setCurrentDirectory "./site"
  hakyll $ do
    match "static/**" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/main.css" $ do
        route   idRoute
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

    match "templates/*" $ compile templateBodyCompiler

postcss :: Compiler (Item ByteString)
postcss =
  getResourceLBS >>= withItemBody (unixFilterLBS "postcss" [])
