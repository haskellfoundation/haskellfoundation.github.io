#!/usr/bin/env sh

rm -fR site/_cache
nix-shell --run "sh -c \"cd haskell; cabal run haskell-foundation -- build\""
git add docs
