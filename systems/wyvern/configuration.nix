{pkgs, ...}: {
  system.stateVersion = "24.05";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices.main.device = "/dev/disk/by-uuid/471b8c02-71c7-4e3c-9f97-eae2dfa5a330";
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
    hostName = "wyvern";
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