final: prev: {

  haskell-foundation-stacklock = final.stacklock2nix {
    stackYaml = ../stack.yaml;

    all-cabal-hashes = final.fetchFromGitHub {
      owner = "commercialhaskell";
      repo = "all-cabal-hashes";
      rev = "f3f41d1f11f40be4a0eb6d9fcc3fe5ff62c0f840";
      sha256 = "sha256-MLF0Vv2RHai3n7b04JeUchQortm+ikuwSjAzAHWvZJs=";
    };
  };

  haskell-foundation-pkg-set =
    final.haskell.packages.ghc810.override (oldAttrs: {

      inherit (final.haskell-foundation-stacklock) all-cabal-hashes;

      overrides = final.lib.composeManyExtensions [
        (oldAttrs.overrides or (_: _: {}))

        final.haskell-foundation-stacklock.stackYamlResolverOverlay

        final.haskell-foundation-stacklock.stackYamlExtraDepsOverlay

        final.haskell-foundation-stacklock.stackYamlLocalPkgsOverlay

        final.haskell-foundation-stacklock.suggestedOverlay

        (hfinal: hprev: with final.haskell.lib; {
          digest = addExtraLibrary (addBuildTool hprev.digest final.zlib) final.zlib.dev;
          fsnotify = dontCheck hprev.fsnotify;
        })
      ];
    });

  haskell-foundation-dev-shell =
    final.haskell-foundation-pkg-set.shellFor {
      packages = haskPkgs: final.haskell-foundation-stacklock.localPkgsSelector haskPkgs;
      nativeBuildInputs = [
        final.cabal-install
        final.ghcid
        final.hpack
        final.stack
        final.haskell.packages.ghc810.haskell-language-server
      ];
    };
}
