{ config, pkgs, lib, ... }:
let cfg = config.programs.neovim;
in {
  options.programs.neovim = with lib; {
    enableNix = mkEnableOption "Nix component" // { default = true; };
    enableLua = mkEnableOption "Lua component" // { default = true; };
    enableRust = mkEnableOption "Rust component" // { default = true; };
    enableGolang = mkEnableOption "Go component" // { default = true; };
    enableTerraform = mkEnableOption "Terraform component" // {
      default = true;
    };
    enableBash = mkEnableOption "Bash component" // { default = true; };
    enableCpp = mkEnableOption "C++ component" // { default = true; };
    enableMake = mkEnableOption "Make component" // { default = true; };
    enableVim = mkEnableOption "VIM component" // { default = true; };
    enableYaml = mkEnableOption "YAML component" // { default = true; };
    enableDocker = mkEnableOption "Docker component" // { default = true; };
    enableJson = mkEnableOption "JSON component" // { default = true; };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      package = pkgs.neovim-nightly;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      withPython3 = true;

      withNodeJs = true;

      withRuby = false;

      extraConfig = ''
        lua require('init')
      '';

      extraPackages = import ./packages.nix {
        inherit pkgs;
        inherit (cfg)
          enableNix enableLua enableRust enableGolang enableTerraform enableBash
          enableCpp enableMake enableVim enableYaml enableDocker enableJson;
      };
    };

    xdg.configFile."nvim/lua".source = ../lua;
  };
}
