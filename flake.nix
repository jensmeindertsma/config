{
  description = "I hereby declare the contents of this file to describe the state of the universe";

  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager.url = "github:nix-community/home-manager/release-24.05";
  };

  outputs = inputs @ {
    self,
    nixpkgs-darwin,
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
  };
}
