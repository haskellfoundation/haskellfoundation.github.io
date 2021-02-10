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
import System.Which
import System.FilePath.Posix (takeBaseName)

data TemplateData = TemplateData
  { templateData_pages :: PagesData
  } deriving Generic

data PagesData = PagesData
  { pagesData_home :: HomeData
  , pagesData_whoWeAre :: WhoWeAreData
  --, pagesData_affiliates :: AffiliatesData
  ----, pagesData_news :: NewsData
  ----, pagesData_sponsorship :: SponshorshipData
  --, pagesData_resources :: ResourcesData
  --, pagesData_faq :: FaqData
  } deriving Generic

data HomeData = HomeData
  { homeData_ethos :: [Ethos]
  } deriving Generic

data Ethos = Ethos
  { ethos_icon :: String
  , ethos_title :: String
  , ethos_description :: String
  } deriving Generic

data WhoWeAreData = WhoWeAreData
  { whoWeAreData_profiles :: [Profile]
  } deriving Generic

data Profile = Profile
  { profile_name :: String
  , profile_image :: String
  , profile_position :: String
  , profile_bio :: String
  , profile_committees :: [String]
  , profile_email :: String
  } deriving Generic

profileCtx :: Context Profile
profileCtx = mconcat
  [ field "name" (pure . profile_name . itemBody)
  , field "image" (pure . profile_image . itemBody)
  , field "position" (pure . profile_position . itemBody)
  , field "bio" (pure . profile_bio . itemBody)
  , field "committees" (pure . unwords . profile_committees . itemBody)
  , field "email" (pure . profile_email . itemBody)
  ]

data AffiliatesData = AffiliatesData
  { affiliates_affiliated :: [Affiliate]
  , affiliates_pending :: [Affiliate]
  } deriving Generic

data Affiliate = Affiliate
  { affiliate_name :: String
  , affiliate_url :: String
  } deriving Generic

data ResourcesData = ResourcesData
  { resources_resources :: [Resource]
  } deriving Generic

data Resource = Resource
  { resource_title :: String
  , resource_description :: String
  , resource_linkTitle :: String
  } deriving Generic

data FaqData = FaqData
  { faqData_questions :: [Question]
  } deriving Generic

data Question = Question
  { question_question :: String
  , question_answer :: String
  } deriving Generic

fmap concat $ traverse
  (Aeson.deriveJSON $ Aeson.defaultOptions
    { Aeson.fieldLabelModifier = drop 1 . dropWhile (/= '_') })
  [ ''TemplateData
  , ''PagesData
  , ''HomeData
  , ''Ethos
  , ''WhoWeAreData
  , ''Profile
  , ''AffiliatesData
  , ''Affiliate
  , ''ResourcesData
  , ''Resource
  , ''FaqData
  , ''Question
  ]

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

    -- match (fromList ["about.rst", "contact.markdown"]) $ do
    --     route   $ setExtension "html"
    --     compile $ pandocCompiler
    --         >>= loadAndApplyTemplate "templates/boilerplate.html" defaultContext
    --         >>= relativizeUrls

    -- match "posts/*" $ do
    --     route $ setExtension "html"
    --     compile $ pandocCompiler
    --         >>= loadAndApplyTemplate "templates/post.html"    postCtx
    --         >>= loadAndApplyTemplate "templates/default.html" postCtx
    --         >>= relativizeUrls

    -- create ["archive.html"] $ do
    --     route idRoute
    --     compile $ do
    --         posts <- recentFirst =<< loadAll "posts/*"
    --         let archiveCtx =
    --                 listField "posts" postCtx (return posts) `mappend`
    --                 constField "title" "Archives"            `mappend`
    --                 defaultContext

    --         makeItem ""
    --             >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
    --             >>= loadAndApplyTemplate "templates/default.html" archiveCtx
    --             >>= relativizeUrls

    match "data.json" $ compile $ getResourceLBS

    match "index.html" $ do
        route idRoute
        compile $ do
            getResourceBody
                >>= applyAsTemplate defaultContext
                >>= loadAndApplyTemplate "templates/boilerplate.html" defaultContext
                >>= relativizeUrls

    match "*/index.html" $ do
        route idRoute
        compile $ do
            dat <- getData
            let indexCtx = mconcat
                  [ listField "profiles" profileCtx
                      (pure $ sequence $ whoWeAreData_profiles . pagesData_whoWeAre . templateData_pages <$> dat)
                  , constField "title" "Home"
                  , defaultContext
                  ]

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/boilerplate.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

getData :: Compiler (Item TemplateData)
getData = do
  dataString :: Item ByteString <- load "data.json"
  pure $ fromMaybe (error "bad data") . Aeson.decode <$> dataString

postcss :: Compiler (Item ByteString)
postcss =
  getResourceLBS >>= withItemBody (unixFilterLBS $(staticWhich "postcss") [])
