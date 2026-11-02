---
status: inprogress
title: Cabal exactprinting
link: https://github.com/haskell/cabal/pull/12316
link-text: Cabal exactprinter framework
subtitle: Project Leaders
leader0name: Leana Chiang
leader1name: Jappie Klooster
---

The Cabal Exactprint project aims to develop a precise parsing and printing tool for package descriptions in the cabal library.

This will allow both cabal and other tools to introduce deltas into package descriptions through a typed API, simplifying the modification/addition/removal of fields, without mangling the format, structure or comments of users files.