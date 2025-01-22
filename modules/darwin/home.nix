{config, pkgs, lib, home-manager, ...}:
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
    users.${user} = { pkgs, config, lib, ...}: {
      home = {
        stateVersion = "24.11";
        packages = pkgs.callPackage ./packages.nix {};
        # file = lib.mkMerge [
        #   sharedFiles
        # ];
	# This doesn't work on mac
	sessionPath = ["$HOME/.config/emacs/bin"];
	file = {
	  ".config/doom" = {
	    source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/doom;
	    recursive = true;
	  };
	}; 
      };
      programs = {} // import ../shared/programs.nix {inherit config pkgs lib;};
    };
  };
}
