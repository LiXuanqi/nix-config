{
  description = "NixOS + darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ags.url = "github:aylur/ags";
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-darwin, hyprland, ... }: {

    darwinConfigurations."1x7s-Laptop" = 
    nix-darwin.lib.darwinSystem {
	specialArgs = inputs;
	modules = [
	  home-manager.darwinModules.home-manager
         ./hosts/darwin
	];
      };


    # nixosConfigurations = {
    #   # nixos is host name
    #   nixos = nixpkgs.lib.nixosSystem rec {
    #     system = "x86_64-linux";
    #     specialArgs = {inherit inputs;};
    #     modules = [
    #       ./configuration.nix
    #       home-manager.nixosModules.home-manager
    #       {
    #
    #         home-manager.extraSpecialArgs = specialArgs;
    #         home-manager.useGlobalPkgs = true;
    #         home-manager.useUserPackages = true;
    #         home-manager.users.lixuanqi = import ./home.nix;
    #
    #         # Optionally, use home-manager.extraSpecialArgs to pass
    #         # arguments to home.nix
    #       }
    #     ];
    #   };
    # };
  };
}
