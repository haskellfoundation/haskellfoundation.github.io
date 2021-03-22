{ }:
let platforms = [ "x86_64-linux" "x86_64-darwin" ];
    lib = (import ./dep/nixpkgs {}).lib;
in lib.genAttrs platforms (system: import ./. { inherit system; })
