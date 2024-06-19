{
  description = "A single (snow)flake that produces all my configuration for all my devices";

  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs @ {
    self,
    nixpkgs-darwin,
    nix-darwin,
    home-manager,
    nix-vscode-extensions,
  }: {
    darwinConfigurations.badger = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        (import ./machines/badger/configuration.nix inputs)
      ];
    };
  };
}
