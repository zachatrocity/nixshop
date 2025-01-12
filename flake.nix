{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    textfox.url = "github:adriankarlen/textfox";
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-stable,
      ghostty,
      home-manager,
      hyprland,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          hyprland.overlays.default
        ];
      };
    in
    {
      nixosConfigurations = {
        nixshop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.zach = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs pkgs; pkgs-stable = import nixpkgs-stable { 
                inherit system;
                config.allowUnfree = true;
              }; };
              nixpkgs.config.allowUnfree = true;

              environment.systemPackages = [
                ghostty.packages.x86_64-linux.default
                inputs.zen-browser.packages.${system}.default
              ];
            }
          ];
        };
      };
    };
}
