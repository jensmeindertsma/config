{
  description = "I hereby declare this file the state of the universe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-darwin,
    nix-darwin,
    home-manager,
  }: {
    darwinConfigurations.vanguard = let
      home = import ./modules/home.nix {
        config = import ./systems/vanguard/home.nix;
        ssh = import ./systems/vanguard/home/ssh.nix;
        imports = [./modules/vscode.nix ./modules/nvim.nix];
      };
    in
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = nixpkgs-darwin;
        modules = [
          home-manager.darwinModules.home-manager
          (import ./systems/vanguard/darwin.nix home)
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
          (import ./modules/nvim.nix)
          ({pkgs, ...}: {
            home.packages = with pkgs; [
              bluetuith
              dmidecode
              htop
              networkmanagerapplet
              pavucontrol
              roboto
              spotify
              unzip
              virt-manager
              wev
              wget
              wl-clipboard
            ];

            services.ssh-agent.enable = true;

            programs.firefox.enable = true;

            programs.zsh.initExtra = ''
              export NVM_DIR="$HOME/.nvm"
              [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
              [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
            '';
          })
        ];
    };
  };
}
