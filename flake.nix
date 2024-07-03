{
  description = "I hereby declare this file the state of the universe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-darwin,
    nix-darwin,
    home-manager,
  }: let
    signatures = {
      vanguard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG0u2sQkfE5QvH8xv7ZaY4lvca3aAZQX1cljJmNsNqx";
      wyvern = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhI5sNxApLWYWOKljGuaVzt/6rsAVlAlb2lKv0nPHyD";
    };
  in {
    darwinConfigurations = {
      vanguard = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = nixpkgs-darwin.legacyPackages."aarch64-darwin";
        modules = let
          homeModules = [
            (import ./modules/shell.nix)
            (import ./modules/git.nix { signatures = signatures; signing_key = signatures.vanguard;})
            (import ./modules/homebrew.nix)
          ];
          configuration = import ./systems/vanguard/darwin.nix homeModules;
        in [
          home-manager.darwinModules.home-manager
          configuration
        ];
      };
    };

    homeConfigurations = let
      homeManager = system: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = modules;
        };
    in {
      wyvern = homeManager "x86_64-linux" [];
    };
  };
}
