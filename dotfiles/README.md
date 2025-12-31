# Dotfiles Directory

This directory contains configuration files that are symlinked to their expected locations by home-manager.

## Why Dotfiles?

Instead of defining configurations in Nix, we use traditional dotfiles for applications that:
- Change frequently (keybindings, colors, etc.)
- Have their own config syntax
- Benefit from instant reload (no rebuild needed)

## Current Dotfiles

- `hyprland.conf` - Hyprland window manager configuration

## How It Works

Home-manager symlinks these files to your home directory:

```
dotfiles/hyprland.conf → ~/.config/hypr/hyprland.conf
```

This is configured in `home/butcherrrr.nix`:

```nix
home.file.".config/hypr/hyprland.conf".source = ../dotfiles/hyprland.conf;
```

## Editing Dotfiles

### Recommended: Edit in Repo

```bash
cd ~/nixos-config
nano dotfiles/hyprland.conf
# Test changes (Hyprland reloads instantly)
hyprctl reload
# Or press SUPER+SHIFT+R

# If it works, commit
git add dotfiles/hyprland.conf
git commit -m "Update Hyprland config"
```

### Alternative: Edit Directly

```bash
nano ~/.config/hypr/hyprland.conf
# Test changes
hyprctl reload

# Copy back to repo
cp ~/.config/hypr/hyprland.conf ~/nixos-config/dotfiles/
cd ~/nixos-config
git add dotfiles/hyprland.conf
git commit -m "Update Hyprland config"
```

## Benefits vs Nix-Defined

**Dotfile Approach:**
- ✅ Instant reload, no rebuild
- ✅ Native syntax (copy examples directly)
- ✅ Faster iteration
- ✅ Standard Hyprland documentation applies

**Nix-Defined Approach:**
- ✅ Everything in one language
- ✅ Type-checked
- ✅ Can't accidentally edit outside Nix
- ❌ Requires rebuild to test changes

## Adding More Dotfiles

To add a new dotfile, edit `home/butcherrrr.nix`:

```nix
home.file = {
  ".config/hypr/hyprland.conf".source = ../dotfiles/hyprland.conf;
  
  # Add more:
  ".config/waybar/config".source = ../dotfiles/waybar-config.json;
  ".config/waybar/style.css".source = ../dotfiles/waybar-style.css;
  ".bashrc".source = ../dotfiles/bashrc;
};
```

Then create the files in this directory and rebuild:

```bash
sudo nixos-rebuild switch --flake .#$(hostname)
```

## Testing Changes

Most Wayland applications support live reload:

- **Hyprland**: `hyprctl reload` or `SUPER+SHIFT+R`
- **Waybar**: `pkill waybar && waybar &`
- **Mako**: `makoctl reload`

No system rebuild needed!