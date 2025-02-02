{ config, ... }:
{
  # ".config/doom" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/.config/doom;
  #   recursive = true;
  # };
  ".config" = {
    source = ./dotfiles/.config;
    recursive = true;
  };
}
