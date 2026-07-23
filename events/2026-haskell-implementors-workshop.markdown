---
title: 2026 Haskell Implementors' Workshop
published: 2026-02-13
daterange: June 5, 2026
status: active
location: Rapperswil, Switzerland
summary: Forum for people interested in the design and development of Haskell implementations, tools, libraries, and supporting infrastructure.
---

The 18th Haskell Implementors' Workshop is to be held on June 5th 2026 alongside ZuriHac and the Haskell Ecosystom Workshop near Zurich. The event is organized by the Haskell Community and hosted by the Haskell Foundation at the University of Applied Sciences of Eastern Switzerland (OST) lakeside campus in Rapperswil, Switzerland. It is a forum for people interested in the design and development of Haskell implementations, tools, libraries, and supporting infrastructure to share their work and to discuss future directions and collaborations with others.

In the past the Haskell Implementors' Workshop was co-located with ICFP (International Conference on Functional Programming). However, in recent years it has become more and more challenging to attract a large enough audience and sufficiently many speakers for an appealing program. ZuriHac and the Haskell Ecosystem Workshop have become an important annual gathering of a large part of the Haskell community. Following last year's success, the Haskell Implementors' Workshop will again be co-located with these events to be accessible to a broader audience.

## Practical Information and Schedule

The workshop will be held at the [Rapperswil-Jona campus of OST](https://www.ost.ch/en/university-of-applied-sciences/campus/rapperswil-jona-campus). It is right next to the Rapperswil train station, at [Oberseestrasse 10](https://goo.gl/maps/DkF6U9qdgdjcMfz29). The [Zurihac 2026 site](https://zfoh.ch/zurihac2026/) has instructions for transportation between Rapperswil and Zürich.

<!--
All talks and presentations will be held in an air-conditioned classroom that will be configured conference-style, which means that most seats won't have a table or desk attached. During the event, we'll let you know which additional spaces are good for compiler hacking. We will post the exact room number when that becomes available.
-->

### Program

<table>
  <tr><th>Start</th><th>End</th><th>Title</th><th>Speaker(s)</th></tr>

  <tr><td> 8:00</td><td>9:00</td><td>Registration</td><td></td></tr>
  <tr><td> 9:00</td><td>9:15</td><td>Welcome & Introduction</td><td><small>chair: Christiaan Baaij</small></td></tr>

  <tr><td> 9:15</td><td>10:15</td><td>GHC Status Report</td><td>Andreas Klebinger</td></tr>

  <tr><td>10:15</td><td>10:40</td><td><details>
    <summary>Stable Haskell</summary>
    <p>
      Stable Haskell is an effort to fix Haskell tooling and drive stability in the ecosystem. We're working on making GHC easier to build (with cabal), fixing cross compilers and allow easy shipping of alternative distributions. Also see <a href=https://github.com/stable-haskell>https://github.com/stable-haskell</a>
    </p>
  </details></td><td>Julian Ospald</td></tr>

  <tr><td>10:40</td><td>11:00</td><td>break</td><td><small>chair: TBD</small></td></tr>

  <tr><td>11:00</td><td>11:25</td><td><details>
    <summary>MicroHs Dead or Alive? - A status report</summary>
    <p>
      I will present what's new in MicroHs and have some demos.
    </p>
  </details></td><td>Lennart Augustsson</td></tr>
  <tr><td>11:30</td><td>11:55</td><td><details>
    <summary>Lightweight profiling with `ghc-stack-profiler`</summary>
    <p>
    Profiling provides insight into the run-time performance characteristics of a program.
    GHC supports compiling programs with additional instrumentation for profiling.
    Instrumented programs can produce detailed reports about their runtime.
    However, instrumentation has a significant compile-time cost and performance impact, both in memory allocations and execution time.
    Additionally, cost-centre instrumentation affects optimisations, which can further distance the profiled program from its runtime behaviour under non-profiled conditions.
    </p>
    <p>
    [`ghc-stack-profiler`](https://github.com/well-typed/ghc-stack-profiler) is a lightweight alternative to existing profiling mechanisms in GHC.
    Unlike the existing profiling instrumentation in GHC, it doesn't need specific support from the RTS, and dependencies don't need to be recompiled either.
    It takes a snapshot of the RTS callstack of a running Haskell thread, serialises this snapshot sample and writes it to the eventlog at fixed intervals.
    The frames of the RTS callstack have source information attached to them via `-finfo-table-map`, yielding human-readable stack traces with file and line information.
    Since raw RTS callstacks can be difficult to interpret, `ghc-stack-profiler` supports [GHC's stack annotation](https://www.well-typed.com/blog/2025/09/better-haskell-stack-traces/) frames.
    This gives developers more control over profiling, while noticeably improving readability.
    </p>
    <p>
    In this talk, we present `ghc-stack-profiler`, discuss its implementation details, and its relation to stack annotations.
    Moreover, we cover how to use it effectively, and showcase different tools to visualize the performance profiles it produces.
    </p>
    <p>
    Collaborators: Matthew Pickering, Wen Kokke
    </p>
  </details></td><td>Hannes Siebenhandl</td></tr>
  <tr><td>12:00</td><td>12:25</td><td><details>
    <summary>Evolving the Haskell Debugger</summary>
    <p>
    The new Haskell debugger is an increasingly robust and useful tool to find bugs in your codebase.
    In fact, the debugger is already being useful in debugging both GHC and the debugger itself.
    </p>
    <p>
    Besides fixing bugs and supporting more Debug Adapter Protocol (DAP) features, a few recent changes are particularly important for debugging reasonably complex programs:
    <ul>
    <li>Custom user-given `DebugView` instances</li>
    <li>Stack frames and per-frame variables</li>
    <li>Source locations and stack traces for exceptions</li>
    <li>And using the external interpreter by default (for multi-threaded support and isolation).</li>
    </ul>
    </p>
    <p>
    In this talk, we revisit the latest or ongoing work on the Haskell Debugger, and the necessary GHC changes to support it, with a focus on the changes mentioned before.
    </p>
  </details></td><td>Rodrigo Mesquita</td></tr>
  <tr><td>12:25</td><td>14:00</td><td>lunch</td><td><small>chair: TBD</small></td></tr>

  <tr><td>14:00</td><td>14:45</td><td><details>
    <summary>Is There a Future for a Formally Specified Haskell Report</summary>
    <p>
    Despite giant leaps in both our theoretical understanding of programming languages on the one hand, and the usability of proof assistants on the other hand, we are still living with languages that are specified in natural, semi-formal language.
    For a while I have been asking myself what the essential difficulties are when it comes to writing a completely formal, mechanized specification of Haskell.
    Haskell has been specified in multiple official Haskell reports, as well as academic articles which describe many different aspects in more detail.
    From precise grammars for indentation sensitive languages, to the specification of its module system, type inference system and type classes, most non-trivial aspects of Haskell have been the subject of some detailed investigation.
    Most of these articles can be formalized by a competent proof assistant user in a relatively short amount of time.
    How much more work would be required if we tried to combine them all? I will present my work on writing a fully verified Haskell frontend in the proof assistant Lean, as well as a mechanized version of K-F Faxen's declarative specification of Haskell's type system.
    </p>
    <p>
    (Content will be similar to a presentation I gave at our research group in Kent: <a href=https://binderdavid.github.io/talks/haskell-spec-plas.pdf>https://binderdavid.github.io/talks/haskell-spec-plas.pdf</a>)
    </p>
  </details></td><td>David Binder</td></tr>
  <tr><td>14:50</td><td>15:15</td><td><details>
    <summary>Towards better implicit parameters</summary>
    <p>
      GHC provides an implementation of dynamic scoping via the ImplicitParams extension. Unfortunately this feature suffers from various limitations, in particular lack of abstraction and no way to solve naming conflicts.
As an attempt to improve on the current situation, I submitted a GHC proposal called "Scoped values", which introduces a new mechanism for dynamic scoping. The main difference from ImplicitParams is that keys are not flat Symbols but nominal data types.
While the proposal was met with mixed reactions and was ultimately closed, I believe the exercise was valuable: it presented interesting compiler design choices, and the discussion helped surface a more general solution, itself with its own trade-offs and open questions.
    </p>
  </details></td><td>Lorenzo Tabacchini</td></tr>

  <tr><td>15:15</td><td>15:45</td><td>break</td><td><small>chair: TBD</small></td></tr>

  <tr><td>15:45</td><td>16:30</td><td><details>
    <summary>GHC String interpolation</summary>
    <p>
      I will be going over my 3+ year old proposal adding native string interpolation to GHC: https://github.com/ghc-proposals/ghc-proposals/pull/570. The talk will include a demo, but will focus on addressing comments/questions to fuel excitement for the feature.
    </p>
  </details></td><td>Brandon Chinn</td></tr>

  <tr><td>16:30</td><td>17:20</td><td>lightning talks</td><td></td></tr>

  <tr><td>17:20</td><td>17:30</td><td>closing</td><td></td></tr>
</table>

Please submit topics for lightning talks using [this form](https://forms.gle/TWkMtrT9d4in2fsw5).

### In-Person Attendance

<!--
Please sign up [on Eventbrite](https://www.eventbrite.com/e/2025-workshops-at-zurihac-tickets-1247256801669?aff=oddtdtcreator).
-->

Registrations for both the Haskell Ecosystem Workshop (HEW) and Haskell Implementors' Workshop (HIW) are managed using the same ticketing system. **Please make sure to include a Haskell Implementors' Workshop ticket in your booking.**

Due to space constraints and to ensure that registered participant slots do not go unused, there will be a fee for participation.
Fees will be used to cover some of the costs of running the event, the remainder of the cost is sponsored by the Haskell Foundation.
The fee depends on participant category:

 * _Enrolled students_ ($$10) are participants who are enrolled full-time at an educational institution. 

 * _Other participants_ ($$20) are participants who do not meet the criterion above.
 
All fees are in US dollars.

Tickets are available on [Eventbrite](https://www.eventbrite.com/e/2026-haskell-workshops-at-zurihac-tickets-1987550095840)

### Preparation

You are invited to bring the necessary equipment to work on GHC (laptop, power adapter, etc). Swiss electricity is 220 volts, 50 Hz AC. [Swiss power outlets](https://en.wikipedia.org/wiki/AC_power_plugs_and_sockets#Swiss_SN_441011_(Type_J)) are different than in many European countries, so please bring an appropriate adapter if necessary. Drinking fountains are not common in Europe, so please bring a refillable water bottle.

### Lunch and Refreshments

We will eat lunch in the OST canteen, called Mensa. While Mensa is open from 11:00-13:15, it is very busy from 11:45-12:30 because classes are in session, and they've asked that we go before or after. Talks have been scheduled to account for this.

Coffee, tea, and fruit will be provided. There is also easy access to a tap for water. Dinner is on your own. There is a grocery store very near the campus where other products can be purchased as well.

### Video Recordings and Live Streaming

The recordings [are available online](https://www.youtube.com/playlist?list=PLV9Q98f69SkA).

## Call for Proposals

### Scope and Target Audience

The Haskell Implementors' Workshop is an ideal place to describe a Haskell extension, describe works-in-progress, demo a new Haskell-related tool, or even propose future lines of Haskell development. Members of the wider Haskell community are encouraged to attend the workshop - we need your feedback to keep the Haskell ecosystem thriving. Students working with Haskell are especially encouraged to share their work.

The scope covers any of the following topics. There may be some topics that people feel we've missed, so by all means submit a proposal even if it doesn't fit exactly into one of these buckets:

* Compilation techniques
* Language features and extensions
* Type system implementation
* Concurrency and parallelism: language design and implementation
* Performance, optimization and benchmarking
* Virtual machines and run-time systems
* Libraries and tools for development or deployment

### Talks

We invite proposals from potential speakers for talks and demonstrations. We are aiming for 20-minute talks with 5 minutes for questions and changeovers. We want to hear from people writing compilers, tools, or libraries, people with cool ideas for directions in which we should take the platform, proposals for new features to be implemented, and half-baked crazy ideas. Please submit a talk title and abstract of no more than 300 words.

We will also have a lightning talks session. Lightning talks should be ~7mins and are scheduled on the day of the workshop. Suggested topics for lightning talks are to present a single idea, a work-in-progress project, a problem to intrigue and perplex Haskell implementors, or simply to ask for feedback and collaborators.

Submissions can be made via the follwoing form until __April 10, 2026__ (anywhere on earth): [https://forms.gle/S8fpAgFaFEvqoMqH6](https://forms.gle/S8fpAgFaFEvqoMqH6)

Authors will be notified about the inclusion of their proposal in the final program by __May 8, 2026__.

### Program Committee

* Andrew Lelechenko
* Avi Press
* Christiaan Baaij (chair)
* Gergo Erdi
* Jeffrey Young

## Partners

The event is organized by the Haskell Community and hosted by the Haskell Foundation at the University of Applied Sciences of Eastern Switzerland (OST). The Haskell Foundation itself is supported by several sponsors.


<div class="flex flex-wrap items-center justify-center"><a class="block w-48" style="margin-right: 4rem"><img src="/assets/images/partners/ost_logo-400.png"></a><a class="block w-48" style="margin-left: 4rem;"><img src="/assets/images/logos/hf-logo-400px-alpha.png"></a></div>
