{ pkgs, ... }:
# Re-export from new modular structure
import ./packages/default.nix { inherit pkgs; }
