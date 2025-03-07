if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

source ~/.cargo/env
