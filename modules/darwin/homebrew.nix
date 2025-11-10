{ config, pkgs, ... }:

{
  # Optional: Align homebrew taps config with nix-homebrew
  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # Remove unlisted formulae, casks, and taps
      autoUpdate = true; # Automatically update Homebrew
      upgrade = true; # Upgrade installed formulae and casks
    };

    # Configure global settings
    global = {
      brewfile = true; # Use a Brewfile for managing packages
    };

    # Install packages from Homebrew that are either not available in nixpkgs
    # or better maintained upstream
    brews = [
      "LiXuanqi/xgit/xgit"
    ];

    # Install GUI applications from Homebrew Cask
    casks = [
      # Add casks here as needed
    ];

    # Configure Homebrew taps (managed by nix-homebrew)
    # taps are now managed declaratively via nix-homebrew.taps

    # Install Mac App Store applications
    masApps = {
      # Add Mac App Store applications here using their IDs
    };
  };
}