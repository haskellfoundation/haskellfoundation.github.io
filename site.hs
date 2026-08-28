{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ViewPatterns #-}

import Control.Monad (filterM, guard)
import Control.Monad.ListM (sortByM)
import Data.List (sortOn, isPrefixOf)
import Data.Maybe (fromMaybe, isJust)
import Data.Ord (Down (..))
import qualified Data.Text as T
import Data.Time.Calendar (Day, toGregorian)
import Data.Time.Clock (getCurrentTime, utctDay)
import Data.Time.Format (defaultTimeLocale, formatTime, parseTimeM)
import Hakyll
import Hakyll.Web.Html.RelativizeUrls (relativizeUrls)
import Hakyll.Web.Template (loadAndApplyTemplate)
import Hakyll.Web.Template.Context (defaultContext)
import System.FilePath (dropExtension, splitFileName, takeBaseName, takeDirectory, takeFileName, (</>))
import System.IO (SeekMode (RelativeSeek))
import Text.Pandoc as Pandoc (
    Block (Para, Plain),
    Extension (Ext_tex_math_dollars),
    Pandoc (..),
    ReaderOptions (readerExtensions),
    WriterOptions,
    disableExtension,
    runPure,
    writePlain,
 )

import Debug.Trace (trace)

--------------------------------------------------------------------------------------------------------
-- CONFIG ----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

config :: Configuration
config = defaultConfiguration
    { ignoreFile = \file ->
        -- The Node/Tailwind toolchain (incl. its node_modules) lives under
        -- tools/; nothing there should be compiled by Hakyll.
        "tools" `isPrefixOf` file ||
        ignoreFile defaultConfiguration file
    }

-- | The Tailwind entry point and its checked-in build output. Neither is served
-- under its own name: the entry point (@import@/@\@theme@/@\@source@) is
-- compiler input a browser cannot use, and the build output is routed to the
-- entry point's URL instead.
tailwindFiles :: Pattern
tailwindFiles = tailwindEntryPoint .||. tailwindBuilt

tailwindEntryPoint, tailwindBuilt :: Pattern
tailwindEntryPoint = "assets/css/tailwind.css"
tailwindBuilt = "assets/css/tailwind.built.css"

--------------------------------------------------------------------------------------------------------
-- MAIN GENERATION -------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    -- statics ---------------------------------------------------------------------------------------------
    -- The Tailwind build output is checked in, so a Node toolchain is needed to
    -- *change* the CSS but not to build the site with the real thing. Regenerate
    -- it with `npm run build` from tools/tailwind; CI fails if it has drifted.
    match tailwindBuilt $ do
        route $ constRoute "assets/css/tailwind.css"
        compile copyFileCompiler

    match ("assets/**" .&&. complement tailwindFiles) $ do
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
                    listField "inkinds" defaultContext (return iks)
                        <> defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/donations/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "donations/inkind/*.markdown" $ do
        route $ setExtension "html"
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing

            pandocCompiler
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/donations/page.html" defaultContext
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    -- affiliates ------------------------------------------------------------------------------------------
    match "affiliates/*.markdown" $ compile pandocCompiler
    create ["affiliates/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Affiliates")
            ctx <- affiliatesCtx . sortOn itemIdentifier <$> loadAll ("affiliates/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/affiliates/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
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
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    -- news ------------------------------------------------------------------------------------------------
    -- An entry is either a full article (own page) or a headline linking out
    -- (front matter `link`, no own page). `hasLink` splits the two.
    let hasLink = isJust . lookupString "link"
    matchMetadata "news/**.markdown" (not . hasLink) $ do
        route $ setExtension "html"
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            pandocCompiler
                >>= loadAndApplyTemplate "templates/news/page.html" newsItemCtx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls
    matchMetadata "news/**.markdown" hasLink $ compile pandocCompiler

    categories <- buildCategories "news/**.markdown" (fromCapture "news/categories/**.html")

    tagsRules categories $ \category catId -> compile $ do
        news <- recentFirst =<< loadAll catId
        let ctx =
                listField "news" newsItemCtx (pure news)
                    <> dateField "category" "%B %e, %Y"
                    <> defaultContext

        makeItem ""
            >>= loadAndApplyTemplate "templates/news/tile.html" ctx
            >>= relativizeUrls

    create ["news/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "News")
            newsWithCategories <- recentFirst =<< loadAll "news/categories/**.html"

            let ctx =
                    listField "categories" defaultContext (return newsWithCategories)
                        <> defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/news/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    -- press -----------------------------------------------------------------------------------------------
    match "press/**.markdown" $ compile pandocCompiler
    create ["news/press/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Press")
            press <- recentFirst =<< loadAll ("press/*.markdown" .&&. hasNoVersion)

            let ctx =
                    listField "press_articles" defaultContext (return press)
                        <> defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/press/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    -- faq ------------------------------------------------------------------------------------------------
    match "faq/*.markdown" $ compile pandocCompiler
    create ["faq/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "FAQ")
            ctx <- faqCtx <$> loadAll ("faq/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/faq/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
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
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    create ["who-we-are/past-boards/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Past Boards")
            ctx <- whoWeAreCtx <$> loadAll ("who-we-are/people/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/who-we-are/past-board.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    -- podcast ---------------------------------------------------------------------------------------------
    create ["podcast/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Haskell Interlude")
            ctx <- podcastListCtx . sortOn podcastOrd <$> loadAll ("podcast/*/index.markdown" .&&. hasVersion "raw")

            makeItem ""
                >>= loadAndApplyTemplate "templates/podcast/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "podcast/*/index.markdown" $ do
        route $ setExtension "html"
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            -- the episode slug is the directory name in podcast/<slug>/index.markdown
            episode <- takeFileName . takeDirectory . toFilePath <$> getUnderlying

            let ctxt =
                    mconcat
                        [ field "transcript" $ \_ -> do
                            loadBody (fromCaptures "podcast/*/transcript.markdown" [episode])
                        , field "links" $ \_ -> do
                            loadBody (fromCaptures "podcast/*/links.markdown" [episode])
                        , defaultContext
                        ]

            pandocCompiler
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/podcast/episode.html" ctxt
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "podcast/*/index.markdown" $ version "raw" $ compile pandocCompiler
    match "podcast/*/transcript.markdown" $ compile pandocCompiler
    match "podcast/*/links.markdown" $ compile pandocCompiler

    -- Events

    create ["events/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Events")
            ctx <- allEventsCtx <$> loadAll ("events/*.markdown" .&&. hasNoVersion)

            makeItem ""
                >>= loadAndApplyTemplate "templates/events/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "events/*.markdown" $ do
        route $ setExtension "html"
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            pandocCompiler
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/events/page.html" eventCtx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    -- Partnerships

    create ["partnerships/index.html"] $ do
        route idRoute
        compile $ do
            sponsors <- buildBoilerplateCtx (Just "Partnerships")
            ctx <- partnershipCtx <$> (recentFirst =<< loadAll ("partnerships/*.markdown" .&&. hasNoVersion))

            makeItem ""
                >>= loadAndApplyTemplate "templates/partnerships/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
                >>= relativizeUrls

    match "partnerships/*.markdown" $ do
        route $ setExtension "html"
        let ctxt =
                mconcat
                    [defaultContext]
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            pandocCompiler
                >>= applyAsTemplate sponsors
                >>= loadAndApplyTemplate "templates/partnerships/page.html" ctxt
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
        route . customRoute $ \ident ->
            let (ctx, nameMd) = splitFileName $ toFilePath ident
             in ctx </> dropExtension nameMd </> "index.html"
        let ctxt =
                mconcat
                    [defaultContext, reportCtx]
        compile $ do
            sponsors <- buildBoilerplateCtx Nothing
            let readerOpts =
                    defaultHakyllReaderOptions
                        { readerExtensions =
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
            announces <- take 1 <$> (recentFirst =<< loadAll @String ("news/*/**.markdown" .&&. hasNoVersion))
            let announceCtx = announcementsCtx announces
            eventsCtx <- upcomingEventsCtx <$> loadAll ("events/*.markdown" .&&. hasNoVersion)

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
                    listField "resources" defaultContext (return resources)
                        <> defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/resources/list.html" ctx
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
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
                >>= loadAndApplyTemplate "templates/careers/page.html" defaultContext
                >>= loadAndApplyTemplate "templates/boilerplate.html" sponsors
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

{- | Partition sponsors into by level: Gold, silver, and bronze
Sponsors are listed in the footer template, which means we need this
context for most pages.

We set the 'title' based on the title metadata for the item, if present,
or use the passed in Maybe title, if it is a Just, or "No title" if not.
-}
boilerPlateCtx :: Maybe String -> [Item String] -> Context String
boilerPlateCtx mtitle sponsors =
    mconcat
        [ listField "golds" defaultContext (ofMetadataField "level" "Gold" sponsors)
        , listField "silvers" defaultContext (ofMetadataField "level" "Silver" sponsors)
        , listField "bronzes" defaultContext (ofMetadataField "level" "Bronze" sponsors)
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
    listField "affiliated" defaultContext (ofMetadataField "status" "affiliated" affiliates)
        <> listField "pending" defaultContext (ofMetadataField "status" "pending" affiliates)
        <> defaultContext

-- projects --------------------------------------------------------------------------------------------

-- | Partition projects into : Ideation | Proposed | In Progress | Completed
projectsCtx :: [Item String] -> Context String
projectsCtx projects =
    listField "ideas" projectContext (ofMetadataField "status" "ideation" projects)
        <> listField "proposals" projectContext (ofMetadataField "status" "proposed" projects)
        <> listField "inprogress" projectContext (ofMetadataField "status" "inprogress" projects)
        <> listField "completed" projectContext (ofMetadataField "status" "completed" projects)
        <> defaultContext
  where
    projectContext =
        slugField "id"
            <> defaultContext

slugField :: String -> Context a
slugField name =
    field name $ pure . takeBaseName . toFilePath . itemIdentifier

-- news ------------------------------------------------------------------------------------------------

-- | Context for a single news entry, shared by the index tiles, the homepage
-- announcement and the standalone article page. `teaser` is the entry's first
-- paragraph as plain text (from the "description" version), used as a preview
-- so the index links to the full article rather than inlining it.
newsItemCtx :: Context String
newsItemCtx =
    field "teaser" (loadBody . setVersion (Just "description") . itemIdentifier)
        <> dateField "date" "%B %e, %Y"
        <> defaultContext

-- faq -------------------------------------------------------------------------------------------------
faqCtx :: [Item String] -> Context String
faqCtx entries =
    listField "faq_entries" defaultContext (sortFromMetadataField "order" entries)
        <> defaultContext

-- who we are ------------------------------------------------------------------------------------------
whoWeAreCtx :: [Item String] -> Context String
whoWeAreCtx people =
    listField "currentexecutiveteam" defaultContext (ofMetadataFieldCurrent True "executiveTeam" "True" people)
        <> listField "currentboard" defaultContext (ofMetadataFieldCurrent True "executiveTeam" "False" people >>= sortBoardByRole)
        <> listField "pastexecutiveteam" defaultContext (ofMetadataFieldCurrent False "executiveTeam" "True" people)
        <> listField "pastboard" defaultContext (ofMetadataFieldCurrent False "executiveTeam" "False" people)
        <> listField "interimboard" defaultContext (ofMetadataField "interimBoard" "True" people)
        <> defaultContext
  where
    ofMetadataFieldCurrent :: Bool -> String -> String -> [Item String] -> Compiler [Item String]
    ofMetadataFieldCurrent cur field value items = do
        items' <- ofMetadataField field value items
        nonEmpty
            =<< filterM
                ( \item -> do
                    mbTenureStart <- getMetadataField (itemIdentifier item) "tenureStart"
                    mbTenureStop <- getMetadataField (itemIdentifier item) "tenureEnd"
                    pure $ case mbTenureStop of
                        Nothing -> cur && isJust mbTenureStart
                        Just date -> not cur
                )
                items'

-- podcast ---------------------------------------------------------------------------------------------
podcastListCtx :: [Item String] -> Context String
podcastListCtx episodes =
    listField "episodes" defaultContext (return $ reverse episodes)
        <> defaultContext

podcastOrd :: Item String -> Integer
podcastOrd = read . takeFileName . takeDirectory . toFilePath . itemIdentifier

-- careers ---------------------------------------------------------------------------------------------
careersCtx :: [Item String] -> Context String
careersCtx reqs =
    listField "openreqs" defaultContext (ofMetadataField "status" "Open" reqs)
        <> listField "closedreqs" defaultContext (ofMetadataField "status" "Closed" reqs)
        <> defaultContext

hiringSponsorsCtx :: [Item String] -> Context String
hiringSponsorsCtx sponsors =
    listField "hiringsponsors" defaultContext (filterMetadataField "careersUrl" sponsors)
        <> defaultContext

-- Anouncements

announcementsCtx :: [Item String] -> Context String
announcementsCtx ads =
    listField "announcements" newsItemCtx (pure ads)

-- Events -----------------------------------------------------------------------------------------------

-- | All events, the ones happening soonest last, as an archive reads.
allEventsCtx :: [Item String] -> Context String
allEventsCtx evts =
    listField "events" eventCtx (sortOnM (fmap (Down . eventStarts) . eventDates) evts)
        <> defaultContext

-- | Only the events that have not finished yet, the ones happening soonest first.
upcomingEventsCtx :: [Item String] -> Context String
upcomingEventsCtx evts =
    listField "events" eventCtx (nonEmpty =<< upcomingEvents evts)
        <> defaultContext
  where
    upcomingEvents es = do
        today <- utctDay <$> unsafeCompiler getCurrentTime
        sortOnM (fmap eventStarts . eventDates) =<< filterM (fmap ((>= today) . eventEnds) . eventDates) es

-- | A single event, with the date range the templates show derived from 'EventDates'.
eventCtx :: Context String
eventCtx =
    field "daterange" (fmap formatDateRange . eventDates)
        <> defaultContext

{- | The span of days an event covers, from its @starts@ and (for a multi-day
event) @ends@ front matter fields. Keeping the dates as data rather than as the
prose field they replace lets the home page drop past events by itself, and
leaves one place where a range is worded.
-}
data EventDates = EventDates {eventStarts :: Day, eventEnds :: Day}

eventDates :: Item a -> Compiler EventDates
eventDates item = do
    starts <- isoDay "starts" =<< getMetadataField' ident "starts"
    ends <- traverse (isoDay "ends") =<< getMetadataField ident "ends"
    pure $ EventDates starts (fromMaybe starts ends)
  where
    ident = itemIdentifier item
    isoDay name raw =
        maybe (fail $ show ident <> ": " <> name <> " is not a YYYY-MM-DD date: " <> raw) pure $
            parseTimeM True defaultTimeLocale "%Y-%m-%d" raw

{- | Word a span the way a person would: @June 4, 2026@ for a single day,
@June 7-9, 2023@ within one month, @May 30 - June 2, 2026@ within one year, and
both dates in full across years.
-}
formatDateRange :: EventDates -> String
formatDateRange (EventDates starts ends)
    | starts == ends = fmt "%B %-d, %Y" starts
    | (startYear, startMonth) == (endYear, endMonth) = fmt "%B %-d" starts <> "-" <> fmt "%-d, %Y" ends
    | startYear == endYear = fmt "%B %-d" starts <> " - " <> fmt "%B %-d, %Y" ends
    | otherwise = fmt "%B %-d, %Y" starts <> " - " <> fmt "%B %-d, %Y" ends
  where
    (startYear, startMonth, _) = toGregorian starts
    (endYear, endMonth, _) = toGregorian ends
    fmt :: String -> Day -> String
    fmt = formatTime defaultTimeLocale

partnershipCtx :: [Item String] -> Context String
partnershipCtx evts =
    listField "partnerships" defaultContext (pure evts)
        <> defaultContext

-- Reports

allReportsCtx :: [Item String] -> Context String
allReportsCtx evts =
    listField "reports" (defaultContext <> reportCtx) (pure evts)
        <> defaultContext

reportCtx :: Context String
reportCtx = dateField "date" "%B %d, %0Y"

--------------------------------------------------------------------------------------------------------
-- UTILS -----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

{- | Fail (rather than return an empty list) when nothing is left, so that the
'listField' built from the result is *absent* and `$if(...)$` in templates is
False. Otherwise an empty list still counts as "present" and a template renders
a section heading above no tiles at all.
-}
nonEmpty :: [a] -> Compiler [a]
nonEmpty items = guard (not (null items)) >> pure items

-- | Sort by a key that can only be computed in the 'Compiler' monad.
sortOnM :: (Ord b) => (a -> Compiler b) -> [a] -> Compiler [a]
sortOnM key items = map fst . sortOn snd <$> traverse (\x -> (,) x <$> key x) items

-- | filter list of item string based on whether or not the field exists
filterMetadataField :: String -> [Item String] -> Compiler [Item String]
filterMetadataField field =
    filterM
        ( \item -> do
            mbField <- getMetadataField (itemIdentifier item) field
            return $ isJust mbField
        )

-- | filter list of item string based on the given value to match on the given metadata field
ofMetadataField :: String -> String -> [Item String] -> Compiler [Item String]
ofMetadataField field value items =
    nonEmpty
        =<< filterM
            ( \item -> do
                mbField <- getMetadataField (itemIdentifier item) field
                return $ Just value == mbField
            )
            items

-- | sort list of item based on the given metadata field
sortFromMetadataField :: String -> [Item String] -> Compiler [Item String]
sortFromMetadataField field =
    sortByM
        ( \a b -> do
            a' <- getMetadataField (itemIdentifier a) field
            b' <- getMetadataField (itemIdentifier b) field
            return $ compare a' b'
        )

{- | A board member's role. The ordering of the constructors is significant: the
derived 'Ord' instance ranks roles in the order they should appear on the
"Who We Are" page (Chair first, officers next, plain members, then observers).
Reorder the constructors to change the display order.
-}
data Role
    = Chair
    | ViceChair
    | Treasurer
    | ViceTreasurer
    | Secretary
    | ViceSecretary
    | BoardMember
    | Observer
    deriving (Eq, Ord, Show)

{- | Parse a board member's @title@ metadata into a 'Role'. Unknown titles are a
build error, so any new role must be handled explicitly here.
-}
parseRole :: String -> Either String Role
parseRole title = case title of
    "Chair" -> Right Chair
    "Vice Chair" -> Right ViceChair
    "Treasurer" -> Right Treasurer
    "Vice Treasurer" -> Right ViceTreasurer
    "Secretary" -> Right Secretary
    "Vice Secretary" -> Right ViceSecretary
    "Vice-Secretary" -> Right ViceSecretary
    "Board Member" -> Right BoardMember
    "Observer" -> Right Observer
    _ -> Left ("parseRole: unexpected board role " ++ show title)

{- | Sort board members by their 'Role', so that officers appear first (Chair,
then Vice Chair, Treasurer, and so on) and regular board members follow. A
member with no @title@ is treated as a plain 'BoardMember'; members sharing a
role keep their relative order thanks to the stable sort.
-}
sortBoardByRole :: [Item String] -> Compiler [Item String]
sortBoardByRole items = do
    ranked <- mapM tagWithRole items
    pure $ map snd $ sortOn fst ranked
  where
    tagWithRole item = do
        title <- fromMaybe "Board Member" <$> getMetadataField (itemIdentifier item) "title"
        role <- either fail pure (parseRole title)
        pure (role, item)

--------------------------------------------------------------------------------------------------------
-- Pandoc extensions -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

{- | Read a page render using pandoc, rendering its first paragraph as a plain string

Cargo-culted from pandocCompiler
-}
pandocPlainCompiler :: Compiler (Item String)
pandocPlainCompiler =
    cached "pandocPlainCompiler" $
        getResourceBody
            >>= readPandocWith defaultHakyllReaderOptions
            >>= pure . fmap firstPara
            >>= pure . writePandocPlainWith defaultHakyllWriterOptions

{- | Write a document's first paragraph (as plain text) using pandoc, with the supplied options

Cargo-culted from hakyll’s writePandocWith
-}
writePandocPlainWith ::
    -- | Writer options for pandoc
    Pandoc.WriterOptions ->
    -- | Document to write
    Item Pandoc.Pandoc ->
    -- | Resulting HTML
    Item String
writePandocPlainWith wopt (Item itemi doc) =
    case runPure $ writePlain wopt doc of
        Left err -> error $ "Hakyll.Web.Pandoc.writePandocWith: " ++ show err
        Right item' -> Item itemi $ T.unpack item'

-- | Finds the first regular paragraph of a Pandoc doc
firstPara :: Pandoc.Pandoc -> Pandoc.Pandoc
firstPara (Pandoc.Pandoc meta blocks) = Pandoc.Pandoc meta (go blocks)
  where
    go :: [Pandoc.Block] -> [Pandoc.Block]
    go [] = [] -- I tried to use noResult "firstPara: No plain text found", but it made the build fail
    go (block@(Pandoc.Plain _) : _) = [block]
    go (block@(Pandoc.Para _) : _) = [block]
    go (_ : bs) = go bs
