{
  description = "I hereby declare this file the state of the universe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
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
      anna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHXKzgKhtwMk6R5/3aaJrq99VazfnzpfbfNvMojNx8bt";
      vanguard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG0u2sQkfE5QvH8xv7ZaY4lvca3aAZQX1cljJmNsNqx";
      wyvern = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhI5sNxApLWYWOKljGuaVzt/6rsAVlAlb2lKv0nPHyD";
    };

    git = key:
      import ./modules/git.nix {
        signatures = signatures;
        signing_key = key;
      };

    neovim = source:
      import ./modules/neovim.nix {
        source = source;
      };

    tools = ./modules/tools.nix;

    vscode = {
      source,
      destination,
    }:
      import ./modules/vscode.nix {
        source = source;
        destination = destination;
      };

    zsh = options: import ./modules/zsh.nix options;
  in {
    nixosConfigurations = {
      anna = let
        root = "/home/jens/Development/config";
        home = import ./systems/anna/home.nix;
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./systems/anna/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jens = home [
                tools
                (git signatures.anna)
                (zsh {
                  })
                (neovim root)

                # TODO: try hyprland

                # fontconfig
                # (theme {
                #   enableKitty = true;
                #   binaryName = "toggle-theme";
                # })
                # (sway {
                #   install = false;
                #   scale = "1.5";
                #   wallpaper = "~/Pictures/Wallpapers/001.jpg";
                #   theme.toggleCommand = "toggle-theme";
                # })
                # (vscode {
                #   source = root;
                #   destination = "/home/jens/.config/Code/User";
                # })
              ];
            }
          ];
        };
    };

    darwinConfigurations = {
      vanguard = let
        root = "/Users/Jens/Development/jensmeindertsma/config";
        darwin = import ./systems/vanguard/darwin.nix;
        home = modules: import ./systems/vanguard/home.nix modules;
      in
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = nixpkgs-darwin.legacyPackages."aarch64-darwin";
          modules = [
            darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jens = home [
                tools
                (git signatures.vanguard)
                (zsh {})
                (neovim root)
                (vscode {
                  source = root;
                  destination = "/Users/Jens/Library/Application Support/Code/User";
                })
              ];
            }
          ];
        };
    };

    homeConfigurations = let
      homeManager = system: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = modules;
        };

      fontconfig = ./modules/fontconfig.nix;
      theme = options: import ./modules/theme.nix options;
      sway = options: import ./modules/sway.nix options;
    in {
      wyvern = let
        root = "/home/jens/Development/jensmeindertsma/config";
        home = import ./systems/wyvern/home.nix;
      in
        homeManager "x86_64-linux" [
          home
          tools
          (zsh {
            aliases = {
              "reflect" = "sudo systemctl start reflector";
            };
          })
          (git signatures.wyvern)
          (neovim root)
          fontconfig
          (theme {
            enableKitty = true;
            binaryName = "toggle-theme";
          })
          (sway {
            scale = "2";
            wallpaper = "~/Pictures/Wallpapers/3.jpg";
            theme.toggleCommand = "toggle-theme";
          })
          (vscode {
            source = root;
            destination = "/home/jens/.config/Code/User";
          })
        ];
    };
  };
}
