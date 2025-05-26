---
title: 2025 Haskell Implementors' Workshop
published: 2025-02-14
daterange: June 6, 2025
status: active
location: Rapperswil, Switzerland
summary: Forum for people involved in the design and development of Haskell implementations, tools, libraries, and supporting infrastructure.
---

The 17th Haskell Implementors' Workshop is to be held on June 6th 2025 alongside ZuriHac and the Haskell Ecosystom Workshop near Zurich. The event is organized by the Haskell Community and hosted by the Haskell Foundation at the University of Applied Sciences of Eastern Switzerland (OST) lakeside campus in Rapperswil, Switzerland. It is a forum for people involved in the design and development of Haskell implementations, tools, libraries, and supporting infrastructure to share their work and to discuss future directions and collaborations with others.

In the past the Haskell Implementors' Workshop was co-located with ICFP (International Conference on Functional Programming). However, in recent years it has become more and more challenging to attract a large enough audience and sufficiently many speakers for an appealing program. ZuriHac and the Haskell Ecosystem Workshop have become an important annual gathering of a large part of the Haskell community. This year the Haskell Implementors' Workshop will be co-located with these events to be accessible to a broader audience.

## Practical Information and Schedule

The workshop will be held at the [Rapperswil-Jona campus of OST](https://www.ost.ch/en/university-of-applied-sciences/campus/rapperswil-jona-campus). It is right next to the Rapperswil train station, at [Oberseestrasse 10](https://goo.gl/maps/DkF6U9qdgdjcMfz29). The [Zurihac 2025 site](https://zfoh.ch/zurihac2025/) has instructions for transportation between Rapperswil and Zürich.

All talks and presentations will be held in an air-conditioned classroom that will be configured conference-style, which means that most seats won't have a table or desk attached. During the event, we'll let you know which additional spaces are good for compiler hacking. We will post the exact room number when that becomes available.

### Program

<table>
  <tr><th>Start</th><th>End</th><th>Title</th><th>Speaker(s)</th></tr>

  <tr><td> 8:00</td><td>9:00</td><td>Registration</td><td></td></tr>
  <tr><td> 9:00</td><td>9:15</td><td>Welcome & Introduction</td><td></td></tr>

  <tr><td> 9:15</td><td>10:15</td><td>GHC Status Report</td><td>Andreas Klebinger<br>& Ben Gamari</td></tr>

  <tr><td>10:15</td><td>10:40</td><td><details>
    <summary>Required Type Arguments</summary>
    <p>
      RequiredTypeArguments is a Haskell extension recently implemented in GHC as part of the Dependent Haskell initiative. In this talk, I will demonstrate how required type arguments enable better API design—including a type-safe `printf` implementation—and discuss the far-reaching implications of this extension for Haskell's syntax.
    </p>
  </details></td><td>Vladislav Zavialov</td></tr>

  <tr><td>10:40</td><td>10:50</td><td>break</td><td></td></tr>

  <tr><td>10:50</td><td>11:15</td><td><details>
    <summary>The GHC Debugger</summary>
    <p>Collaborators: Matthew Pickering, Hannes Siebenhandl</p>
    <p>
      While using the Haskell debugger has been possible via GHCi for the last two decades, the lack
      of a modern integration with IDEs, and incomplete, slow, or unimplemented
      features, has greatly hindered its adoption.
    </p>
    <p>
      In this talk, we introduce our progress and plans to create a first-class
      debugger for Haskell. We've developed a standalone application using the
      GHC library that conforms to the Debug Adaptor Protocol (DAP), making Haskell
      debugging possible with all compatible IDEs. In the process, we've fixed long-standing performance
      and usability issues in the existing debugger implementation. Our goal is to bring
      debugging of Haskell programs to the same level as other language ecosystems.
      Finally, we’ll also reflect on the architectural limitations of the current debugger and
      outline our vision for the future of debugging in Haskell.
    </p>
  </details></td><td>Rodrigo Mesquita</td></tr>
  <tr><td>11:15</td><td>11:40</td><td><details>
    <summary>More Buck for your Bang - Lifting BangPatterns to the Type Level</summary>
    <p>
      BangPatterns is a well understood Haskell extension and often used to great effect in order to improve performance. Beyond its current definition the idea of simply letting users write <code>plus :: !Int -> !Int -> Int</code> seems trivial at first glance as the concept seems to translate to such a type signature quite easily.
    </p>
    <p>
      But what might a type signature like <code>filter :: (!Int -> Bool) -> [Int] -> Bool</code> tell us? And more importantly what can a compiler make out of it?
    </p>
    <p>
      In this talk I will briefly cover the intuition of BangPatterns as they are today. How they change the meaning of programs but also how GHC can exploit these changes to make our programs faster.
    </p>
    <p>
      From there we lift the idea one level up. How might things look if bangs were not just syntactic sugar but type modifiers instead? What would those modified types look like?
      But most importantly which benefits would this have for the expressiveness of Haskell itself, and how could both Haskell implementors and users make use of them to squeeze more performance out of their programs?
    </p>
  </details></td><td>Andreas Klebinger</td></tr>
  <tr><td>11:40</td><td>12:05</td><td><details>
    <summary>Catching space leaks at compile-time using th-deepstrict</summary>
    <p>
      Excessive laziness can cause space leaks in Haskell programs. This talk gives theoretical and practical tools to catch these performance errors at compile-time. We claim that laziness can only lead to unbounded space leaks in stateful code. So, code should either be stateless or deep strict. The <a href="https://tracsis.github.io/th-deepstrict/">th-deepstrict</a> library uses TemplateHaskell to assert that certain types are deep strict, ie, strict in all of their fields and the type of each field is itself deep strict recursively. By placing such assertions on the types that encode our program’s state, we can ensure that they do not lead to space leaks through laziness, while allowing the rest of our code to be as lazy as we desire.
    </p>
  </details></td><td>Teo Camarasu</td></tr>
  <tr><td>12:05</td><td>12:30</td><td><details>
    <summary>Making GHCi compatible with multiple home units</summary>
    <p>Collaborators: Matthew Pickering, Rodrigo Mesquita</p>
    <p>
      The ability to compile multiple units within a single session was a key
      innovation for GHC API consumers like GHCi and HLS. Today, most Haskell
      projects involve multiple local packages that developers actively modify, so
      tooling must support this workflow seamlessly.
    </p><p>
      However, GHCi's support for multiple home units remains limited.
      This significantly hampers productivity when working on
      multi-package projects. When developers start using multiple unit repl support,
      they expect the same experience as the old single-unit session.
    </p><p>
      In this talk, we present our approach to making GHCi fully compatible with
      multiple home units. Our goal is to deliver a seamless user experience: using
      GHCi with multiple home units should feel no different from working with a
      single unit. To achieve this, we are redesigning GHC's interactive session
      management with multiple home units as the default model, treating single-unit
      sessions as a special case.
    </p><p>
      This unification eliminates fragile, infrequently used code paths, reduces
      test duplication and provides feature parity. Furthermore, GHCi's built-in
      debugger will work transparently across unit boundaries, for example, allowing
      you to set breakpoints in a library component whilst debugging an executable.
    </p>
  </details></td><td>Hannes&nbsp;Siebenhandl</td></tr>

  <tr><td>12:30</td><td>14:00</td><td>lunch</td><td></td></tr>

  <tr><td>14:00</td><td>14:25</td><td><details>
    <summary>Explicit Level Imports</summary>
    <p>Collaborators: Rodrigo Mesquita, Adam Gundry</p>
    <p>
      Explicit Level Imports is an extension to GHC which allows a programmer to be
      more precise about which dependencies are needed for Template Haskell.
      In a module, each import is annotated with which level it will be needed at,
      some modules will be needed for use in splices, some in quotes and some in
      normal contexts.
    </p>
    <p>
      This precision means it is straightforward
      for the compiler to work out what is exactly needed at each stage, and
      only provide that. The result is faster compilation times and the potential
      for improved cross-compilation support.
    </p>
    <p>
      In this talk we will explain the design of the extension, the implementation and
finally reflect on future directions the extension makes possible.
    </p>
  </details></td><td>Matthew Pickering</td></tr>
  <tr><td>14:25</td><td>14:50</td><td><details>
    <summary>Intensional Analysis of Typed Template Haskell Quotations</summary>
    <p>Collaborators: Matthew Pickering</p>
    <p>
      Typed Template Haskell allows us to write Haskell code which generates other Haskell programs in a type-safe and principled manner. However, the generated programs are completely opaque and cannot be introspected, limiting the type of analysis and transformations that we can perform. We propose a system which allows the programmer to overload the meaning of quoted Template Haskell expressions by desugaring these expressions into a well-typed PHOAS representation. Being a regular datatype, the PHOAS representation is much more amenable to analysis and transformation, indirectly giving the programmer the ability to overload the meaning of quoted expressions by further processing the PHOAS representation. Primitive Haskell constructs such as variables (both free and bound), lambda expressions and patterns are all exposed in the PHOAS interface, giving the programmer a large amount of control over the meaning of their quoted expressions. We believe that this system has a variety of useful applications, particularly for creating EDSLs - we give motivating examples in practical areas such as distributed computing and program generation to demonstrate the effectiveness of this approach. More precisely, in this paper we discuss the design and implementation of this idea as a new Haskell extension implemented on top of GHC.
    </p>
  </details></td><td>Ellis Kesterton</td></tr>
  <tr><td>14:50</td><td>15:15</td><td><details>
    <summary>Modular grammar and parser for Haskell with extensions</summary>
    <p>
      The (slowly) ongoing project at <a href="https://github.com/blamario/language-haskell">github.com/blamario/language-haskell</a> contains a full parser and pretty-printer for Haskell 2010 and almost all its extensions to date. The parser is built around the core design of a modular grammar built by combining grammar extension mixins. An extension mixin builds its part of the AST via a finally-tagless type class specific to the extension. We hope the end result will be a flexible parser that can be quickly tweaked to experiment with not only Haskell but many languages in the Haskell family.
    </p>
  </details></td><td>Mario Blažević</td></tr>
  <tr><td>15:15</td><td>15:40</td><td><details>
    <summary>Towards Dream Haskell Build Experience</summary>
    <p>
      In Mercury, we are developing a new Buck2-based Haskell build system and developer environment, starting from the first principles. We achieved module-level incremental build that can be distributed over a cluster. This progress involves many fundamental improvements in the GHC pipeline; opening GHC dependency analysis API to external build system, more complete build determinism, a better interface file design, first-class byte code artifacts, unifying GHC compilation modes and a new server-mode GHC worker. I overview our goal, the current development status and the next plan, which arrives in the next GHC releases and Buck2 Haskell rules integration.
      </p>
  </details></td><td>Ian-Woo Kim</td></tr>

  <tr><td>15:40</td><td>16:10</td><td>break</td><td></td></tr>

  <tr><td>16:10</td><td>16:35</td><td><details>
    <summary>GHC's RISC-V Native Code Generation Backend</summary>
    <p>
      RISC-V is an exciting, new architecture that has received a lot of attention by
      the Open Source community lately. We will start by understanding where this
      excitement comes from and why RISC-V is not just "yet another architecture".
      We will also introduce some basic vocabulary to better understand requirements
      for compiler engineers and software packagers.
    </p><p>
      Then, we will take a look at the current state of RISC-V support in GHC with a
      focus on the Native Code Generation Backend ("NCG".) Furthermore, future
      improvements will be discussed (finally, we're at the dawn of Zurihac 2025 ;)
      .) A look at the innovative approaches to handle variable vector register
      widths in the instruction set may even inspire further research.
    </p><p>
      Implementing the RISC-V NCG was a challenge regarding software development
      environment setup, debugging and problem-solving strategies. There are a couple
      of tricks and hints be shared with future NCG developers. Most of them could be
      useful to tackle other tasks in the lower parts of the compiler pipeline as
      well.
    </p>
  </details></td><td>Sven Tennie</td></tr>
  <tr><td>16:35</td><td>17:00</td><td><details>
    <summary>An alternative to CPP</summary>
    <p>
      A surprisingly large amount of haskell code uses the CPP extension to manage compilation for supporting multiple versions of GHC. For this, only a small subset of the available CPP features are used. Because CPP is a general-purpose tool, it makes unwanted changes to the code before GHC sees it, making it much harder for tools (and humans) to process. In <a href="https://github.com/ghc-proposals/ghc-proposals/pull/616">my GHC_CPP proposal</a> I present an alternative, built in to GHC, and providing just the needed subset for this use case.
    </p><p>
      This talk presents the motivation and rationale behind this, and shares progress to date on <a href="https://gitlab.haskell.org/ghc/ghc/-/tree/wip/az/ghc-cpp">an implementation</a>.
    </p>
  </details></td><td>Alan Zimmerman</td></tr>

  <tr><td>17:00</td><td>17:50</td><td>lightning talks</td><td></td></tr>

  <tr><td>17:50</td><td>18:00</td><td>closing</td><td></td></tr>
</table>

### In-Person Attendance

Please sign up [on Eventbrite](https://www.eventbrite.com/e/2025-workshops-at-zurihac-tickets-1247256801669?aff=oddtdtcreator). Registrations for both the Haskell Ecosystem Workshop (HEW) and Haskell Implementors' Workshop (HIW) are managed using the same ticketing system. **Please make sure to include a Haskell Implementors' Workshop ticket in your booking.**

Due to space constraints and to ensure that registered participant slots do not go unused, there will be a fee for participation.
Fees will be used to cover some of the costs of running the event, the remainder of the cost is sponsored by the Haskell Foundation.
The fee depends on participant category:

 * _Enrolled students_ ($$10) are participants who are enrolled full-time at an educational institution. 

 * _Other participants_ ($$20) are participants who do not meet the criterion above.
 
All fees are in US dollars.

### Preparation

You are invited to bring the necessary equipment to work on GHC (laptop, power adapter, etc). Swiss electricity is 220 volts, 50 Hz AC. [Swiss power outlets](https://en.wikipedia.org/wiki/AC_power_plugs_and_sockets#Swiss_SN_441011_(Type_J)) are different than in many European countries, so please bring an appropriate adapter if necessary. Drinking fountains are not common in Europe, so please bring a refillable water bottle.

### Lunch and Refreshments

We will eat lunch in the OST canteen, called Mensa. While Mensa is open from 11:00-13:15, it is very busy from 11:45-12:30 because classes are in session, and they've asked that we go before or after. Talks have been scheduled to account for this.

Coffee, tea, and fruit will be provided. There is also easy access to a tap for water. Dinner is on your own. There is a grocery store very near the campus where other products can be purchased as well.

### Video Recordings and Live Streaming

We will record all presentations and make them available online.

## The Workshop

The Haskell Implementors' Workshop is an ideal place to describe a Haskell extension, describe works-in-progress, demo a new Haskell-related tool, or even propose future lines of Haskell development. Members of the wider Haskell community are encouraged to attend the workshop - we need your feedback to keep the Haskell ecosystem thriving. Students working with Haskell are especially encouraged to share their work.

The scope covers any of the following topics. There may be some topics that people feel we've missed, so by all means submit a proposal even if it doesn't fit exactly into one of these buckets:

* Compilation techniques
* Language features and extensions
* Type system implementation
* Concurrency and parallelism: language design and implementation
* Performance, optimization and benchmarking
* Virtual machines and run-time systems
* Libraries and tools for development or deployment

## Call for Proposals

The call for proposals is closed.
Lightning talks will be scheduled on the day of the event.

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

### Program Committee

* Luite Stegeman
* Jaro Reinders
* Emily Pillmore
* Rodrigo Mesquita
* Ian-Woo Kim
* Andreas Herrmann (chair)

## Partners

The event is organized by the Haskell Community and hosted by the Haskell Foundation at the University of Applied Sciences of Eastern Switzerland (OST). The Haskell Foundation itself is supported by several sponsors.


<div class="flex flex-wrap items-center justify-center"><a class="block w-48" style="margin-right: 4rem"><img src="/assets/images/partners/ost_logo-400.png"></a><a class="block w-48" style="margin-left: 4rem;"><img src="/assets/images/logos/hf-logo-400px-alpha.png"></a></div>
