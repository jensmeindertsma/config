{pkgs, ...}: {
  system.stateVersion = "24.05";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/fa6e16fc-ab7d-4251-b2b6-8c4fd8c565ca";
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "anna";
    networking.networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.jens = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };
  };

  programs.zsh.enable = true;
}
