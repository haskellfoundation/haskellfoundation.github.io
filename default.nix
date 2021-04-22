{ compiler ? "ghc8104"
, system ? builtins.currentSystem
, pkgs ? import ./dep/nixpkgs { inherit system; }
}:

let
  inherit (pkgs) lib;
  inherit (pkgs.lib.trivial) flip pipe;
  inherit (pkgs.haskell.lib) appendPatch appendConfigureFlags overrideCabal;
  nodePkgs = (pkgs.callPackage ./dep/node { inherit pkgs; nodejs = pkgs.nodejs-12_x; }).shell.nodeDependencies;

    
  haskellPackages = pkgs.haskell.packages.${compiler}.override {
    overrides = hpNew: hpOld: rec {
      mkDerivation = args: hpOld.mkDerivation (args // {
        doCheck = false;
        doHaddock = false;
        enableLibraryProfiling = false;
        enableExecutableProfiling = false;
        jailbreak = true;
      });


      haskell-foundation = hpNew.callCabal2nix "haskell-foundation" (pkgs.stdenv.lib.cleanSource ./haskell) { };
      
      hakyll =
        pipe
          hpOld.hakyll
          [ (flip appendConfigureFlags [ "-f" "watchServer" "-f" "previewServer" ])
          ];
      
      ListLike = pkgs.haskell.lib.overrideCabal hpOld.ListLike {
        version = "4.7.3";
	sha256 = "1vk5mbpxzwzcnc4cgw3hvqn0g0pcq97hw4f3i2ki3hn3svap535a";
        doCheck = false;
        doHaddock = false;
        enableLibraryProfiling = false;
        enableExecutableProfiling = false;
	jailbreak = true;
      };  
    };
  };

  project = haskellPackages.haskell-foundation;
in
{
  inherit project nodePkgs;

  site = pkgs.runCommand "haskell-foundation" {
    nativeBuildInputs = [ nodePkgs project ];

    NODE_PATH = "${nodePkgs}/lib/node_modules";

    LOCALE_ARCHIVE = lib.optionalString
      (pkgs.stdenv.hostPlatform.libc == "glibc")
      "${pkgs.buildPackages.glibcLocales}/lib/locale/locale-archive";
    LANG = "en_US.UTF-8";
  } ''
    cp --no-preserve=mode -r ${./site} site
    echo $LOCALE_ARCHIVE
    cd site
    site build
    mv _site $out
  '';

  shell = haskellPackages.shellFor {
    packages = p: with p; [
      haskell-foundation
    ];
    nativeBuildInputs = with haskellPackages.buildHaskellPackages; [
      ghcid
      hlint
      nodePkgs
      cabal-install
    ];
    NODE_PATH = "${nodePkgs}/lib/node_modules";
    withHoogle = true;
  };
}
