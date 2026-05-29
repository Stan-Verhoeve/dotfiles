# dotfiles

My configuration files for my Hyprland-based Linux desktop. Still learning how to rice, so might be some bugs / ugly stuff.

I've opted for two themes. I'm a big sucker for neon and purple, so one theme is heavily inspired by the colour scheme of the ['Let you down' music video](https://www.youtube.com/watch?v=BnnbP7pCIvQ) from Cyberpunk. The other theme uses the same layouts, but is fully monochrome for a sharper look. They live in their own subdir


## Showcase

### Mono

| Bare | btop · fastfetch · cava |
|:---:|:---:|
| ![](./assets/mono_bare.png) | ![](./assets/mono_fastfetch_btop_cava.png.png) |

### Neon

| Bare | btop · fastfetch · cava |
|:---:|:---:|
| ![](./assets/neon_bare.png) | ![](./assets/neon_fastfetch_btop_cava.png.png) |


## Programs

| Component | Program |
|---|---|
| Operating System | [EndeavourOS](https://endeavouros.com) |
| Window Manager | [Hyprland](https://hyprland.org) |
| Terminal | [Kitty](https://sw.kovidgoyal.net/kitty) |
| Shell | [Bash](https://www.gnu.org/software/bash) |
| Editor | [Neovim](https://neovim.io) |
| File Manager | [Thunar](https://docs.xfce.org/xfce/thunar/start) |
| Bar | [Waybar](https://github.com/Alexays/Waybar) |
| Launcher | [Rofi](https://github.com/davatorium/rofi) |
| Notifications | [Dunst](https://dunst-project.org) |
| Wallpaper | [Hyprpaper](https://github.com/hyprwm/hyprpaper) |
| Lockscreen | [Hyprlock](https://github.com/hyprwm/hyprlock) |
| Fetch | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| System Monitor | [Btop](https://github.com/aristocratos/btop) |

## Theme switching and stow


Each theme directory contains an app per subdirectory (e.g. `theme-mono/nvim/`, `theme-mono/kitty/`), so you can stow exactly what you need. A `.stowrc` at the repo root sets `--dotfiles` automatically, which maps `dot-config/` --> `.config/` etc.

To stow everything:
```
stow -d theme-<theme> -t ~ bash btop cava colors dunst fastfetch gtk hypr kitty nvim rofi waybar
```

Or just pick what you want:
```
stow -d theme-<theme> -t ~ nvim btop bash
```

The [switch-theme](./switch-theme.sh) script handles unstowing the old theme, stowing the new one, and restarting relevant processes (waybar, dunst, hyprpaper, kitty). It also accepts an optional app list:
```
./switch-theme.sh mono                  # full desktop
./switch-theme.sh mono nvim btop bash   # minimal
```

## Todos
- [x] Have apps as atomic building block
- [ ] Make Wi-Fi, VPN, Bluetooth menus more appealing
- [ ] Make rofi in general more appealing
- [ ] Let me know? 
