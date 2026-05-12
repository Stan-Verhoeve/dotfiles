# dotfiles

My configuration files for my Hyprland-based Linux desktop. Still learning how to rice, so might be some bugs / ugly stuff.

I've opted for two themes. I'm a big sucker for neon and purple, so one theme is heavily inspired by the colour scheme of the ['Let you down' music video](https://www.youtube.com/watch?v=BnnbP7pCIvQ) from Cyberpunk. The other theme uses the same layouts, but is fully monochrome for a sharper look. They live in their own subdir

## Showcase

### Mono

| Bare | btop · fastfetch · terminal · rofi |
|:---:|:---:|
| ![](./assets/mono_bare.png) | ![](./assets/mono_btop_fastfetch_term_rofi.png) |

### Neon

| Bare | btop · fastfetch · terminal · rofi |
|:---:|:---:|
| ![](./assets/neon_bare.png) | ![](./assets/neon_btop_fastfetch_term_rofi.png) |

## Theme switching and stow


Each theme directory contains an app per subdirectory (e.g. `theme-mono/nvim/`, `theme-mono/kitty/`), so you can stow exactly what you need. A `.stowrc` at the repo root sets `--dotfiles` automatically, which maps `dot-config/` --> `.config/` etc.

To stow everything:
```
stow -d theme-mono -t ~ alacritty bash btop colors dunst firefox gtk hypr kitty nvim rofi waybar wlogout wofi
```

Or just pick what you want:
```
stow -d theme-mono -t ~ nvim btop bash
```

The [switch-theme](./switch-theme.sh) script handles unstowing the old theme, stowing the new one, and restarting relevant processes (waybar, dunst, hyprpaper, kitty). It also accepts an optional app list:
```
./switch-theme.sh mono                  # full desktop
./switch-theme.sh mono nvim btop bash   # minimal
```

## Todos
- [x] Have apps as atomic building block
- [ ] Let me know? 
