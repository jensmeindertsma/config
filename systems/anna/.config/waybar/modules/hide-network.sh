#!/bin/bash

STATE_FILE="/tmp/waybar_network_hidden"

# Toggle hidden state
if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
else
    echo "1" > "$STATE_FILE"
fi