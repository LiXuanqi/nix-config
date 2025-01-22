{pkgs}: 
with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; };
in
shared-packages ++ [
  # command line tool for managing dock items
  dockutil
  # web browser
  arc-browser
]
