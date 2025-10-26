#!/usr/bin/env bash

echo "{ \"text\": \"todo\"}"

# We need to handle some cases in which to show to group list
# 1. a focused window is toggled into a group (no activewindow change)
# 2. a group window is brought into focus (activewindow change, look up if windows=======+++++++____)
# 3. a window is added to the group

# We need to handle some cases in which to hide the group list
# 4. a group window goes out of focus
# 5. a group window is toggled into a regular group
# 6. a window leaves the group (moveoutofgroup), using the ID, we remove it from our list and we rerender

# Events
# - `togglegroup>>1,55b73aad9420` (1 means group created)
# - `togglegroup>>0,55b73aad9420` (0 means group destroyed)
# - `activewindowv2>>55b73aad9420` focus switch to another window (check whether group)
# - `moveintogroup`

# If toggle is created, show h

# If toggle is removed, then hide the list
# If focus goes out of window, hide the list
# If toggle is disabled hide the hist

# - activewindowv2
#     + check if new window is a group
#     + if yes then display module (fetch group members)w
# - closewindow
#      +  check if window was a in group, then hide the module
# - moveoutofgroup
#     + check
handle() {
  local line="$1"

  case $line in
  activewindowv2*)
    ID=$(echo "$line" | awk -F '>>' '{print $2}')
    GROUPED=$(hyprctl -j clients | jq -r --arg id "0x$ID" '.[] | select(.address == $id) .grouped | join(", ")')

    if [[ -n "$GROUPED" ]]; then
      echo "{ \"text\": \"group active\"}"
    else
      echo "{ \"text\": \"group not focused\"}"
    fi
    ;;
  *)
    echo "{ \"text\": \"no group\"}"
    ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
