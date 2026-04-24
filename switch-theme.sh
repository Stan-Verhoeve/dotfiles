#!/usr/bin/env bash
# Usage: switch-theme.sh [neon|mono]

THEME="${1:-}"
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

if [[ "$THEME" != "neon" && "$THEME" != "mono" ]]; then
    echo "Usage: switch-theme.sh [neon|mono]"
    exit 1
fi

cd "$DOTFILES"

stow -D theme-neon 2>/dev/null
stow -D theme-mono 2>/dev/null
stow "theme-$THEME"

hyprctl reload
pkill waybar; waybar > /dev/null 2>&1 & disown
pkill dunst; dunst > /dev/null 2>&1 & disown
pkill hyprpaper; hyprpaper > /dev/null 2>&1 & disown
pkill -USR1 kitty 2>/dev/null || true

echo "Switched to $THEME theme."
