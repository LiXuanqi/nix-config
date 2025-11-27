{ pkgs, ... }:
with pkgs;
[
  neovim
  (import ../emacs.nix { inherit pkgs; })
]