{pkgs, ...}: {
  system.stateVersion = "24.05";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices.main.device = "/dev/disk/by-uuid/a53a08d7-0224-4d47-9532-e77d0efb7e16";
    loader = {
      # We use Lanzaboote which replaces systemd-boot
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.opengl = {
    enable = true;
  };

  networking = {
    hostName = "anna";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    networkmanager-openvpn
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.jens = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  programs.zsh.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
