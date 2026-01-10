# Home Manager Modules

This directory contains modular home-manager configurations for user `butcherrrr`.

## Structure

```
butcherrrr/
├── packages.nix         # User packages and custom scripts
├── shell.nix            # Zsh, zoxide, and eza configuration
├── git.nix              # Git and delta configuration
├── neovim.nix           # Neovim with Nixvim
├── tmux.nix             # Tmux terminal multiplexer
├── hyprland.nix         # Hyprland window manager settings
├── waybar.nix           # Status bar configuration
├── waybar-style.gtk.css # Waybar styling (Catppuccin Mocha)
├── rofi.nix             # Application launcher configuration
├── services.nix         # Background services (SwayNC, SwayOSD)
├── swaync.css           # SwayNC notification styling (Catppuccin Mocha)
├── swayosd.css          # SwayOSD overlay styling (Catppuccin Mocha)
├── ghostty.nix          # Terminal emulator configuration
├── yazi.nix             # Terminal file manager configuration
├── zed.nix              # Zed editor configuration
├── chromium.nix         # Chromium browser configuration
├── hyprlock.nix         # Lock screen configuration
├── keyring.nix          # GNOME Keyring for secret storage
├── spicetify.nix        # Spotify theming
├── theme.nix            # Cursor theming and wallpaper
├── themes/              # Custom themes
│   └── zed-custom-catppuccin.nix  # Custom Catppuccin Mocha theme for Zed
└── README.md            # You are here
```

## Hyprland Keybindings

### Modifier Keys

- `$mainMod` = SUPER (Windows key)
- `$hyper` = CTRL + ALT + SHIFT + SUPER (mapped from Caps Lock via keyd)

### Universal Clipboard

| Keybind     | Action                         |
| ----------- | ------------------------------ |
| `Super + C` | Universal copy (Ctrl+Insert)   |
| `Super + V` | Universal paste (Shift+Insert) |
| `Super + X` | Universal cut (Ctrl+X)         |

### Applications

| Keybind          | Action                      |
| ---------------- | --------------------------- |
| `Hyper + Return` | Open Ghostty terminal       |
| `Super + Space`  | Open Rofi launcher          |
| `Hyper + T`      | Toggle Ghostty (scratchpad) |
| `Hyper + E`      | Toggle Zed editor           |
| `Hyper + C`      | Toggle Chromium browser     |
| `Hyper + B`      | Toggle Firefox browser      |

### Window Management

| Keybind                 | Action                                          |
| ----------------------- | ----------------------------------------------- |
| `Super + W`             | Kill active window                              |
| `Super + M`             | Exit Hyprland                                   |
| `Super + Shift + Space` | Toggle floating mode                            |
| `Super + P`             | Toggle pseudo-tiling                            |
| `Super + S`             | Toggle split direction                          |
| `Super + F`             | Toggle fullscreen (real fullscreen, hides bar)  |
| `Hyper + F`             | Toggle maximize (full width, keeps bar visible) |

### Focus Movement

| Keybind           | Action                  |
| ----------------- | ----------------------- |
| `Super + ←/→/↑/↓` | Move focus (arrow keys) |
| `Super + h/j/k/l` | Move focus (vim keys)   |

### Workspace Management

| Keybind                 | Action                                 |
| ----------------------- | -------------------------------------- |
| `Super + 1-9/0`         | Switch to workspace 1-10               |
| `Super + Shift + 1-9/0` | Move window to workspace 1-10          |
| `Hyper + 1-9/0`         | Switch to workspace 1-10 (alternative) |
| `Hyper + H`             | Switch to previous workspace           |
| `Hyper + L`             | Switch to next workspace               |

### System Controls

| Keybind             | Action                 |
| ------------------- | ---------------------- |
| `Super + Escape`    | Lock screen (hyprlock) |
| `Super + Shift + R` | Reload Hyprland config |

### Notes

- Caps Lock is remapped to Hyper key (CTRL+ALT+SHIFT+SUPER) via keyd in `modules/core.nix`
- Screenshots are copied to clipboard automatically

## Main Configuration

The main file `../butcherrrr.nix` imports all modules:

```nix
imports = [
  ./butcherrrr/packages.nix
  ./butcherrrr/shell.nix
  ./butcherrrr/git.nix
  ./butcherrrr/neovim.nix
  ./butcherrrr/tmux.nix
  ./butcherrrr/hyprland.nix
  ./butcherrrr/hyprlock.nix
  ./butcherrrr/waybar.nix
  ./butcherrrr/rofi.nix
  ./butcherrrr/ghostty.nix
  ./butcherrrr/yazi.nix
  ./butcherrrr/zed.nix
  ./butcherrrr/chromium.nix
  ./butcherrrr/keyring.nix
  ./butcherrrr/services.nix
  ./butcherrrr/theme.nix
  ./butcherrrr/spicetify.nix
];
```
