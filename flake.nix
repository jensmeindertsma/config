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
        ./systems/vanguard/configuration.nix
      ];
    };
    homeConfigurations = let
      homeManager = system: module:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [module];
        };
    in {
      wyvern = homeManager "x86_64-linux" (import ./modules/home.nix {
        username = "jens";
        homeDirectory = "/home/jens";
        aliases = {
          reflect = "sudo systemctl start reflector";
        };
        ssh = {
          public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhI5sNxApLWYWOKljGuaVzt/6rsAVlAlb2lKv0nPHyD jens@wyvern";
          hosts = {
            devbox = {
              hostname = "192.168.122.66";
              user = "jens";
              forwardAgent = true;
            };

            "iv/ubuntu" = {
              hostname = "192.168.100.211";
              user = "jens";
            };

            "iv/fedora" = {
              hostname = "192.168.100.133";
              user = "jens";
            };

            "l+/ubuntu" = {
              hostname = "192.168.101.167";
              user = "jens";
            };

            "l+/fedora" = {
              hostname = "192.168.101.240";
              user = "jens";
            };

            "l+/suse" = {
              hostname = "192.168.101.152";
              user = "jens";
            };

            "l+/rocky" = {
              hostname = "192.168.101.215";
              user = "jens";
            };
          };
        };
      });
    };
  };
}
