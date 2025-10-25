#!/usr/bin/env bash

# TODO: get this working!
# I want to print the list of windows in a group when the currently focused window
# is a group.

SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat - "UNIX-CONNECT:$SOCK" | while IFS= read -r line; do
  echo "{\"text\": \"$line\"}"
done
