#!/bin/bash
# Application launcher
# Place at ~/.local/bin/launcher.sh and chmod +x

THEME="$HOME/.config/rofi/launcher.rasi"

rofi -show drun \
    -display-drun "󰣇" \
    -icon-theme "Qogir" \
    -theme "$THEME" \
    -hover-select \
    -me-select-entry '' \
    -me-accept-entry 'MousePrimary' \
    -drun-display-format "{name}" \
    -show-icons \
    -sort \
    -sorting-method normal \
    -disable-history \
    -no-levenshtein-sort
