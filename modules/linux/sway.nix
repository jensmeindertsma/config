{
  install ? true,
  menu,
  scale ? 1,
  wallpaper,
  terminal,
  bar,
}: {
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [brightnessctl pulseaudio];

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
      menu = menu;
      terminal = terminal;
      startup = [
        {
          command = "swaymsg workspace 1";
        }
        {
          command = "swayidle -w before-sleep 'swaylock -f -c 657153'";
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

          "${modifier}+Shift+y" = "exec ~/.config/sway/toggle-theme.sh";
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
          command = bar;
        }
      ];
      window = {
        border = 0;
        titlebar = false;
      };
    };
  };

  home.file.sway-toggle-theme = {
    source = ./sway/toggle-theme.sh;
    target = ".config/sway/toggle-theme.sh";
    executable = true;
  };
}
