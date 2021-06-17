{ pkgs
, enableNix
, enableLua
, enableRust
, enableGolang
, enableTerraform
, enableBash
, enableCpp
, enableMake
, enableVim
, enableYaml
, enableDocker
, enableJson
, ...
}:
with pkgs;
[
  # neovim
  neovim-nightly
  python3
  python3Packages.pynvim

  # tools
  fzf
  bat
  ripgrep

  # lint/format
  efm-langserver
] ++ (
  if enableNix then [
    # nix
    rnix-lsp
    nixfmt
  ] else
    []
) ++ (
  if enableLua then [
    # lua
    sumneko-lua-language-server
    lua5_3
    lua-format
  ] else
    []
) ++ (
  if enableRust then [
    # rust
    rust-analyzer
    rustup
  ] else
    []
) ++ (
  if enableGolang then [
    # golang
    go
    gocode
    gopls
  ] else
    []
) ++ (
  if enableTerraform then [
    # terraform
    terraform_0_15
    terraform-ls
    tflint
  ] else
    []
) ++ (
  if enableBash then [
    # bash
    shellcheck
    shfmt
    nodePackages.bash-language-server
  ] else
    []
) ++ (
  if enableCpp then [
    # cpp
    gcc
    poco
    cmake
    clang-tools
    cppcheck
  ] else
    []
) ++ (
  if enableMake then
    [
      # make
      checkmake
    ]
  else
    []
) ++ (
  if enableVim then
    [
      # VIM
      vim-vint
    ]
  else
    []
) ++ (
  if enableYaml then [
    # yaml
    nodePackages.yaml-language-server
    yamllint
  ] else
    []
) ++ (
  if enableDocker then
    [
      # docker
      hadolint
    ]
  else
    []
) ++ (
  if enableJson then [
    # json
    nodePackages.vscode-json-languageserver-bin
    nodePackages.fixjson
    jq
  ] else
    []
)
