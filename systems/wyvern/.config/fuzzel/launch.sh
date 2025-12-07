#!/bin/bash

# Detect GTK theme preference
THEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$THEME" == "'prefer-dark'" ]]; then
    fuzzel --config ~/.config/fuzzel/dark.ini
else
    fuzzel --config ~/.config/fuzzel/light.ini
fi
