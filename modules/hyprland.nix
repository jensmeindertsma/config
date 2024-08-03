{
  launcher,
  monitor,
  terminal,
  toggle_theme_command,
  wallpaper,
  lockscreen,
}: {
  system = {pkgs, ...}: {
    programs.hyprland.enable = true;
    programs.dconf.enable = true;
    xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    security.pam.services.hyprlock = {};
  };

  home = {pkgs, ...}: {
    imports = [./hyprland/waybar.nix];

    home.packages = with pkgs; [clipse hyprpaper];

    wayland.windowManager.hyprland = {
      # Whether to enable Hyprland wayland compositor
      enable = true;
      # The hyprland package to use
      package = pkgs.hyprland;
      # Whether to enable XWayland
      xwayland.enable = true;
      settings = {
        "$mainMod" = "SUPER";
        "$terminal" = terminal;
        "$menu" = launcher;
        exec-once = [
          "waybar"
          "hyprpaper"
          "clipse -listen"
        ];
        monitor = monitor;
        xwayland.force_zero_scaling = true;
        bind = [
          "$mainMod, RETURN, exec, $terminal"
          "$mainMod SHIFT, Q, killactive"
          "$mainMod SHIFT, E, exit"
          "$mainMod SHIFT, Y, exec, ${toggle_theme_command}"
          "$mainMod SHIFT, L, exec, hyprlock"
          "$mainMod, V, togglefloating"
          "$mainMod, D, exec, $menu"
          "$mainMod, P, pseudo"
          "$mainMod, J, togglesplit"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
        ];
        animations.enable = false;
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            monitor = "";
            path = lockscreen.wallpaper;
            blur_passes = 3;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
            color = "rgba(250, 189, 47, .75)";
            font_size = 120;
            position = "0, -140";
            halign = "center";
            valign = "top";
          }

          {
            monitor = "";
            text = ''cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"'';
            color = "rgba(225, 225, 225, 0.75)";
            font_size = 30;
            position = "0, 200";
            halign = "center";
            valign = "center";
          }

          {
            monitor = "";
            text = "";
            color = "rgba(255, 255, 255, 0.65)";
            font_size = 120;
            position = "0, 60";
            halign = "center";
            valign = "center";
          }

          {
            monitor = "";
            text = "Hello, $USER";
            color = "rgba(255, 255, 255, .65)";
            font_size = 25;
            # font_family = SF Pro Display Bold
            position = "0, -70";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "290, 60";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color = "rgba(0, 0, 0, 0)";
            inner_color = "rgba(60, 56, 54, 0.35)";
            font_color = "rgb(200, 200, 200)";
            fade_on_empty = false;
            # font_family = SF Pro Display Bold
            placeholder_text = ''<i><span foreground="##ffffff99">Password</span></i>'';
            hide_input = false;
            position = "0, -140";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [wallpaper];
        wallpaper = [
          "DP-1,${wallpaper}"
        ];
      };
    };

    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#eceff1";
          font = "JetBrainsMono Nerd Font 9";
        };

        urgency_normal = {
          background = "#37474f";
          foreground = "#eceff1";
          timeout = 10;
        };
      };
    };
  };
}
