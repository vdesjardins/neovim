{ config, pkgs, lib, ... }:
{
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
    };
  };

  xdg.configFile."nvim/lua".source = ../lua;
}
