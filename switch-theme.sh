#!/usr/bin/env bash
# Usage: switch-theme.sh [neon|mono]

THEME="${1:-}"
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

if [[ "$THEME" != "neon" && "$THEME" != "mono" ]]; then
    echo "Usage: switch-theme.sh [neon|mono]"
    exit 1
fi

cd "$DOTFILES"

# Record the inode alacritty is currently watching before the switch
OLD_COLORS=$(readlink -f "$HOME/.config/alacritty/colors.toml" 2>/dev/null)

stow -D theme-neon 2>/dev/null
stow -D theme-mono 2>/dev/null
stow "theme-$THEME"

# Reload everything
hyprctl reload
pkill waybar; waybar > /dev/null 2>&1 & disown
pkill dunst; dunst > /dev/null 2>&1 & disown
pkill hyprpaper; hyprpaper > /dev/null 2>&1 & disown
pkill -USR1 kitty 2>/dev/null || true

# Trigger alacritty's inotify watch.  When stow -D removes the directory
# symlink, alacritty detects the deletion and re-watches the NEW theme's files.
# So we trigger both the old inode (in case the watch survived) and the new
# inode (in case alacritty already migrated its watch to the new file).
NEW_COLORS=$(readlink -f "$HOME/.config/alacritty/colors.toml" 2>/dev/null)
_tmp=$(mktemp)
for _f in "$OLD_COLORS" "$NEW_COLORS"; do
    [[ -n "$_f" && -f "$_f" ]] && cp "$_f" "$_tmp" && cp "$_tmp" "$_f"
done
rm -f "$_tmp"

echo "Switched to $THEME theme."
