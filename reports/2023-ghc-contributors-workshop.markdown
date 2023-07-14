---
title: 2023 GHC Contributor's Workshop - Retrospective
published: 2023-07-14
summary: A look back at the GHC Contributor's Workshop, 7-9 June, 2023, colocated with ZuriHac
---

The 2023 GHC Contributor's Workshop, co-organized by OST Eastern Switzerland University of Applied Sciences, the GHC development team, and the Haskell Foundation, was a hands-on introduction to working on GHC, presented by nine of GHC's main developers. In addition to the nine speakers, there were 43 registered attendees, three people from HF and OST, and three additional volunteers from the GHC project, bringing the total to 58 people.

The goals of the event were to help GHC attract more contributors, to identify and fix the difficulties faced by these new contributors, and to produce durable information sources that will help bring new contributors on board in the future. The event was a success - [25 GHC MRs are directly attributable to it](https://gitlab.haskell.org/ghc/ghc/-/merge_requests?scope=all&state=all&label_name[]=GHC%20Contributors%27%20Workshop), the onboarding experience was improved by finding and fixing many small issues with the documentation, and participants report having learned a lot about GHC. All videos are now available on a [YouTube playlist](https://www.youtube.com/playlist?list=PLQpeDZt0_xQfTQPvjsT1ub-qVPXJ6fVy0), and subtitles will be added as our captioner completes them.

We have also heard feedback that the talks were useful not only to prepare participants to contribute to GHC, but also to help them become more familiar with GHC's operations, which enables a better understanding of Haskell compilation. If you'd like to get a better idea of how GHC compiles your code, how you can understand some of the more advanced dumping flags, how to read Core, and the way the RTS lays out memory, then the videos could be a very useful source of information.

## Hybrid Event

Because travel to Switzerland can be out of reach for many community members, we ran the event as a hybrid online/in-person event. All talks were livestreamed, and remote participants could ask questions via ZuriHac's Discord. There were not many remote participants during the event - there were never more than twenty concurrent online participants - but they were active, asking good questions and discussing the topics thoroughly. This was my first time running a hybrid event, and there were some hiccups - the streaming setup that worked just fine in Copenhagen seemed to hit some thermal throttling in the much warmer Switzerland from time to time, so the talks from the first day have some problems. Our video editor cleaned it up as much as possible in post-production, and the resulting videos are as pleasant as possible to watch. This will be better for any follow-up event that we plan. Using OBS Studio to live-stream the talks made it more difficult to create separate recordings from the camera, the slides, and the microphones - in the future, we may prioritize recording quality over live streaming, and instead have a video editor standing by who can upload a video on the day of the talk. This model may bring much of the value, but with less risk and a simpler setup in the future.

## Budget and Resources

Without the GHC team's willingness to step up and spend a huge amount of time preparing and giving talks, this event could not have happened. Without their employers' willingness to support their preparatory work, many would have had a much harder time giving a talk - Well-Typed (who sent four speakers!), IOG, Tweag, Galois, Karlsruhe Institute of Technology, and Epic Games made this event possible as well. The workshop was co-organized with Farhad Mehta from OST. He took care of all interfacing with the rest of the university, including booking and rebooking rooms, arranging for the facilities department to set up the room, ordering refreshments from the canteen, acquiring keycards for organizers, providing certificates of attendance to student participants, and even helping me find reasonably-priced accommodations. Farhad was a true joy to work with, and it was a real pleasure getting to know him better.

In addition to the substantial time spent by Farhad on planning the event, the OST also contributed a spacious, comfortable, air-conditioned classroom, and their staff set up the room for us before and during the event. They also provided us with access to their Internet connection. While many Haskell-related events are run for free, we decided to charge participation fees for this event, because this allowed us to cover travel costs for our speakers, acquire video streaming equipment, provide refreshments, and support student attendees. Nobody was turned away for lack of funds, and everyone who requested a reduced or waived fee got it. Budget shortfalls were covered by the Haskell Foundation, while any excess funds would have been used to reimburse students for their travel expenses. At the end of the day, ticket income was $$11,009.22, speaker expenses were $$7166.91, A/V equipment (including camera, lens, tripod, two capture cards, and more) cost $$2828, and video editing and captioning cost $$2466 in all. Approximately 50% more coffee than anticipated was consumed, leading to a total catering bill of $$1,616.90. Student reimbursements have not yet been finalized, but we expect to use around $$1000, leading to a final deficit of around $$4,800 to be covered by the HF. We think that this is an excellent investment in the health of GHC, and it is made possible by the generous contributions of the HF's sponsors.

Three companies paid for full-price corporate tickets for their employees: [Artificial](https://artificial.io/), [IOG](https://iohk.io/), and [Well-Typed](https://well-typed.com/). These companies are all HF sponsors as well. Thank you very much for making the event possible!

## Participant Feedback

We ran a qualitative follow-up survey with participants. Generally speaking, the respondents were pleased with the workshop and felt that it delivered good value. When asked about their expectations and whether the event lived up to them, one respondent wrote:

> I hoped for a chance to understand the codebase enough to be able to start making (meaningful) changes without feeling totally lost. The workshop did not leave any unfulfilled expectations for me, I've got what I wished for.

Another said:

> I feel like I know the compiler after only three days.

Yet another said the following about their expectations:

> A foothold for contributing to GHC, and I've found it

Two companies sent a large number of participants - they reported a great deal of value from meeting and coordinating with the GHC developers who were present, as well as from the contents of the presentations.

However, multiple respondents also reported feeling tired after only a day or two, especially in-person attendees. There was a lot of information to assimilate in a short time. Suggestions included more downtime, a day off between the workshop and Zurihac, and a dedicated hacking room. We will take this feedback into account when planning future events. However, 72% percent of respondents rated the amount of content as "just right", while only 22% rated it as "too much". 81% of respondents rated the ratio of talks to breaks as "just right", while 19% thought there was not enough break time. This means that the program was generally OK.

If we plan a follow-up, we'll likely include other core Haskell tooling. Participants were most interested in learning about working on Cabal, HLS, Haddock, and Hoogle.

Colocation with Zurihac was very popular, with participants unanimously indicating that it was a good idea. The only downsides mentioned by participants were that they were away from home for longer than they would have liked, and that six intense technical days is exhausting. However, many respondents indicated that they could only attend the GHC Contributor's Workshop because of the colocation, due of the savings on travel costs. The sample is clearly biased, because if someone didn't want to go to ZuriHac, they were also unlikely to attend the workshop, but the high levels of both interest and attendance at the workshop indicate that colocation was useful.

As far as we can tell, the event was a success. It is still too early to know whether it results in there being more long-term GHC contributors, but we clearly succeeded in creating [long-lasting instructional materials](https://www.youtube.com/playlist?list=PLQpeDZt0_xQfTQPvjsT1ub-qVPXJ6fVy0), bringing many Haskell users and the GHC team closer together, and filing sharp edges off the new-contributor experience. Furthermore, the information in the talks has already been useful for Haskell users who want to understand the performance implications of their programs.
