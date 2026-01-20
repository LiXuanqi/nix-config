{ pkgs, inputs, ... }:
let
  # Import all package categories
  development = {
    rust = import ./development/rust.nix { inherit pkgs; };
    web = import ./development/web.nix { inherit pkgs; };
    python = import ./development/python.nix { inherit pkgs; };
    go = import ./development/go.nix { inherit pkgs; };
  };
  editors = import ./editors.nix { inherit pkgs; };
  tools = import ./tools.nix { inherit pkgs inputs; };
in
# Combine all package lists
tools
++ editors
++ development.rust
++ development.web
++ development.python
++ development.go
