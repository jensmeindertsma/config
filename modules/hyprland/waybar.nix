{
  config,
  pkgs,
  ...
}: {
  home.file.waybar-network = {
    source = ./waybar/network.sh;
    target = "${config.home.homeDirectory}/.config/waybar/network.sh";
    #executable = true;
  };

  home.file.waybar-style-l = {
    source = ./waybar/style-light.css;
    target = "${config.home.homeDirectory}/.config/waybar/style-light.css";
  };

  home.file.waybar-style-d = {
    source = ./waybar/style-dark.css;
    target = "${config.home.homeDirectory}/.config/waybar/style-dark.css";
  };

  home.packages = with pkgs; [pulseaudio];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [];

        modules-right = [
          "cpu"
          "memory"
          "disk"
          "temperature"
          "pulseaudio#sink"
          "pulseaudio#source"
          "backlight"
          "custom/network"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
        };

        cpu = {
          format = "  {usage}%";
          interval = 1;
          tooltip = false;
        };

        memory = {
          format = "  {percentage}%";
          interval = 1;
          tooltip-format = "{used}GiB used of {total}GiB total";
        };

        disk = {
          format = "󰋊 {percentage_used}%";
          interval = 10;
        };

        temperature = {
          format = "  {temperatureC}°C";
          interval = 3;
          tooltip = false;
        };

        "pulseaudio#sink" = {
          format = "  {volume}%";
          format-low = " {volume}%";
          format-medium = " {volume}%";
          format-muted = "  {volume}%";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
          states = {
            low = 1;
            medium = 60;
          };
          tooltip = false;
        };
        "pulseaudio#source" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "  {volume}%";
          on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ +1%";
          on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ -1%";
          tooltip = false;
        };

        backlight = {
          format = "  {percent}%";
        };

        "custom/network" = {
          exec = "$HOME/.config/waybar/network.sh";
          format = "{}";
          interval = 2;
          return-type = "json";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = {
            "10" = "󰁺";
            "100" = "󰁹";
            "20" = "󰁻";
            "30" = "󰁼";
            "40" = "󰁽";
            "50" = "󰁾";
            "60" = "󰁿";
            "70" = "󰂀";
            "80" = "󰂁";
            "90" = "󰂂";
            charging = "󰂄";
            plugged = "";
          };
          interval = 5;
          states = {
            "10" = 1;
            "100" = 100;
            "20" = 20;
            "30" = 30;
            "40" = 40;
            "50" = 50;
            "60" = 60;
            "70" = 70;
            "80" = 80;
            "90" = 90;
          };
          tooltip-format = "{timeTo} (drawing {power}W; {cycles} cycles)";
        };

        clock = {
          format = "󰥔 {:%H:%M:%S}";
          interval = 1;
          tooltip-format = "󰃭 {:%A %d/%m/%Y}";
        };
      };
    };
  };
}
