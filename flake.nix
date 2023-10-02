{
  description = "Haskell Foundation Website";

  inputs.stacklock2nix.url = "github:cdepillabout/stacklock2nix/main";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, stacklock2nix }:
    let
      # System types to support.
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

      nixpkgsFor =
        forAllSystems (system: import nixpkgs { inherit system; overlays = [ stacklock2nix.overlay self.overlay ]; });
    in
    {
      overlay = import nix/overlay.nix;

      devShells = forAllSystems (system: {
        haskell-foundation-dev-shell = nixpkgsFor.${system}.haskell-foundation-dev-shell;
      });

      devShell = forAllSystems (system: self.devShells.${system}.haskell-foundation-dev-shell);
    };
}

