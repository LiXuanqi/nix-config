{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  user = "lixuanqi";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
in
{
  imports = [
    ./hyprland.nix
    inputs.ags.homeManagerModules.default
    ../shared/home.nix
  ];
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "24.11";
    file = lib.mkMerge [
      sharedFiles
    ];
  };

  programs = {
    ags = {
      enable = true;
      configDir = null;
      extraPackages = with pkgs; [
        inputs.ags.packages.${pkgs.system}.battery
        inputs.ags.packages.${pkgs.system}.hyprland
        inputs.ags.packages.${pkgs.system}.mpris
        inputs.ags.packages.${pkgs.system}.network
        inputs.ags.packages.${pkgs.system}.tray
        inputs.ags.packages.${pkgs.system}.wireplumber
      ];

    };
  } // import ../shared/programs.nix { inherit config pkgs lib; };

  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };

  # home.file.".config" = {
  #   source = ../../dotfiles/.config;
  #   recursive = true;
  # };

  # home.file.".config/doom" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/.config/doom;
  #   recursive = true;
  # };

  # programs.home-manager.enable = true;
  # programs.neovim.enable = true;

}
