{ config, pkgs, ... }:

{
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
      # Add brew packages here as needed
    ];

    # Install GUI applications from Homebrew Cask
    casks = [
      # Add casks here as needed
    ];

    # Configure Homebrew taps
    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers" 
      "homebrew/cask-fonts"
      # Add custom taps as needed
    ];

    # Install Mac App Store applications
    masApps = {
      # Add Mac App Store applications here using their IDs
    };
  };
}