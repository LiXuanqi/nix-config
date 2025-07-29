{ pkgs, ... }:
with pkgs;
[
  git
  neovim
  (import ./emacs.nix { inherit pkgs; })

  nodejs
  # typescript-language-server
  # typescript
  # nodePackages.prettier
  claude-code
  copilot-language-server

  python3
  python3Packages.pip

  # gnumake
  # cmake
  # libtool

  nixfmt-rfc-style

  (fenix.complete.withComponents [
    "cargo"
    "clippy"
    "rust-src"
    "rustc"
    "rustfmt"
  ])
  rust-analyzer-nightly

]
