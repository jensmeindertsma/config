{
  description = "A single (snow)flake that produces all my configuration for all my devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-darwin, nix-darwin, home-manager }:
  {
    # nixosConfigurations.vanguard = nixpkgs.lib.nixosSystem {
    #     system = "x86_64-linux";
    #     modules = [
    #       home-manager.nixosModules.home-manager
    #       ./machines/vanguard/configuration.nix
    #     ];
    #   };
    darwinConfigurations.badger = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [ 
        home-manager.darwinModules.home-manager
        ./machines/badger/configuration.nix
      ];
    };
  };
}
