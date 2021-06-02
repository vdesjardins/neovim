{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # tools
    efm-langserver.url = "github:mattn/efm-langserver";
    efm-langserver.flake = false;
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.neovim-nightly-overlay.overlay ];
          };

          legacyPackages = pkgs.callPackage ./nix/packages.nix { inherit inputs; };
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
