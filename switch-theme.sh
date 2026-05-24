#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
THEME="${1:-}"

usage() {
  local themes
  themes=$(ls -d "$DOTFILES"/theme-* 2>/dev/null \
    | xargs -n1 basename | sed 's/theme-//' | tr '\n' ' ')
  echo "Usage: $(basename "$0") <theme> [app ...]"
  echo ""
  echo "  theme  one of: ${themes}"
  echo "  app    apps to stow (default: all apps in theme)"
  echo ""
  echo "Examples:"
  echo "  $(basename "$0") mono                  # full desktop"
  echo "  $(basename "$0") mono nvim btop bash   # server / minimal"
  exit 1
}

[[ -z "$THEME" || ! -d "$DOTFILES/theme-$THEME" ]] && usage
shift

# If no apps given, stow everything in the theme
if [[ $# -gt 0 ]]; then
  APPS=("$@")
else
  mapfile -t APPS < <(ls -d "$DOTFILES/theme-$THEME"/*/ | xargs -n1 basename)
fi

cd "$DOTFILES"

# Unstow these apps from whichever theme currently owns them
for theme_dir in theme-*/; do
  theme="${theme_dir%/}"
  for app in "${APPS[@]}"; do
    [[ -d "$theme/$app" ]] && stow --dotfiles -D -d "$theme" -t ~ "$app" 2>/dev/null || true
  done
done

# Stow from the new theme
for app in "${APPS[@]}"; do
  if [[ -d "theme-$THEME/$app" ]]; then
    stow --dotfiles -d "theme-$THEME" -t ~ "$app"
  else
    echo "Warning: '$app' not found in theme-$THEME, skipping."
  fi
done

# Restart desktop services for relevant stowed apps
stowed=" ${APPS[*]} "
if [[ $stowed == *" hypr "* ]]; then
  # Snapshot active workspace per monitor: "name ws_id focused"
  _snapshots=$(hyprctl monitors 2>/dev/null | awk '
    /^Monitor /       { mon = $2 }
    /active workspace:/ { ws = $3 }
    /focused:/        { print mon, ws, ($NF == "yes" ? 1 : 0) }
  ')
  hyprctl reload 2>/dev/null || true
  # Restore non-focused monitors first, then focused last so focus ends up in the right place
  for _pass in 0 1; do
    while IFS=' ' read -r _mon _ws _focused; do
      [[ "$_focused" == "$_pass" ]] || continue
      hyprctl dispatch "hl.dsp.focus({monitor = '$_mon'})" 2>/dev/null || true
      hyprctl dispatch "hl.dsp.focus({workspace = '$_ws'})" 2>/dev/null || true
    done <<< "$_snapshots"
  done
fi
[[ $stowed == *" waybar "* ]] && { pkill waybar 2>/dev/null || true; waybar >/dev/null 2>&1 & disown; }
[[ $stowed == *" dunst "* ]]  && { pkill dunst  2>/dev/null || true; dunst  >/dev/null 2>&1 & disown; }
[[ $stowed == *" hypr "* ]]   && { pkill hyprpaper 2>/dev/null || true; hyprpaper >/dev/null 2>&1 & disown; }
[[ $stowed == *" kitty "* ]]  && pkill -USR1 kitty 2>/dev/null || true
[[ $stowed == *" cava "* ]]   && { pkill cava   2>/dev/null || true; }

echo "Switched to theme-$THEME (${APPS[*]})."
