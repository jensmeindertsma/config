# Wyvern

First make sure all the directories exist.

These commands place all the general config files in their right locations

```bash
$ stow desktop --target ~/.local/share/applications
$ stow fontconfig --target ~/.config/fontconfig
$ stow git --target ~/.config/git
$ stow gtk --target ~/.config/gtk-3.0 # <--- this one is very important or else `toggle_theme` won't work
$ stow home --target ~
$ stow hyprland --target ~/.config/hypr # <--- configuration for Hyprland, Hyprpaper, Hyprlock, Hypridle, ...
$ stow kitty --target ~/.config/kitty
$ stow ssh --target ~/.ssh
$ stow waybar --target ~/.config/waybar
$ stow wofi --target ~/.config/wofi
$ stow zsh --target ~
```

With these you can link up your local VSCode settings and keybindings to the shared file that is in version control.

```bash
$ stow vscode -t ~/.config/Code/User/
```

To be able to toggle the theme on a system without a desktop environment, this script can be very helpful. It sets all the right variables. You can customize it to set a different Kitty (terminal) theme to your liking.

```bash
$ sudo ln -sf ~/development/config/systems/isac/scripts/toggle_theme /usr/local/bin/toggle_theme
```
