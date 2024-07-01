{
  config,
  lib,
  pkgs,
  ...
}: let
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
        wrapped_bin=$out/bin/$(basename $bin)
        echo "exec ${lib.getExe pkgs.nixgl.nixGLMesa} $bin \$@" > $wrapped_bin
        chmod +x $wrapped_bin
      done
    '';
in {
  home.packages = with pkgs; [swaybg swayidle swaylock];

  wayland.windowManager.sway = {
    enable = true;
    package = nixGLWrap pkgs.sway;
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
        "type:keyboard" = {
          xkb_options = "compose:ralt";
        };
      };
      output = {
        "*" = {
          background = "~/Pictures/Wallpapers/1.jpg fill";
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
          "XF86MonBrightnessDown" = "exec 'light -U 5%'";
          "XF86MonBrightnessUp" = "exec 'light -A 5%'";
        };
      bars = [
        {
          command = "waybar";
        }
      ];
      swaynag.enable = true;
      window = {
        border = 0;
        titlebar = false;
      };
    };
  };

  home.file.sway-toggle-theme = {
    source = ./sway/toggle-theme.sh;
    target = ".config/sway/toggle.theme.sh";
    executable = true;
  };
}
