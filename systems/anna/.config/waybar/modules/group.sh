#!/usr/bin/env bash

# The goal of this script is to detect when a "group window" is focused in Hyprland
# in the current workspace. This script will run as a waybar module where it will
# show a list in the form of `a b (c) d`, where `(c)` highlights the currently visible window
# in the group.

handle() {
  local line="$1"

  case $line in
  activewindowv2* | togglegroup* | workspacev2*)
    active_window="$(hyprctl -j activewindow)"

    active_id="$(echo "$active_window" | jq -r '.address')"

    # Get the list of grouped window IDs as an array
    read -ra group_arr <<<"$(echo "$active_window" | jq -r '.grouped | join(" ")')"

    # If no group, output empty
    if [[ ${#group_arr[@]} -eq 0 ]]; then
      echo '{ "text": "" }'
      return
    fi

    display=""
    for i in "${!group_arr[@]}"; do
      letter=$(printf "\\x$(printf %x $((97 + i)))")

      if [[ "${group_arr[i]}" == "$active_id" ]]; then
        display+="<span foreground='#FF0000'>[</span>"
        display+="<span>$letter</span>"
        display+="<span foreground='#FF0000'>]</span>"
      else
        display+="<span></span>"
        display+="<span>$letter</span>"
        display+="<span></span>"
      fi

      # Space between items except last
      if [[ $i -lt $((${#group_arr[@]} - 1)) ]]; then
        display+=" "
      fi
    done

    echo "{ \"text\": \"$display\" }"
    ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
