# Home Manager Modules

This directory contains modular home-manager configurations for user `butcherrrr`.

## Structure

```
butcherrrr/
├── packages.nix         # User packages and custom scripts
├── shell.nix            # Zsh shell and zoxide configuration
├── hyprland.nix         # Hyprland window manager settings
├── waybar.nix           # Status bar configuration
├── waybar-style.css     # Waybar styling (Catppuccin Mocha)
├── rofi.nix             # Application launcher configuration
├── ghostty.nix          # Terminal emulator configuration
├── services.nix         # Background services (mako, swaybg)
├── theme.nix            # Cursor theming and wallpaper
└── README.md            # This file
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

### To Customize Waybar Colors/Styling

Edit `waybar-style.css`:
```css
#clock {
  padding: 0 16px;
  color: #cdd6f4;
  background: rgba(137, 180, 250, 0.1);
}
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
  waybar.enable = false;  # Using custom manual styling in waybar-style.css
  mako.enable = true;
  hyprland.enable = true;
};
```

**Note:** Waybar uses custom CSS styling (`waybar-style.css`) instead of the catppuccin module to allow fine-grained control over colors and layout.

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
Package list and custom scripts:
- User packages (only those WITHOUT home-manager modules)
- Custom scripts installed to `~/.local/bin/`
  - `toggle-terminal` - Focus or launch terminal (bound to Hyper+T)

### shell.nix
Zsh configuration with oh-my-zsh, powerlevel10k theme, and zoxide integration.

### hyprland.nix
Complete Hyprland configuration:
- Keybindings (including Hyper key bindings)
- Window rules (e.g., ghostty bound to workspace 1)
- Animations and visual effects
- Multi-monitor setup
- Workspace management

### waybar.nix
Status bar configuration and styling:
- `waybar.nix` - Module configuration (which modules to show)
- `waybar-style.css` - Visual styling (Catppuccin Mocha colors)
- Modules: workspaces, clock, CPU, memory, battery, network, audio, tray

### rofi.nix
Application launcher with compact sizing, fuzzy search, and icon support.

### ghostty.nix
Terminal emulator with JetBrainsMono Nerd Font, padding, and shell integration.

### services.nix
Background services:
- Mako (notification daemon)
- Swaybg (wallpaper daemon - started via Hyprland's exec-once)

### theme.nix
System theming:
- Cursor theme (catppuccin-mocha-blue)
- Wallpaper symlink (`~/.config/hypr/wallpaper.jpg`)

## Custom Scripts

Scripts are located in `../../scripts/` and installed to `~/.local/bin/`:

### toggle-terminal
Bound to `Hyper+T` - Opens or focuses the terminal:
- If ghostty is running: switches to workspace 1 and focuses it
- If ghostty is not running: switches to workspace 1 and opens it
- Ghostty is always bound to workspace 1 via window rules

## Shell Configuration

### Powerlevel10k
The p10k theme configuration is NOT managed in the repo to avoid language detection issues on GitHub. Each machine configures its own prompt:
1. Run `p10k configure` on the machine
2. The `.p10k.zsh` file is saved locally in your home directory
3. It persists across rebuilds (not managed by home-manager)

### Syntax Highlighting
Zsh syntax highlighting is enabled with custom colors:
- Paths: no highlighting (to avoid the "red = error" association)
- Slashes: no highlighting
- Other elements: use default colors

## Resources

- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Home Manager Options](https://home-manager-options.extranix.com/)
- [Catppuccin/nix](https://github.com/catppuccin/nix)