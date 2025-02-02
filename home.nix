{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./modules/hyprland.nix
    inputs.ags.homeManagerModules.default
  ];
  home.username = "lixuanqi";
  home.homeDirectory = "/home/lixuanqi";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [ "$HOME/.config/emacs/bin" ];

  home.file.".config" = {
    source = ./dotfiles/.config;
    recursive = true;
  };

  home.file.".config/doom" = {
    source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/doom;
    recursive = true;
  };

  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.ags = {
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
}
