{ config, pkgs, lib, ... }:
let
  cfg = config.programs.neovim;
in
{
  options.programs.neovim = with lib; {
    enableNix = mkEnableOption "Nix component" // { default = false; };
    enableLua = mkEnableOption "Lua component" // { default = false; };
    enableRust = mkEnableOption "Rust component" // { default = false; };
    enableGolang = mkEnableOption "Go component" // { default = false; };
    enableTerraform = mkEnableOption "Terraform component" // {
      default = false;
    };
    enableBash = mkEnableOption "Bash component" // { default = false; };
    enableCpp = mkEnableOption "C++ component" // { default = false; };
    enableMake = mkEnableOption "Make component" // { default = false; };
    enableVim = mkEnableOption "VIM component" // { default = false; };
    enableYaml = mkEnableOption "YAML component" // { default = false; };
    enableDocker = mkEnableOption "Docker component" // { default = false; };
    enableJson = mkEnableOption "JSON component" // { default = false; };
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
    };

    home.packages = import ./packages.nix {
      inherit pkgs;
      inherit (cfg)
        enableNix enableLua enableRust enableGolang enableTerraform enableBash
        enableCpp enableMake enableVim enableYaml enableDocker enableJson
        ;
    };

    xdg.configFile."nvim/lua".source = ../lua;
    xdg.configFile."nvim/init.lua".source = ../init.lua;
  };
}
