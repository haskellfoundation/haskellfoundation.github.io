{ compiler ? "ghc865"
, system ? builtins.currentSystem
, pkgs ? import (import ./nixpkgs.nix) { inherit system; }
}:

let
  inherit (pkgs.lib.trivial) flip pipe;
  inherit (pkgs.haskell.lib) appendPatch appendConfigureFlags;

  haskellPackages = pkgs.haskell.packages.${compiler}.override {
    overrides = hpNew: hpOld: {
      hakyll =
        pipe
           hpOld.hakyll
           [ (flip appendConfigureFlags [ "-f" "watchServer" "-f" "previewServer" ])
           ];

      haskell-foundation = hpNew.callCabal2nix "haskell-foundation" ./. { };
    };
  };

  project = haskellPackages.haskell-foundation;
in
{
  project = project;

  shell = haskellPackages.shellFor {
    packages = p: with p; [
      project
    ];
    buildInputs = with haskellPackages; [
      ghcid
      hlint
    ];
    withHoogle = true;
  };
}
