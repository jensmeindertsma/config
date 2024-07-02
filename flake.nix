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
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
  }: {
    darwinConfigurations.vanguard = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./systems/vanguard/darwin.nix
        (./modules/home.nix
          {
            config = ./systems/vanguard/home.nix;
            ssh = ./systems/vanguard/home/ssh.nix;
          })
        ./modules/vscode.nix
      ];
    };

    homeConfigurations = let
      homeManager = system: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = modules;
        };
    in {
      wyvern = let
        home = import ./modules/home.nix {
          config = import ./systems/wyvern/home.nix;

          shell.aliases = {
            reflect = "sudo systemctl start reflector";
          };

          ssh = import ./systems/wyvern/home/ssh.nix;
        };
        sway = import ./modules/sway.nix {
          install = false;
          menu = "fuzzel";
          terminal = "kitty";
          bar = "waybar";
        };
        kitty = import ./modules/kitty.nix {
          install = false;
        };
      in
        homeManager "x86_64-linux" [
          home
          sway
          (import
            ./modules/fuzzel.nix)
          kitty
          (import
            ./modules/waybar.nix)
          (import
            ./modules/fontconfig.nix)
        ];
    };
  };
}
