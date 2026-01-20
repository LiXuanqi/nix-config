{ pkgs, inputs, ... }:
with pkgs;
[
  git
  nixfmt-rfc-style
  inputs.codex-cli-nix.packages.${pkgs.system}.default
  # gnumake
  # cmake
  # libtool
]
