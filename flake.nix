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
          pkgs,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [
              # Node; pinned to same version as CI.
              pkgs.nodejs_24

              # Haskell.
              pkgs.cabal-install
              pkgs.ghc
              pkgs.haskell-language-server
            ];
          };
        };
      flake = { };
    };
}
