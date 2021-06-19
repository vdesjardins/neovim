{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # tools
    efm-langserver.url = "github:mattn/efm-langserver";
    efm-langserver.flake = false;
    # lua-format.url = "github.com:Koihik/LuaFormatter";
    # lua-format.flake = false;
    # TODO: does not work yet
    # lua-format.submodules = true;
  };

  outputs = { self, ... }@inputs:
    let
      tools-overlay = import ./nix/overlay.nix inputs;
    in
      inputs.flake-utils.lib.eachDefaultSystem (
        system:
          let
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [ inputs.neovim-nightly-overlay.overlay tools-overlay ];
            };

            legacyPackages = import ./nix/packages.nix {
              inherit pkgs;
              enableNix = true;
              enableLua = true;
              enableRust = true;
              enableGolang = true;
              enableTerraform = true;
              enableBash = true;
              enableCpp = true;
              enableMake = true;
              enableVim = true;
              enableYaml = true;
              enableDocker = true;
              enableJson = true;
            };
          in
            {
              devShell = pkgs.mkShell { buildInputs = legacyPackages; };

              legacyPackages = legacyPackages;
            }
      ) // {
        overlays = {
          neovim-nightly = inputs.neovim-nightly-overlay.overlay;
          tools = tools-overlay;
        };

        hmModule = import ./nix/neovim.nix;
      };
}
