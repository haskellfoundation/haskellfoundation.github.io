{ }:
let platforms = [ "x86_64-linux" "x86_64-darwin" ];
    lib = (import (import ./nixpkgs.nix) {}).lib;
in map (system: import ./project.nix { inherit system; }) platforms
