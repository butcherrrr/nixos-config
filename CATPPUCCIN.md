# Catppuccin Theme Integration

This configuration uses [catppuccin/nix](https://github.com/catppuccin/nix) for automatic, consistent theming across all applications.

## What is catppuccin/nix?

It's a NixOS/home-manager module that automatically applies the Catppuccin theme to over 70 applications. Instead of manually configuring colors for each app, you enable Catppuccin once and it themes everything consistently.

## Current Configuration

### Global Settings

```nix
catppuccin = {
  enable = true;
  flavor = "mocha";  # Dark theme
  accent = "blue";   # Primary accent color
};
```

### Supported Applications (Auto-themed)

The following applications in your config are **automatically themed** by catppuccin/nix:

- ✅ **Hyprland** - Window manager
- ✅ **Waybar** - Status bar
- ✅ **Rofi** - Application launcher
- ✅ **Mako** - Notification daemon
- ✅ **Ghostty** - Terminal emulator
- ✅ **Zsh** - Shell (syntax highlighting)
- ✅ **Neovim** - Text editor
- ✅ **GTK** - System-wide GTK theme
- ✅ **Cursors** - Mouse cursor theme

### Manual Configs (Can be Removed)

Now that catppuccin/nix is integrated, you can **optionally remove** manual color configs from:

- `dotfiles/rofi/config.rasi` - Color definitions
- `dotfiles/waybar/style.css` - Color variables
- `dotfiles/ghostty/config` - Theme/palette settings
- `dotfiles/hyprland/hyprland.conf` - Border colors

The catppuccin module will handle these automatically!

## Available Flavors

Change the `flavor` option to switch themes:

| Flavor      | Description           |
|-------------|-----------------------|
| `mocha`     | Dark (current)        |
| `macchiato` | Dark, warmer          |
| `frappe`    | Dark, cooler          |
| `latte`     | Light                 |

## Available Accents

Change the `accent` option for different highlight colors:

| Accent      | Color                 |
|-------------|-----------------------|
| `blue`      | Blue (current)        |
| `lavender`  | Light purple          |
| `sapphire`  | Bright blue           |
| `sky`       | Light blue            |
| `teal`      | Blue-green            |
| `green`     | Green                 |
| `yellow`    | Yellow                |
| `peach`     | Orange                |
| `maroon`    | Dark red              |
| `red`       | Red                   |
| `mauve`     | Purple                |
| `pink`      | Pink                  |
| `flamingo`  | Light pink            |
| `rosewater` | Pale pink             |

## Switching Themes

### Try a Different Flavor

Edit `home/butcherrrr.nix`:

```nix
catppuccin = {
  enable = true;
  flavor = "macchiato";  # Try macchiato instead of mocha
  accent = "blue";
};
```

### Try a Different Accent

```nix
catppuccin = {
  enable = true;
  flavor = "mocha";
  accent = "lavender";  # Try lavender instead of blue
};
```

### Apply Changes

```bash
sudo nixos-rebuild switch --flake .#guinea-pig
```

Most apps will pick up the theme immediately. For some (like Hyprland), reload:

```bash
hyprctl reload
# or
Super + Shift + R
```

## Per-Application Control

You can disable catppuccin for specific apps if you want manual control:

```nix
catppuccin.enable = true;

# Disable for specific programs
programs.rofi.catppuccin.enable = false;
programs.waybar.catppuccin.enable = false;
```

Then you can use your custom configs in `dotfiles/`.

## Migration Notes

### Before (Manual Theming)

You manually defined Catppuccin colors in each config:

- Rofi: `bg: #1e1e2e; blue: #89b4fa;`
- Waybar: `@base: #1e1e2e; @blue: #89b4fa;`
- Ghostty: `palette = ...`

### After (Automatic Theming)

The catppuccin module handles all colors automatically. You just set:

```nix
catppuccin.flavor = "mocha";
```

And all apps use consistent colors!

### Hybrid Approach (Current)

Right now, you have **both**:
- Catppuccin module enabled (automatic)
- Manual color configs in `dotfiles/` (manual)

This works fine, but the manual configs will **override** the automatic ones. You can:

1. **Keep manual configs** - Full control, but more maintenance
2. **Remove manual colors** - Let catppuccin handle everything
3. **Hybrid** - Use catppuccin, but override specific apps

## Checking What's Themed

To see all available catppuccin options:

```bash
nix repl
:lf .
:p homeConfigurations."butcherrrr@guinea-pig".options.catppuccin
```

Or check the [official docs](https://nix.catppuccin.com/).

## Troubleshooting

### Theme not applied to an app

1. Check if the app is supported: https://github.com/catppuccin/nix#-supported-projects
2. Make sure `catppuccin.enable = true;` is set
3. Rebuild: `sudo nixos-rebuild switch --flake .#guinea-pig`
4. Restart the app or reload its config

### Want manual control over one app

Disable catppuccin for that app:

```nix
programs.myapp.catppuccin.enable = false;
```

Then use your manual config in `dotfiles/`.

### Colors look wrong

Make sure you're using a compatible terminal with true color support. Ghostty supports this by default.

## Resources

- [catppuccin/nix GitHub](https://github.com/catppuccin/nix)
- [Catppuccin Color Palette](https://github.com/catppuccin/catppuccin)
- [Supported Applications](https://github.com/catppuccin/nix#-supported-projects)
- [Home Manager Options](https://nix.catppuccin.com/options/home-manager-options.html)

## Example: Full Theme Switch

Want to try a light theme?

```nix
catppuccin = {
  enable = true;
  flavor = "latte";     # Light theme!
  accent = "sapphire";  # Bright blue accent
};
```

Rebuild and see your entire desktop switch to a light theme!

```bash
sudo nixos-rebuild switch --flake .#guinea-pig
```
