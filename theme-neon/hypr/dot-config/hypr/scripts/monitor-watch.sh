#!/usr/bin/env bash

WALLPAPER="$HOME/.config/hypr/wallpaper.jpg"

handle() {
    case $1 in
        monitoradded*)
            MON="${1#monitoradded>>}"
            sleep 1  # give hyprpaper a moment to register the new monitor
            hyprctl hyprpaper wallpaper "$MON,$WALLPAPER"
            ;;
    esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | \
    while read -r line; do
        handle "$line"
    done
