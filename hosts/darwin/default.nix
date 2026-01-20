{
  inputs,
  config,
  nixpkgs,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ../../modules/darwin/home.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/shared
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  system = {
    primaryUser = "lixuanqi";

    stateVersion = 5;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  environment.systemPackages =
    with pkgs;
    [
    ]
    ++ (import ../../modules/shared/packages.nix { inherit pkgs inputs; });

  fonts.packages = import ../../modules/shared/packages/fonts.nix { inherit pkgs; };

  # Homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = "lixuanqi";
    autoMigrate = true; # Automatically migrate existing Homebrew installations
    
    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "LiXuanqi/xgit" = inputs.homebrew-xgit;
    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    # Temporarily set to true to allow permission fixes
    mutableTaps = true;
  };

 # Path fix for GUI applications.
  # Update the launchd configuration to be more comprehensive
  launchd.user.envVariables = {
    PATH = lib.concatStringsSep ":" [
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
      "/opt/homebrew/bin"
      "/usr/local/bin"
      "/usr/bin"
      "/usr/sbin"
      "/bin"
      "/sbin"
    ];
    # Add NIX_PATH to ensure nix-related tools work properly
    # NIX_PATH = "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels";
  };
}
