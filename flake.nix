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

    git = key: (import ./modules/git.nix {
      signatures = signatures;
      signing_key = key;
    });

    neovim = source: (import ./modules/neovim.nix {
      source = source;
    });

    vscode = {
      source,
      destination,
    }: (import ./modules/vscode.nix {
      source = source;
      destination = destination;
    });
  in {
    darwinConfigurations = {
      vanguard = let
        root = "/Users/Jens/Development/config";
      in
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = nixpkgs-darwin.legacyPackages."aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            (import ./systems/vanguard/darwin.nix {
              homeModules = [
                ./modules/tools.nix
                (import ./modules/zsh.nix {
                  install = false;
                })
                (git signatures.vanguard)
                (neovim root)
                ./modules/rust.nix
                (vscode {
                  source = root;
                  destination = "/Users/Jens/Library/Application Support/Code/User";
                })
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
      wyvern = let
        root = "/home/jens/dev/config";
      in
        homeManager "x86_64-linux" [
          ./systems/wyvern/home.nix
          ./modules/tools.nix
          (import ./modules/zsh.nix {
            install = true;
            aliases = {
              "reflect" = "sudo systemctl start reflector";
            };
          })
          (git signatures.wyvern)
          (neovim root)

          ./modules/linux/fontconfig.nix

          (import ./modules/linux/sway.nix {
            install = false;
            scale = "2";
            wallpaper = "~/Pictures/Wallpapers/2.jpg";
          })

          (vscode {
            source = root;
            destination = "~/.config/Code/User";
          })
        ];
    };
  };
}
