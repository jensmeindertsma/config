{
  description = "I hereby declare this file the state of the universe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nixgl,
  }: {
    darwinConfigurations.vanguard = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./systems/vanguard/configuration.nix
      ];
    };
    homeConfigurations = let
      homeManager = system: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              nixgl.overlay
              (final: prev: {
                lib =
                  prev.lib
                  // {
                    foo = bar: "baz";
                  };
              })
            ];
          };
          modules = modules;
        };
    in {
      wyvern = homeManager "x86_64-linux" [
        import
        ./systems/wyvern/home.nix
      ];
    };
  };
}
