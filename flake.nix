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
        modules = [
          home-manager.darwinModules.home-manager
          (import ./systems/vanguard/darwin.nix {
            homeModules = [
              (import ./modules/zsh.nix {})
              (import ./modules/git.nix {
                signatures = signatures;
                signing_key = signatures.vanguard;
              })
              (import ./modules/neovim.nix {absolute_path_to_project = "/Users/Jens/Development/config";})
              ./modules/rust.nix
            ];
          })
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
      wyvern = homeManager "x86_64-linux" [
        ./systems/wyvern/home.nix
        (import ./modules/zsh.nix {
          aliases = {
            "reflect" = "sudo systemctl start reflector";
          };
        })
        (import ./modules/git.nix {
          signatures = signatures;
          signing_key = signatures.wyvern;
        })
        (import ./modules/neovim.nix {absolute_path_to_project = "/home/jens/dev/config";})
        ./modules/rust.nix

        ./modules/linux/fontconfig.nix
        ./modules/linux/fuzzel.nix
        (import ./modules/linux/kitty.nix { install = false; })
        (import ./modules/linux/sway.nix {
          menu = "fuzzel";
          terminal = "kitty";
          bar = "waybar";
        })
        ./modules/linux/waybar.nix
      ];
    };
  };
}
