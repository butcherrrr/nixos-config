# NixOS Configuration

Multi-host NixOS configuration with Hyprland, managed through Nix flakes.

For detailed information, see:
- `HOSTS.md` - Advanced multi-host management topics
- `CHANGES.md` - Summary of configuration restructure
- `hosts/README.md` - Quick host directory reference

## Structure

```
nixos-config/
├── flake.nix              # Defines all hosts
├── flake.lock             # Locked dependency versions
├── hosts/                 # Per-host configurations
│   ├── guinea-pig/        # Example host
│   └── example-host/      # Template for new hosts
├── modules/               # Shared system modules
│   ├── core.nix           # Base system (users, audio, networking)
│   ├── greetd.nix         # Display manager
│   └── hyprland.nix       # Hyprland window manager
└── home/                  # Home-manager user configs
    └── butcherrrr.nix     # User packages and settings
```

## Current Hosts

- `guinea-pig` - Primary desktop/laptop

## Features

- **Hyprland** - Wayland compositor with animations and effects
- **Waybar** - Status bar with system information
- **Rofi** - Application launcher
- **Ghostty** - Terminal emulator
- **Catppuccin** - Consistent theming across all applications
- **Greetd** - Minimal display manager with auto-login
- **PipeWire** - Modern audio server (PulseAudio + ALSA support)
- **Home Manager** - Declarative user environment
- **Multi-host** - Manage multiple machines from one repo

## Rebuilding

```bash
sudo nixos-rebuild switch --flake .#guinea-pig
```

Replace `guinea-pig` with your hostname.

## Adding a New Host

See `HOSTS.md` for advanced scenarios. Basic process:

### 1. On Your Current Machine

```bash
cd ~/nixos-config

# Copy template
cp -r hosts/example-host hosts/NEW-HOSTNAME

# Edit configuration
nano hosts/NEW-HOSTNAME/default.nix
# Adjust: timezone, locale, which modules to import

# Add to flake.nix
nano flake.nix
```

In `flake.nix`, add under `nixosConfigurations`:

```nix
NEW-HOSTNAME = mkSystem {
  hostname = "NEW-HOSTNAME";
  system = "x86_64-linux";
  user = "butcherrrr";
};
```

Commit and push:

```bash
git add .
git commit -m "Add NEW-HOSTNAME configuration"
git push
```

### 2. On the New Machine

**Install NixOS** (minimal installation):

```bash
# Partition, format, mount disks
# Then:
sudo nixos-generate-config --root /mnt
sudo nixos-install
# Set root password
reboot
```

**After first boot** (login as root):

```bash
# Enable networking
systemctl start NetworkManager
nmcli device wifi connect "SSID" password "PASSWORD"

# Enable flakes temporarily
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Clone your config
git clone https://github.com/YOUR-USERNAME/nixos-config /etc/nixos/config
cd /etc/nixos/config

# Copy hardware config
cp /etc/nixos/hardware-configuration.nix hosts/NEW-HOSTNAME/

# Commit hardware config
git add hosts/NEW-HOSTNAME/hardware-configuration.nix
git commit -m "Add NEW-HOSTNAME hardware config"
git push

# Rebuild with your config
sudo nixos-rebuild switch --flake .#NEW-HOSTNAME

# Reboot
reboot
```

After reboot, login as your user (created automatically).

## Updating

```bash
cd ~/nixos-config
git pull
nix flake update              # Update dependencies
sudo nixos-rebuild switch --flake .#$(hostname)
```

## Module Selection

In `hosts/YOUR-HOSTNAME/default.nix`:

**Desktop/Laptop:** `core.nix` + `greetd.nix` + `hyprland.nix`  
**Server:** `core.nix` only

See `HOSTS.md` for more host type examples.

## Customization

All configuration is managed through **home-manager modules** in `home/butcherrrr.nix`.

**System packages:** Edit `modules/core.nix`  
**User packages & config:** Edit `home/butcherrrr.nix`  
**Per-host settings:** Edit `hosts/YOUR-HOSTNAME/default.nix`

### Configuration Structure

- **Hyprland:** `wayland.windowManager.hyprland.settings`
- **Waybar:** `programs.waybar.settings`
- **Rofi:** `programs.rofi`
- **Ghostty:** `programs.ghostty`
- **Theme:** `catppuccin.flavor` and `catppuccin.accent`

After editing, rebuild:
```bash
sudo nixos-rebuild switch --flake .#$(hostname)
hyprctl reload  # Or press SUPER+SHIFT+R
```

### Catppuccin Theming

Change theme globally by editing `home/butcherrrr.nix`:
```nix
catppuccin = {
  enable = true;
  flavor = "mocha";     # mocha, macchiato, frappe, latte
  accent = "blue";      # blue, lavender, pink, etc.
  
  # Per-app theming
  rofi.enable = true;
  waybar.enable = true;
  mako.enable = true;
  hyprland.enable = true;
};
```

All applications will automatically use consistent colors.

## Hyprland Keybindings

| Key | Action |
|-----|--------|
| `SUPER + Return` | Terminal |
| `SUPER + Space` | App launcher |
| `SUPER + W` | Close window |
| `SUPER + M` | Exit |
| `SUPER + F` | Fullscreen |
| `SUPER + 1-9` | Switch workspace |
| `SUPER + SHIFT + 1-9` | Move window to workspace |
| `SUPER + Arrows/HJKL` | Move focus |
| `Print` | Screenshot (selection) |

## Troubleshooting

**Dirty git tree warning:**
```bash
git status               # Check for uncommitted files
git add flake.lock       # Commit flake.lock
git commit -m "Update flake.lock"
```

**Build errors:**
```bash
nix flake update         # Update dependencies
sudo nixos-rebuild switch --flake .#$(hostname) --show-trace
```

**Test without switching:**
```bash
sudo nixos-rebuild test --flake .#$(hostname)
```

## Notes

- Each host needs its own `hardware-configuration.nix`
- The folder name, flake config name, and hostname must all match
- Always commit `flake.lock` for reproducibility
- System state version: 25.11

## Testing Media Keys

After deploying the config, test the volume and brightness controls:

### Volume Keys
- **Volume Up**: `XF86AudioRaiseVolume` (usually F3 or a dedicated key)
- **Volume Down**: `XF86AudioLowerVolume` (usually F2 or a dedicated key)
- **Mute**: `XF86AudioMute` (usually F1 or a dedicated key)

Each volume change will show a notification with:
- Current volume percentage
- Volume icon (changes based on level)
- Progress bar

### Brightness Keys
- **Brightness Up**: `XF86MonBrightnessUp` (usually F6 or a dedicated key)
- **Brightness Down**: `XF86MonBrightnessDown` (usually F5 or a dedicated key)

Each brightness change will show a notification with:
- Current brightness percentage
- Brightness icon (changes based on level)
- Progress bar

### Testing Without Physical Keys

If you want to test the functionality without the physical keys:

```bash
# Test volume
~/.local/bin/volume up
~/.local/bin/volume down
~/.local/bin/volume mute

# Test brightness
~/.local/bin/brightness up
~/.local/bin/brightness down
```

### Debugging Key Detection

If the keys don't work, check if they're being detected:

```bash
# Run wev and press your volume/brightness keys
wev
```

Look for lines like:
```
sym: XF86AudioRaiseVolume
sym: XF86AudioLowerVolume
sym: XF86MonBrightnessUp
```

If you see different key names, update the bindings in `home/butcherrrr/hyprland.nix`.
