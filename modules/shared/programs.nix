{
  config,
  pkgs,
  lib,
  ...
}:
{
  zsh = {
    enable = true;
    shellAliases = {
      # "nxcd" = "cd ~/dev/nix-config";
      # "nxb" = "sudo nixos-rebuild switch --flake .#nixos";
    };
    # enableCompletion = true;
    # autosuggestion.enable = true;
    # syntaxHighlighting.enable = true;
    # history.size = 10000;
    # history.ignoreAllDups = true;
    # history.path = "$HOME/.zsh_history";
  };

  git = {
    enable = true;
    userName = "1_x7";
    userEmail = "lixuanqi1995@gmail.com";
  };

  wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  starship = {
    enable = true;
    # settings = {};
  };
  fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
