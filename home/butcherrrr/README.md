# Home Manager Modules

This directory contains modular home-manager configurations for user `butcherrrr`.

## Structure

```
butcherrrr/
├── packages.nix     # User packages (firefox, neovim, etc.)
├── shell.nix        # Zsh shell and zoxide configuration
├── hyprland.nix     # Hyprland window manager settings
├── waybar.nix       # Status bar configuration
├── rofi.nix         # Application launcher configuration
├── ghostty.nix      # Terminal emulator configuration
├── services.nix     # Background services (mako, hyprpaper)
├── theme.nix        # GTK and cursor theming
└── README.md        # This file
```

## Main Configuration

The main file `../butcherrrr.nix` imports all modules:

```nix
imports = [
  ./butcherrrr/packages.nix
  ./butcherrrr/shell.nix
  ./butcherrrr/hyprland.nix
  ./butcherrrr/waybar.nix
  ./butcherrrr/rofi.nix
  ./butcherrrr/ghostty.nix
  ./butcherrrr/services.nix
  ./butcherrrr/theme.nix
];
```

## Editing Configuration

### To Add a Package

Edit `packages.nix`:
```nix
home.packages = with pkgs; [
  papirus-icon-theme
  neovim
  firefox
  your-new-package  # Add here
];
```

### To Change Hyprland Keybindings

Edit `hyprland.nix`:
```nix
bind = [
  "$mainMod, Return, exec, ghostty"
  "$mainMod, Space, exec, rofi -show drun"
  "$mainMod, Z, exec, zed"  # Add new keybinding
];
```

### To Modify Waybar Modules

Edit `waybar.nix`:
```nix
modules-right = ["tray" "network" "cpu" "memory" "battery" "clock"];
```

### To Change Rofi Size

Edit `rofi.nix`:
```nix
window = {
  width = mkLiteral "500px";  # Change width
};
```

### To Add Shell Aliases

Edit `shell.nix`:
```nix
shellAliases = {
  ll = "ls -l";
  update = "sudo nixos-rebuild switch --flake .#$(hostname)";
  myalias = "your-command";  # Add new alias
};
```

## Benefits of Modular Structure

✅ **Organized** - Each app has its own file
✅ **Easy to find** - Know exactly where to look
✅ **Better git diffs** - Changes isolated per module
✅ **Reusable** - Easy to share specific configs
✅ **Scalable** - Add more modules without clutter

## Catppuccin Theming

All modules automatically use Catppuccin theming via centralized configuration in `../butcherrrr.nix`:
```nix
catppuccin = {
  enable = true;
  flavor = "mocha";
  accent = "blue";
  
  # Per-app theming
  rofi.enable = true;
  waybar.enable = true;
  mako.enable = true;
  hyprland.enable = true;
};
```

Individual module files do NOT contain `catppuccin.enable` - it's all managed centrally.

## Rebuilding

After editing any module:

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#guinea-pig
```

Then reload applications as needed:
```bash
hyprctl reload              # Hyprland
pkill waybar && waybar &    # Waybar
# Rofi and Ghostty read config on launch
```

## Adding New Modules

To add a new program module:

1. Create the file: `touch butcherrrr/newprogram.nix`
2. Add configuration:
   ```nix
   { pkgs, ... }:
   {
     programs.newprogram = {
       enable = true;
       # ... settings
     };
   }
   ```
3. Import in `../butcherrrr.nix`:
   ```nix
   imports = [
     # ... existing imports
     ./butcherrrr/newprogram.nix
   ];
   ```
4. Rebuild

## Module Descriptions

### packages.nix
Simple package list. Only includes packages WITHOUT home-manager modules.

### shell.nix
Zsh configuration with oh-my-zsh, powerlevel10k theme, and zoxide integration.

### hyprland.nix
Complete Hyprland configuration: keybindings, animations, layouts, workspace management.

### waybar.nix
Status bar with modules for workspaces, clock, CPU, memory, battery, network, audio, and tray.

### rofi.nix
Application launcher with compact sizing, fuzzy search, and icon support.

### ghostty.nix
Terminal emulator with JetBrainsMono Nerd Font, padding, and shell integration.

### services.nix
Background services:
- Mako (notifications)
- Hyprpaper (wallpaper daemon)

### theme.nix
System theming:
- GTK theme (catppuccin)
- Cursor theme (catppuccin-mocha-blue)
- Wallpaper symlink

## Resources

- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Home Manager Options](https://home-manager-options.extranix.com/)
- [Catppuccin/nix](https://github.com/catppuccin/nix)