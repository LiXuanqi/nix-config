{ config, ... }:
{
  # TODO: This file is not in used

  # ".config/doom" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/.config/doom;
  #   recursive = true;
  # };
  # ".config" = {
  #   source = ./dotfiles/.config;
  #   recursive = true;
  # };

  ".config/emacs" = {
    source = config.lib.file.mkOutOfStoreSymlink "/Users/lixuanqi/dev/nix-config/dotfiles/.config/emacs";
    recursive = true;
  };
}
