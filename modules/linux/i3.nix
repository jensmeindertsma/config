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
  home.packages = with pkgs; [brightnessctl pulseaudio feh i3lock xss-lock];

  imports = [./i3/polybar.nix];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      menu = "rofi -show drun -dpi 1";
      terminal = "kitty";

      startup = [
        {
          command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
        }
        {
          command = "feh --bg-fill ${wallpaper}";
        }
      ];
      bars = [];

      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Shift+d" = "exec poweroff";
          "${modifier}+Shift+s" = "exec --no-startup-id loginctl lock-session && systemctl suspend";
          "${modifier}+Shift+t" = "exec --no-startup-id loginctl lock-session";

          "${modifier}+Shift+y" = "exec --no-startup-id ~/dev/config/scripts/toggle-theme.sh";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -1%";
          "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +1%";
          "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +5%";
          "${modifier}+Ctrl+Left" = "workspace prev";
          "${modifier}+Ctrl+Right" = "workspace next";
        };
      window = {
        border = 0;
        titlebar = false;
      };
    };
  };
}
