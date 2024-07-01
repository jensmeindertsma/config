{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [brightnessctl];

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    # TODO: figure out wallpaper situation...
    checkConfig = false;
    config = {
      modifier = "Mod4";
      menu = "fuzzel";
      terminal = "kitty";
      startup = [
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
          background = "~/Pictures/Wallpapers/2.jpg fill";
        };
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Shift+d" = "exec 'poweroff'";
          "${modifier}+Shift+s" = "exec 'swaylock -f -c 657153 && systemctl suspend'";
          "${modifier}+Shift+t" = "exec 'swaylock -f -c 657153'";
          "${modifier}+Shift+y" = "exec ~/.config/sway/toggle-theme.sh";
          "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
          "XF86AudioMicMute" = "exec 'pactl set-source-mute @DEFAULT_SOURCE@ toggle'";
          "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
          "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
          "XF86MonBrightnessDown" = "exec 'brightnessctl set 5%-'";
          "XF86MonBrightnessUp" = "exec 'brightnessctl set +5%'";
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

  home.file.sway-toggle-theme = {
    source = ./sway/toggle-theme.sh;
    target = ".config/sway/toggle-theme.sh";
    executable = true;
  };

  imports = [
    ./sway/kitty.nix
    ./sway/fuzzel.nix
    ./sway/waybar.nix
  ];
}
