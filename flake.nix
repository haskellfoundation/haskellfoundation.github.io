{
  description = "Minimal Hakyll and Tailwind development environment";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          lib,
          pkgs,
          ...
        }:
        let
          haskellPkgs = pkgs.haskellPackages;

          # Only the Haskell sources; the site content is read at run time.
          src = lib.fileset.toSource {
            root = ./.;
            fileset = lib.fileset.unions [
              ./haskell-foundation.cabal
              ./site.hs
              ./tools/social-crossposting
            ];
          };

          haskell-foundation = haskellPkgs.callCabal2nix "haskell-foundation" src { };
        in
        {
          packages.default = haskell-foundation;

          devShells.default = haskellPkgs.shellFor {
            packages = _: [ haskell-foundation ];

            nativeBuildInputs = [
              # Node; pinned to same version as CI.
              pkgs.nodejs_24

              # Haskell.
              pkgs.cabal-install
              pkgs.haskell-language-server

              # Screenshotting pages during design work.
              (pkgs.python3.withPackages (ps: [ ps.playwright ]))
            ];

            env = {
              PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
              PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
            };
          };
        };
      flake = { };
    };
}
