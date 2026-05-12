#!/bin/bash
# Window switcher
# Place at ~/.local/bin/windowswitcher.sh and chmod +x

THEME="$HOME/.config/rofi/launcher.rasi"

rofi -show window \
    -display-window "󰣇" \
    -icon-theme "Qogir" \
    -theme "$THEME" \
    -hover-select \
    -me-select-entry '' \
    -me-accept-entry 'MousePrimary' \
    -show-icons \
    -theme-str 'prompt { text-color: @alttxt; }' \
    -sort \
    -sorting-method normal
