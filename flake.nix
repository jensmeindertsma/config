{
  description = "I hereby declare this file the state of the universe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = { 
      url = "github:nix-community/home-manager/release-24.05"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
  }: {
    darwinConfigurations.vanguard = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./systems/vanguard/configuration.nix
      ];
    };
    homeConfigurations = {
      isac = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        modules = [
          ./systems/isac/home.nix
        ];
      };
      
      wyvern = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        modules = [
          ./systems/wyvern/home.nix
        ];
      };
    };
  };
}
