# NixOS Configuration

Multi-host NixOS configuration with Hyprland, managed through Nix flakes.

## Documentation

- **`hosts/README.md`** - Complete guide for adding and managing hosts
- **`home/butcherrrr/README.md`** - Home Manager modules documentation

## Structure

```
nixos-config/
├── flake.nix              # Defines all hosts and inputs
├── flake.lock             # Locked dependency versions
├── hosts/                 # Per-host configurations
│   ├── x1/                # Primary laptop
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   └── guinea-pig/        # Test/build laptop
│       ├── default.nix
│       └── hardware-configuration.nix
├── modules/               # Shared system modules
│   ├── core.nix           # Base system (users, audio, networking, keyd)
│   ├── greetd.nix         # Greetd + tuigreet display manager
│   ├── console.nix        # Console configuration (large font, resolution)
│   └── hyprland.nix       # Hyprland window manager + portals
├── home/                  # Home-manager user configs
│   ├── butcherrrr.nix     # Main user configuration
│   └── butcherrrr/        # Modular user configurations
│       ├── packages.nix   # User packages and scripts
│       ├── shell.nix      # Zsh, zoxide, and eza
│       ├── git.nix        # Git and delta configuration
│       ├── neovim.nix     # Neovim with Nixvim
│       ├── tmux.nix       # Tmux terminal multiplexer
│       ├── hyprland.nix   # Hyprland settings and keybinds
│       ├── waybar.nix     # Status bar configuration
│       ├── rofi.nix       # Application launcher
│       ├── ghostty.nix    # Terminal emulator
│       ├── zed.nix        # Zed editor
│       ├── chromium.nix   # Chromium browser
│       ├── hyprlock.nix   # Lock screen configuration
│       ├── keyring.nix    # GNOME Keyring for secret storage
│       ├── services.nix   # Mako notifications
│       ├── spicetify.nix  # Spotify theming
│       └── theme.nix      # Cursor theme and wallpaper
├── scripts/               # Custom shell scripts
└── backgrounds/           # Wallpaper images
```

## Current Hosts

- `x1` - Primary laptop
- `guinea-pig` - Test/build laptop

## Quick Commands

```bash
# Rebuild current host
sudo nixos-rebuild switch --flake .#$(hostname)
# Or use alias: nrs

# Update dependencies
nix flake update

# Add new host
# See hosts/README.md for complete instructions
```

## Getting Started

For adding a new host or managing existing hosts, see **`hosts/README.md`**.
