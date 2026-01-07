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
├── ghostty.nix          # Terminal emulator configuration
├── yazi.nix             # Terminal file manager configuration
├── zed.nix              # Zed editor configuration
├── chromium.nix         # Chromium browser configuration
├── hyprlock.nix         # Lock screen configuration
├── keyring.nix          # GNOME Keyring for secret storage
├── services.nix         # Background services (mako notifications)
├── spicetify.nix        # Spotify theming
├── theme.nix            # Cursor theming and wallpaper
└── README.md            # You are here
```

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
