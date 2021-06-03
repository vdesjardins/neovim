{ pkgs, ... }:
with pkgs; [
  # neovim
  neovim-nightly
  python3
  python3Packages.pynvim

  # nix
  rnix-lsp
  nixfmt

  # lua
  sumneko-lua-language-server
  lua5_3
  lua-format

  # rust
  rust-analyzer
  rustup

  # golang
  go
  gocode
  gopls

  # terraform
  terraform
  terraform-ls
  tflint

  # bash
  shellcheck
  shfmt
  nodePackages.bash-language-server

  # cpp
  gcc
  poco
  cmake
  clang-tools
  cppcheck

  # make
  checkmake

  # VIM
  vim-vint

  # markdown

  # yaml
  nodePackages.yaml-language-server
  yamllint

  # docker
  hadolint

  # json
  nodePackages.vscode-json-languageserver-bin
  nodePackages.fixjson
  jq

  # tools
  fzf
  bat
  ripgrep

  # lint/format
  efm-langserver
]
