{ config, pkgs, ...}: {
  home.username = "lixuanqi";
  home.homeDirectory = "/home/lixuanqi";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = ["$HOME/.config/emacs/bin"];

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
  programs.git = {
    enable = true;
    userName = "1_x7";
    userEmail = "lixuanqi1995@gmail.com";
  };
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      "nx cd" = "cd ~/dev/nix-config";
      "nx b" = "sudo nixos-rebuild switch --flake .#nixos";
    };
    # enableCompletion = true;
    # autosuggestion.enable = true;
    # syntaxHighlighting.enable = true;
    # history.size = 10000;
    # history.ignoreAllDups = true;
    # history.path = "$HOME/.zsh_history";
  };
  programs.starship = {
    enable = true;
    # settings = {};
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
