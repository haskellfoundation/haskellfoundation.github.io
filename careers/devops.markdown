---
title: DevOps Engineer
summary: The Haskell Foundation (HF) seeks a passionate DevOps professional to support GHC, related Haskell projects and tooling, and the HF itself.
postedOn: 2022-01-12
status: Open
---

# Description

The [Haskell Foundation](https://haskell.foundation) is [looking for a DevOps engineer](https://github.com/haskellfoundation/tech-proposals/blob/main/proposals/accepted/003-ghc-ops.md) to take the Haskell ecosystem, primarily the [Glasgow Haskell Compiler](https://gitlab.haskell.org/ghc/ghc) (GHC, the Haskell compiler), to the next level of stability, reliability, and performance.

This role spans many Haskell ecosystem projects to homogenize and improve the infrastructure used to build GHC and other core open source projects whose maintainers are interested, for instance HLS, Cabal, Stack, GHCup, core libraries, and more.

The successful candidate will be in the middle of it all, collaborating with developers at the forefront of making Haskell a groundbreaking, influential, top-tier programming language. The individual will improve existing infrastructure, work on creating a shared [CI](https://gitlab.haskell.org/ghc/ghc/-/tree/master/.gitlab) and performance benchmarking system across the Haskell ecosystem, shortened CI turnaround times, and improved ability to debug failures.

# Responsibilities

* Maintain CI (continuous integration) infrastructure for GHC (the Glasgow Haskell Compiler, the leading compiler for the Haskell language), as hosted on GHC's GitLab instance.
* Work with the GHC team to improve CI efficiency, reliability, and resource utilization.
* Design and implement expanding the CI infrastructure to include key components of the Haskell ecosystem.
* Support other Haskell libraries and tools, including HLS (Haskell Language Server).
* Support OS packaging of GHC and tools.
* Documentation for the CI infrastructure.

## Likely future responsibilities

* Work with the [Haskell Infrastructure Team](https://github.com/haskell-infra/haskell-admins/).
* Improvements and expansion of the GHC performance dashboard.

# Qualifications

* Demonstrated ability to manage and simplify complexity
* Collaborate with a variety of stakeholders
* Ability to choose between multiple, conflicting priorities
* Excellent English written communication skills

# Current Technology Stack

* Most GHC services are hosted by a single machine running NixOS. This includes our PostreSQL database, GitLab and Grafana instances, our Docker registry, as well as various project-specific services. All of these services are provisioned via their associated Nix modules.
* Our CI infrastructure builds upon GitLab Pipelines, using Docker for build isolation and reproducibility on Linux. A qualified applicant should be comfortable with both technologies.
* We maintain a fleet of heterogeneous CI runners, covering Linux (AArch64, x86-64), Windows (x86-64), and Darwin (AArch64).

# Bonus Points

* Some famliarity with Haskell packaging.
* Familiarity with platform-dependent software packaging (e.g. notarisation and code signing on Darwin).
* Some systems programming experience.

# Misc.

This is a 100% remote position, reporting to the Executive Director of the Haskell Foundation, but taking technical direction from the GHC team (primarily Ben Gamari). Primary interactions will include people in US and European time zones, but can include coordination with people across the world at times.

Haskell knowledge in not required.

Budgeted maximum total compensation for this position is $$124k USD. Actual terms depend on experience, expertise, geographical location, local employment laws, etc.

The Haskell Foundation does not descriminate based on race, creed, color, ethnicity, national origin, religion, sex, gender identity (including gender expression), sexual orientation, disability, age, marital status, and family/parental status.
