{
  description = "I hereby declare this file the state of the universe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
  };

  outputs = {
    home-manager,
    lanzaboote,
    nixpkgs,
    nix-darwin,
    nix-vscode-extensions,
    ...
  } @ inputs: let
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

    neovim = options:
      import ./modules/neovim.nix options;

    tools = options: import ./modules/tools.nix options;

    hyprland = options: import ./modules/hyprland.nix options;

    fontconfig = ./modules/fontconfig.nix;
    theme = options: import ./modules/theme.nix options;

    kitty = ./modules/kitty.nix;
    fuzzel = ./modules/fuzzel.nix;

    vscode = options: import ./modules/vscode.nix options;
    zsh = options: import ./modules/zsh.nix options;
  in {
    nixosConfigurations = {
      anna = let
        root = "/home/jens/Development/jensmeindertsma/config";
        home = import ./systems/anna/home.nix;

        desktop = hyprland {
          terminal = "kitty";
          launcher = "fuzzel";
          toggle_theme_command = "toggle-theme";
          monitor = "DP-1,3840x2160@60,0x0,1.5";
          monitor_name = "DP-1";
          wallpaper = "~/Pictures/Wallpapers/Fantasy-Landscape3.png";
          lockscreen.wallpaper = "~/Pictures/Wallpapers/MountainRainCloudsFall.png";
        };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./systems/anna/configuration.nix
            lanzaboote.nixosModules.lanzaboote
            ({
              pkgs,
              lib,
              ...
            }: {
              environment.systemPackages = [
                pkgs.sbctl
              ];

              # Lanzaboote currently replaces the systemd-boot module.
              # This setting is usually set to true in configuration.nix
              # generated at installation time. So we force it to false
              # for now.
              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/etc/secureboot";
              };
            })

            desktop.system

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jens = home [
                (tools {})
                (git signatures.anna)
                (zsh {
                  aliases = {
                    vim = "nvim";
                  };
                })
                (neovim {source = root;})

                desktop.home

                fontconfig
                (theme {
                  enableKitty = true;
                  binaryName = "toggle-theme";
                })

                kitty
                fuzzel
                (vscode {
                  library = nix-vscode-extensions.extensions."x86_64-linux";
                  colorTheme = {
                    light = "Tokyo Night Light";
                    dark = "Tokyo Night";
                  };
                })
              ];
            }
          ];
        };

      wyvern = let
        root = "/home/jens/Development/jensmeindertsma/config";
        home = import ./systems/wyvern/home.nix;

        desktop = hyprland {
          terminal = "kitty";
          launcher = "fuzzel";
          toggle_theme_command = "toggle-theme";
          monitor = "DP-1,2650x1600@60,0x0,1";
          monitor_name = "eDP-1";
          wallpaper = "~/Pictures/Wallpapers/Manga-Portal.png";
          lockscreen.wallpaper = "~/Pictures/Wallpapers/Fantasy-Lake2.png";
        };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./systems/wyvern/configuration.nix
            lanzaboote.nixosModules.lanzaboote
            ({
              pkgs,
              lib,
              ...
            }: {
              environment.systemPackages = [
                pkgs.sbctl
              ];

              # Lanzaboote currently replaces the systemd-boot module.
              # This setting is usually set to true in configuration.nix
              # generated at installation time. So we force it to false
              # for now.
              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/etc/secureboot";
              };
            })

            desktop.system

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jens = home [
                (tools {})
                (git signatures.wyvern)
                (zsh {
                  aliases = {
                    vim = "nvim";
                  };
                })
                (neovim {source = root;})

                desktop.home

                fontconfig
                (theme {
                  enableKitty = true;
                  binaryName = "toggle-theme";
                })

                kitty
                fuzzel
                (vscode {
                  library = nix-vscode-extensions.extensions."x86_64-linux";
                  colorTheme = {
                    light = "Tokyo Night Light";
                    dark = "Gruvbox Dark Hard";
                  };
                })
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
          modules = [
            darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jens = home [
                (tools {hideDesktopEntries = false;})
                (git signatures.vanguard)
                (zsh {})
                (neovim {
                  source = root;
                  hideDesktopEntry = false;
                })
                (vscode {
                  library = nix-vscode-extensions.extensions."aarch64-darwin";
                  createDesktopEntry = false;
                  colorTheme = {
                    light = "Tokyo Night Light";
                    dark = "Tokyo Night";
                  };
                })
              ];
            }
          ];
        };
    };
  };
}
