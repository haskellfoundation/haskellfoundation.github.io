---
title: 2024 Haskell Ecosystem Workshop
published: 2022-02-29
daterange: June 6-7, 2024
status: active
location: Rapperswil, Switzerland
summary: Building on-ramps for the Haskell Ecosystem and its Tools
---


We are excited to announce the **2024 Haskell Ecosystem Workshop, June 6-7 2024**, organized by the Haskell Foundation and the OST Eastern Switzerland University of Applied Sciences! This is a workshop for those who want to gain a deeper understanding of the Haskell tooling ecosystem, whether to better leverage those tools or to become contributors.

In this two-day event, held on the lakeside campus of OST in lovely Rapperswil, Switzerland, you can learn what you need to know in order to get started working on these tools. We've asked the presenters to identify 'good first issues' for those wanting to get their feet wet on contributing. Because the workshop is immediately prior to [Zurihac 2024](https://zfoh.ch/zurihac2024/), you will have the opportunity to tackles one of these issues while the core developers are easily available!

The following speakers have been confirmed:

* Michael Peyton Jones: Haskell Language Server
* Julian Ospald: GHCUp
* Richard Eisenberg: GHC
* Alan Zimmerman: ghc-exactprint
* Hécate Choutri: Haddock and Documentation

We will update the list of confirmed speakers as the


## In-Person Attendance

Registration for in-person attendance will be managed via eventbrite. Because of the space available participation will be limited to the first 70 participants. Monad and Applicative level sponsors to the Haskell Foundation have a set of reserved seats. These reserved seats will be released to the general pool if they go unused by the sponsors.

## Video Recordings and Live Streaming

We will record all presentations and make them available online. We also plan to stream the talks live. More details on the streaming will come as it becomes available.

## The Workshop

At this workshop, you can learn the design and architecture for common tools in the Haskell Ecosystem. GHC, Cabal, HLS, GHCUp, Stackage, etc. all have teams working on maintaining and improving Haskell environment for Haskell programmers.

This is a practical workshop: any theory presented will be in service of building things! We want attendees to feel empower to contribute to these tools and walk away with a better understanding of how they might do so.

Additionally, the speakers will be available to answer questions and to provide mentorship during Zurihac itself, so this is a great opportunity to finish your first MR.

We expect that participants already know Haskell and have worked on some form of programming language implementation in the past, whether as students, at work, or just for fun. Concepts such as parsing, type checking, unification, and code generation should be familiar, but we don't expect participants to already be experts.

## Practical Information and Schedule

The workshop will be held at the [Rapperswil-Jona campus of OST](https://www.ost.ch/en/university-of-applied-sciences/campus/rapperswil-jona-campus). It is right next to the Rapperswil train station, at [Oberseestrasse 10](https://goo.gl/maps/DkF6U9qdgdjcMfz29). The [Zurihac 2024 site](https://zfoh.ch/zurihac2024/) has instructions for transportation between Rapperswil and Zürich.

All talks and presentations will be held in an air-conditioned classroom that will be configured conference-style, which means that most seats won't have a table or desk attached. During the event, we'll let you know which additional spaces are good for compiler hacking. We will post the exact room number when that becomes available.

### Preparation

This is a hands-on workshop, so please bring the equipment that you need to work on GHC (laptop, power adapter, etc). Swiss electricity is 220 volts, 50 Hz AC. [Swiss power outlets](https://en.wikipedia.org/wiki/AC_power_plugs_and_sockets#Swiss_SN_441011_(Type_J)) are different than in many European countries, so please bring an appropriate adapter if necessary. Drinking fountains are not common in Europe, so please bring a refillable water bottle.

<!--
If you intend on 
Please make sure that you have [checked out and built](https://gitlab.haskell.org/ghc/ghc/-/wikis/building) a recent GHC from source **before arriving**. In a separate checkout, please [build the JavaScript backend](https://gitlab.haskell.org/ghc/ghc/-/wikis/javascript-backend/building) as well. You should also have a working [GHC GitLab account](https://gitlab.haskell.org/users/sign_up) prior to arrival. If you have difficulties, the GHC developers have recommended asking for support in `#ghc` on [Matrix](https://matrix.to/#/#ghc:libera.chat) or IRC. 
-->

#### Checklist

 * Swiss power adapter(s), if necessary
 * Refillable water bottle
 * Working account on [gitlab.haskell.org](https://gitlab.haskell.org)
 * Checked out and built a recent GHC from source
 * Checked out and built the JavaScript backend from source

### Program

The full schedule of the program is still being drafted.

<table>

<tr><th colspan="3">2024-06-06</th></tr>
<tr><th>8:00-9:00</th><td> Registration</td><td></td></tr>
<tr><th>9:00-9:20</th><td> Welcome and Intro <a href="https://youtu.be/1QIbqktJQUc">(video)</a></td><td>Farhad&nbsp;Mehta and Jose&nbsp;Calderon</td></tr>
<tr><th>9:30-11:15</th><td> State of the Haskell Ecosystem </td><td> </td></tr>
<tr><th>11:30-12:20</th><td> </td><td> </td></tr>
<tr><th>12:30-13:30</th><td> Lunch at Mensa (Note: food is served only until 13:15)</td><td></td></tr>
<tr><th>13:40-14:40</th><td> </td><td> </td></tr>
<tr><th>15:00-17:00</th><td> </td><td> </td></tr>


<tr><th colspan="3">2024-06-07</th></tr>
<tr><th>9:15-9:30</th><td> Welcome Day 2 </td><td>Farhad&nbsp;Mehta and Jose&nbsp;Calderon</td></tr>
<tr><th>9:30-11:15</th><td> Haddock and Docs </td><td> Hécate Choutri </td></tr>
<tr><th>11:30-12:20</th><td> </td><td> </td></tr>
<tr><th>12:30-13:30</th><td>Lunch</td><td></td></tr>
<tr><th>13:40-14:40</th><td> </td><td> </td></tr>
<tr><th>15:00-17:00</th><td> </td><td> </td></tr>
<tr><th>17:00-17:30</th><td>Farewell </a></td><td></td>Farhad&nbsp;Mehta and Jose&nbsp;Calderon</tr>

</table>

All times are in CEST using a 24-hour clock. Speakers have been asked to plan appropriate breaks during their timeslots.

We don't expect every participant to attend every presentation. It's perfectly acceptable to skip a topic that you're less interested in so you can hack on a topic that you are interested in, taking advantage of ready access to the experts for hands-on assistance.

### Lunch and Refreshments

We will eat lunch in the OST canteen, called Mensa. While Mensa is open from 11:00-13:15, it is very busy from 11:45-12:30 because classes are in session, and they've asked that we go before or after. Talks have been scheduled to account for this.

Coffee, tea, and fruit will be provided. There is also easy access to a tap for water. Dinner is on your own. There is a grocery store very near the campus where other products can be purchased as well.


## Participation

Due to space constraints and to enable scholarships for student participants, there will be a fee for full on-site participation.
Fees will be used to cover travel costs for presenters, other direct costs of running the event, and students who don't have other funding to attend.
The fee depends on participant category:

 * _Enrolled students_ ($$40) are participants who are enrolled full-time at an educational institution. 

 * _Individual professionals_ ($$400) are no longer students and are interested in working on GHC for their own purposes. 

 * _Corporate participants_ ($$1200) are being paid by their employer to attend so that they can use the knowledge that they gain on the job. Corporate participants will have their company name on their name tag and their company will be listed on the event web page as a supporter of the event.
 
All fees are in US dollars.
We want the event to be as accessible as possible, given our limitations, so if the fee is a barrier to attending, please contact Jose Calderon at [jmct@haskell.foundation](mailto:jmct@haskell.foundation) to discuss a reduced or waived fee—this goes for all three categories of participant.

A certificate of completion will be available on advance request to students who attend the entire event.

Remote participation will make use of the Zurihac infrastructure. We will do our best to stream presentations and to post recordings as quickly as possible, and we will also have a chat system for remote participants.

If you or your company would like to sponsor the event, enabling more students to have financial support to attend, please contact Jose Calderon at [jmct@haskell.foundation](mailto:jmct@haskell.foundation).


<div class="flex flex-wrap items-center justify-center"><a class="block w-48" style="margin-right: 4rem"><img src="/assets/images/partners/ost_logo-400.png"></a><a class="block w-48" style="margin-left: 4rem;"><img src="/assets/images/logos/hf-logo-400px-alpha.png"></a></div>
