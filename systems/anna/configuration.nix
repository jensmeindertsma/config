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

      timeout = 5;
    };
  };

  hardware.graphics = {
    enable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  networking = {
    hostName = "anna";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    networkmanager-openvpn
    openresolv
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.jens = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "libvirtd" "docker"];
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
