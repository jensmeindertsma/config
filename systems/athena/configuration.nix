{pkgs, ...}: {
  system.stateVersion = "24.05";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices.main.device = "/dev/disk/by-uuid/bbfa9bdf-d420-4205-80fb-2f018b3dc732";
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "athena";
    networkmanager.enable = true;
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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  programs.zsh.enable = true;
}
