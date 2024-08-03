{
  launcher,
  monitor,
  terminal,
  toggle_theme_command,
}: {
  system = {pkgs, ...}: {
    programs.hyprland.enable = true;
    programs.dconf.enable = true;
    xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    security.pam.services.hyprlock = {};
  };

  home = {pkgs, ...}: {
    imports = [./hyprland/waybar.nix];

    home.packages = with pkgs; [clipse];

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
          "clipse -listen"
        ];
        monitor = monitor;
        xwayland.force_zero_scaling = true;
        bind = [
          "$mainMod, RETURN, exec, $terminal"
          "$mainMod SHIFT, Q, killactive"
          "$mainMod SHIFT, E, exit"
          "$mainMod SHIFT, Y, exec, ${toggle_theme_command}"
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
      };
    };

    programs.hyprlock.enable = true;

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
