# Dotfiles Directory

This directory contains configuration files that are symlinked to their expected locations by home-manager.

## 🎨 Theming

**All colors are managed by the [catppuccin/nix](https://github.com/catppuccin/nix) module.**

These dotfiles contain only **layout, sizing, and behavior** settings. Colors are automatically applied by the Catppuccin theme system, making it easy to switch themes globally.

To change colors, edit `home/butcherrrr.nix`:

```nix
catppuccin = {
  enable = true;
  flavor = "mocha";     # mocha, macchiato, frappe, latte
  accent = "blue";      # blue, lavender, pink, teal, etc.
};
```

See `CATPPUCCIN.md` for more details.

## Directory Structure

```
dotfiles/
├── hyprland/
│   └── hyprland.conf      # Window manager config (no colors)
├── waybar/
│   ├── config.json        # Status bar config
│   └── style.css          # Status bar styling (no colors)
├── ghostty/
│   └── config             # Terminal config (no colors)
├── rofi/
│   └── config.rasi        # App launcher config (no colors)
└── README.md              # This file
```

## How It Works

Home-manager symlinks these files to your home directory:

```
dotfiles/hyprland/hyprland.conf → ~/.config/hypr/hyprland.conf
dotfiles/waybar/config.json     → ~/.config/waybar/config
dotfiles/waybar/style.css       → ~/.config/waybar/style.css
dotfiles/ghostty/config         → ~/.config/ghostty/config
dotfiles/rofi/config.rasi       → ~/.config/rofi/config.rasi
```

This is configured in `home/butcherrrr.nix`:

```nix
home.file.".config/hypr/hyprland.conf".source = ../dotfiles/hyprland/hyprland.conf;
```

## Editing Dotfiles

### Recommended: Edit in Repo

```bash
cd ~/nixos-config
vim dotfiles/hyprland/hyprland.conf
# Rebuild to update symlinks
sudo nixos-rebuild switch --flake .#guinea-pig
# Reload application
hyprctl reload
```

### What's in These Files

- **Layout & sizing**: Window sizes, padding, margins, gaps
- **Behavior**: Keybindings, animations, sorting, matching
- **Structure**: Bar modules, launcher modes, terminal features
- **Typography**: Font families, font sizes

**NOT in these files:**
- Colors, themes, or palettes (managed by catppuccin/nix)

## Benefits of This Approach

**Dotfile Approach:**
- ✅ Instant reload, no rebuild needed for most changes
- ✅ Native syntax (copy examples directly)
- ✅ Faster iteration for keybindings and layout
- ✅ Standard app documentation applies

**Catppuccin Integration:**
- ✅ Consistent colors across all apps
- ✅ Easy theme switching (one line change)
- ✅ No manual color maintenance
- ✅ Official, well-maintained themes

## Adding More Dotfiles

To add a new dotfile:

1. Create a directory for the app: `mkdir dotfiles/myapp/`
2. Add the config file: `dotfiles/myapp/config`
3. Edit `home/butcherrrr.nix`:

```nix
home.file = {
  ".config/hypr/hyprland.conf".source = ../dotfiles/hyprland/hyprland.conf;
  
  # Add more:
  ".config/myapp/config".source = ../dotfiles/myapp/config;
};
```

4. Rebuild:

```bash
sudo nixos-rebuild switch --flake .#guinea-pig
```

## Testing Changes

After rebuilding, most applications support live reload:

- **Hyprland**: `hyprctl reload` or `Super + Shift + R`
- **Waybar**: `pkill waybar && waybar &`
- **Mako**: `makoctl reload`
- **Rofi**: Just launch it - reads config every time (`Super + Space`)
- **Ghostty**: Restart terminal

**Note:** You must rebuild first to update symlinks, then reload the application.

## Theme Changes

Want to try a different Catppuccin flavor or accent color?

1. Edit `home/butcherrrr.nix`:
   ```nix
   catppuccin.flavor = "macchiato";  # Try a warmer dark theme
   catppuccin.accent = "lavender";   # Try purple accents
   ```

2. Rebuild:
   ```bash
   sudo nixos-rebuild switch --flake .#guinea-pig
   ```

3. Reload apps (most pick up changes automatically)

All your dotfiles will use the new colors without any manual editing!

## Resources

- [catppuccin/nix Documentation](https://github.com/catppuccin/nix)
- [Catppuccin Color Palette](https://github.com/catppuccin/catppuccin)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Waybar Documentation](https://github.com/Alexays/Waybar/wiki)
- [Rofi Documentation](https://github.com/davatorium/rofi)