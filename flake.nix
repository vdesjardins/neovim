{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.neovim-nightly-overlay.overlay ];
          };

          legacyPackages = import ./nix/packages.nix { inherit pkgs; };
        in
          {
            devShell = pkgs.mkShell {
              buildInputs = legacyPackages;
            };

            legacyPackages = legacyPackages;
          }
    )
    // {
      overlay = inputs.neovim-nightly-overlay.overlay;
      hmModule = import ./nix/neovim.nix;
    };
}
