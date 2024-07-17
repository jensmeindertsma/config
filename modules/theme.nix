{
  enableKitty,
  binaryName,
}: {pkgs, ...}: {
  home.file.theme-gtk = {
    source = ./theme/gtk;
    target = ".config/gtk-3.0";
    recursive = true;
  };

  home.packages = let
    theme-toggle-script = pkgs.writeScriptBin binaryName ''
      #!/usr/bin/bash

      set_dark() {
        gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        ${
        if enableKitty
        then "kitten themes --reload-in=all --config-file-name theme.conf GitHub Dark"
        else ""
      }
      }

      set_light() {
        gsettings set org.gnome.desktop.interface gtk-theme ":light"
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        ${
        if enableKitty
        then "kitten themes --reload-in=all --config-file-name theme.conf GitHub Light"
        else ""
      }
      }

      if [[ "$(gsettings get org.gnome.desktop.interface color-scheme)" == "'prefer-light'" ]]; then
        set_dark
      else
        set_light
      fi
    '';
  in [theme-toggle-script];
}
