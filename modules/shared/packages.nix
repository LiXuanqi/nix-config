{ pkgs, ...} : 
with pkgs; [
  git
  neovim
  (import ./emacs.nix {inherit pkgs;})
]
