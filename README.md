# dotfiles

Personal configuration files for a Hyprland-based Linux desktop, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a **stow package** — a self-contained set of configs for one program. Inside each package the directory layout mirrors `$HOME` exactly, so stow can symlink the files into place.

```
dotfiles/
├── alacritty/          # Terminal emulator
│   └── .config/alacritty/
├── bash/               # Shell
│   └── .bashrc
├── colors/             # Shared color palette (CSS variables)
│   └── .config/
├── dunst/              # Notification daemon
│   └── .config/dunst/
├── hypr/               # Hyprland compositor + hyprlock + hyprpaper
│   └── .config/hypr/
├── nvim/               # Neovim
│   └── .config/nvim/
│       ├── init.lua
│       └── lua/
│           ├── core/           # Options, keymaps, autocommands
│           └── plugins/        # One file per plugin (loaded by lazy.nvim)
├── rofi/               # App launcher + power menu
│   └── .config/rofi/
├── waybar/             # Status bar
│   └── .config/waybar/
├── wlogout/            # Logout screen
│   └── .config/wlogout/
└── wofi/               # Alternative launcher (legacy)
    └── .config/wofi/
```

## How stow works

Stow creates symlinks from `~/.config/...` (and other `$HOME` paths) pointing back into this repo. The rule is simple: **strip the package name from the path, then symlink the rest relative to `$HOME`**.

For example:
```
dotfiles/nvim/.config/nvim/init.lua
         ^^^^                        ← package name, stripped
              ^^^^^^^^^^^^^^^^^^^    ← symlinked to ~/.config/nvim/init.lua
```

Run stow from the root of this repo:

```bash
# Symlink a single package
stow nvim

# Symlink everything at once
stow alacritty bash colors dunst hypr nvim rofi waybar wlogout wofi

# Remove symlinks for a package
stow -D nvim

# Dry run (preview what would happen)
stow -n nvim
```

## Adding a new package

Create the package directory mirroring where the config lives under `$HOME`, then stow it:

```bash
mkdir -p dotfiles/<name-of-package>/.config/<name-of-package>
# add configs, then:
stow <name-of-package>
```
