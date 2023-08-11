---
status: completed
title: Nighly GHC Releases in GHCUp
link: https://www.haskell.org/ghcup/guide/#nightlies
link-text: Usage Instructions
subtitle: Project Leaders
leader0name: Julian Ospald
leader0img: project-leads/jo.png
leader0mail: 
leader1name: Matthew Pickering
leader1img: project-leads/mp.png
leader1mail: 
leader2name: David Thrane Christiansen
leader2img: exec-team/dtc.png
leader2mail: david@haskell.foundation
---

The Haskell Foundation coordinated a process of making nightly builds of the latest development version of GHC conveniently available in GHCUp, making it much easier for the GHC team to gather feedback, especially from closed-source applications. With nightly builds available, projects can schedule a regular CI job that checks whether recent changes with the compiler are still compatible with the codebase, allowing developers to notify the GHC team much earlier in a development cycle. Additionally, it is now much easier for the GHC team to seek feedback regarding changes to the compiler. An [example repository](https://github.com/jappeace/haskell-nightly) has been created by the HF's Stability Working Group to demonstrate the use of nightlies with scheduled jobs on CI.

