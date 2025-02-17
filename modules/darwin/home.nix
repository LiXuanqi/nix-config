{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:
let
  user = "lixuanqi";
  # sharedFiles = import ../shared/files.nix { inherit config pkgs; };
in
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
        home = {
          stateVersion = "24.11";
          packages = pkgs.callPackage ./packages.nix { };
          # file = lib.mkMerge [
          #   sharedFiles
          # ];
          sessionVariables = {
              EDITOR = "nvim";
          }; 
          # This doesn't work on mac
          sessionPath = [ "$HOME/.config/emacs/bin" ];
          # file = {
          #   ".config" = {
          #     source = ../../dotfiles/.config;
          #     recursive = true;
          #   };
          # };
          file = {
            ".config" = {
              source = ../../dotfiles/.config;
              recursive = true;
            };
            ".config/emacs" = {
              source = config.lib.file.mkOutOfStoreSymlink "/Users/lixuanqi/dev/nix-config/dotfiles/.config/emacs";
              recursive = true;
            };
          };
        };
        programs = { } // import ../shared/programs.nix { inherit config pkgs lib; };
      };
  };
}
