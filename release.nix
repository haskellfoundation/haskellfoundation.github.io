{ }:
let platforms = [ "x86_64-linux" "x86_64-darwin" ];
    lib = (import (import ./dep/nixpkgs.nix) {}).lib;
in lib.genAttrs platforms (system: import ./. { inherit system; })
