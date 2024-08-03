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
      set_dark() {
        gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        ${
        if enableKitty
        then "kitten themes --reload-in=all --cache-age -1 --config-file-name theme.conf GitHub Dark"
        else ""
      }
      }

      set_light() {
        gsettings set org.gnome.desktop.interface gtk-theme ":light"
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        ${
        if enableKitty
        then "kitten themes --reload-in=all --cache-age -1 --config-file-name theme.conf GitHub Light"
        else ""
      }
      }

      if [[ "$(gsettings get org.gnome.desktop.interface color-scheme)" == "'prefer-light'" ]]; then
        set_dark
      else
        set_light
      fi
    '';
  in [pkgs.glib pkgs.gsettings-desktop-schemas theme-toggle-script];

  home.sessionVariables = {
    XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-46.0:$XDG_DATA_DIRS";
  };
}
