#!/usr/bin/env sh

export NODE_PATH=$(nix-build -A nodePkgs)/lib/node_modules
export PATH=$(nix-build -A nodePkgs)/bin:$PATH
exe=$(nix-build -A project)
cd site
$exe/bin/site watch
