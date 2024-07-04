# Notes on using Sway

If you are using Sway on a non-NixOS system, please set `{ install = false; }` and install `sway`, `swaylock`, `swaybg` and `swayidle` manually. Especially `swaylock` will not function as intended when installed using Home Manager.
