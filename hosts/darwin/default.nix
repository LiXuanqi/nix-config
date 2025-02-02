{
  self,
  config,
  nixpkgs,
  pkgs,
  fenix,
  ...
}:
{

  imports = [
    ../../modules/darwin/home.nix
    ../../modules/shared
  ];

  nix = {
    package = pkgs.nix;
    gc = {
      user = "root";
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
    ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  # TODO: move to a shared file
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];
}
