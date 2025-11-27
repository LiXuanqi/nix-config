{ pkgs, ... }:
with pkgs;
[
  python3
  python3Packages.pip
  uv
  pyright
]