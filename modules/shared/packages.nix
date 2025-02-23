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
