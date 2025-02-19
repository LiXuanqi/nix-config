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
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlays.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nix-darwin,
      hyprland,
      fenix,
      emacs-overlay,
      ...
    }:
    {
      packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
      packages.aarch64-darwin.default = fenix.packages.aarch64-darwin.minimal.toolchain;

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;

      darwinConfigurations."1x7s-Laptop" = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/darwin
        ];
      };

      nixosConfigurations = {
        # nixos is host name
        nixos = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/nixos
            home-manager.nixosModules.home-manager
            {
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lixuanqi = import ./modules/nixos/home.nix;
            }
          ];
        };
      };
    };
}
