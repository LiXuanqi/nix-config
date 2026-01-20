{
  config,
  pkgs,
  lib,
  home-manager,
  inputs,
  ...
}:
let
  user = "lixuanqi";
in
# sharedFiles = import ../shared/files.nix { inherit config pkgs; };
{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {

        imports = [
          ../shared/home.nix
        ];

        home = {
          stateVersion = "24.11";
          packages = pkgs.callPackage ./packages.nix { inherit inputs; };
          # file = lib.mkMerge [
          #   sharedFiles
          # ];
          # sessionVariables = {
          #   EDITOR = "nvim";
          # };
          # file = {
          #   ".config" = {
          #     source = ../../dotfiles/.config;
          #     recursive = true;
          #   };
          # };
          file = {
            ".config/wezterm" = {
              source = ../../dotfiles/.config/wezterm;
              recursive = true;
            };
            # ".config" = {
            #   source = ../../dotfiles/.config;
            #   recursive = true;
            # };
            # ".config/emacs" = {
            #   source = config.lib.file.mkOutOfStoreSymlink "/Users/lixuanqi/dev/nix-config/dotfiles/.config/emacs";
            #   recursive = true;
            # };
            # "crafted-emacs" = {
            #   source = ../../dotfiles/crafted-emacs;
            #   recursive = true;
            # };
          };
        };
        programs = { } // import ../shared/programs.nix { inherit config pkgs lib; };
      };
  };
}
