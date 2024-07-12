{
  install ? true,
  scale ? 1,
  wallpaper,
}: {
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [brightnessctl pulseaudio];

  imports = [
    (import ./sway/kitty.nix {install = false;})
    (import ./sway/waybar.nix {
      install = false;
      absolute_path_to_project = "/home/jens/dev/config";
    })
    ./sway/fuzzel.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package =
      if install == true
      then pkgs.sway
      else null;
    # TODO: figure out wallpaper situation...
    checkConfig = false;
    extraConfig = ''
      include /etc/sway/config.d/*
    '';
    config = {
      modifier = "Mod4";
      menu = "fuzzel";
      terminal = "kitty";
      startup = [
        {
          command = "swaymsg workspace 1";
        }
      ];
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
        "type:keyboard" = {
          xkb_options = "compose:ralt";
        };
      };
      output = {
        "*" = {
          scale = scale;
          background = "${wallpaper} fill";
        };
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Shift+d" = "exec 'poweroff'";
          "${modifier}+Shift+s" = "exec 'swaylock -f -c 657153 && systemctl suspend'";
          "${modifier}+Shift+t" = "exec 'swaylock -f -c 657153'";
          "--locked ${modifier}+Shift+d" = "exec 'poweroff'";
          "--locked ${modifier}+Shift+s" = "exec 'systemctl suspend'";

          "${modifier}+Shift+y" = "exec ~/dev/config/scripts/toggle-theme.sh";
          "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
          "XF86AudioMicMute" = "exec 'pactl set-source-mute @DEFAULT_SOURCE@ toggle'";
          "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
          "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
          "XF86MonBrightnessDown" = "exec 'brightnessctl set 5%-'";
          "XF86MonBrightnessUp" = "exec 'brightnessctl set +5%'";
          "${modifier}+Ctrl+Left" = "workspace prev";
          "${modifier}+Ctrl+Right" = "workspace next";
        };
      bars = [
        {
          command = "waybar";
        }
      ];
      window = {
        border = 0;
        titlebar = false;
      };
    };
  };

  home.file.sway-desktop-files = {
    source = ./sway/desktop-files;
    target = ".local/share/applications";
    recursive = true;
  };
}
