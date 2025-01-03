{pkgs ? import <nixpkgs> {}}:
let 
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages;
in
emacsWithPackages(epkgs: with epkgs; [
  treesit-grammars.with-all-grammars
])

