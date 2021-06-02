{ pkgs, ... }:
let
  lua-format = pkgs.stdenv.mkDerivation {
    name = "lua-format";

    src = pkgs.fetchgit {
      url = "https://github.com/Koihik/LuaFormatter.git";
      rev = "78b3d90ca49818bc72ef4ec39409924c33daa020";
      sha256 = "0snfh4h9s0xb2cayyqzjjqg4b0vq589ln2yb0ci5n2xm15dchycl";
      fetchSubmodules = true;
    };

    buildInputs = with pkgs; [ cmake ];
  };
in
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
    # clippy
    # cargo
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
  ]
