# NixOS Configuration

Multi-host NixOS configuration with Hyprland, managed through Nix flakes.

For detailed information, see:

- `HOSTS.md` - Advanced multi-host management topics
- `hosts/README.md` - Quick host directory reference
- `home/butcherrrr/README.md` - Home Manager modules documentation

## Structure

```
nixos-config/
├── flake.nix              # Defines all hosts and inputs
├── flake.lock             # Locked dependency versions
├── hosts/                 # Per-host configurations
│   ├── guinea-pig/        # Primary host
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   └── example-host/      # Template for new hosts
├── modules/               # Shared system modules
│   ├── core.nix           # Base system (users, audio, networking, keyd)
│   ├── greetd.nix         # Display manager with auto-login
│   └── hyprland.nix       # Hyprland window manager + portals
├── home/                  # Home-manager user configs
│   ├── butcherrrr.nix     # Main user configuration
│   └── butcherrrr/        # Modular user configurations
│       ├── packages.nix   # User packages and scripts
│       ├── shell.nix      # Zsh, zoxide, and eza
│       ├── git.nix        # Git and delta configuration
│       ├── neovim.nix     # Neovim with LazyVim
│       ├── hyprland.nix   # Hyprland settings and keybinds
│       ├── waybar.nix     # Status bar configuration
│       ├── rofi.nix       # Application launcher
│       ├── ghostty.nix    # Terminal emulator
│       ├── zed.nix        # Zed editor
│       ├── hyprlock.nix   # Lock screen configuration
│       ├── services.nix   # Mako notifications
│       ├── spicetify.nix  # Spotify theming
│       └── theme.nix      # Cursor theme and wallpaper
├── scripts/               # Custom shell scripts
├── config/                # Additional config files (nvim)
└── backgrounds/           # Wallpaper images
```

## Current Hosts

- `guinea-pig` - Primary desktop/laptop

## Features

### Window Manager & Desktop

- **Hyprland** - Wayland compositor with animations and effects
- **Hyprlock** - Lock screen with auto-lock and power button integration
- **Waybar** - Status bar with system information
- **Rofi** - Application launcher with fuzzy search
- **Mako** - Notification daemon
- **Greetd** - Display manager with auto-login + hyprlock on boot

### Applications

- **Ghostty** - Modern terminal emulator
- **Neovim** - Text editor with LazyVim configuration
- **Zed** - Modern code editor with Nix LSP
- **Firefox** - Web browser
- **Spotify** - Music player with Catppuccin theme (via Spicetify)
- **Slack** - Team communication
- **Obsidian** - Note-taking app
- **imv** - Wayland-native image viewer
- **mpv** - Video player
  </text>

<old_text line=54>

### Shell & Tools

- **Zsh** - Shell with oh-my-zsh and powerlevel10k
- **Eza** - Modern `ls` replacement with icons and git integration
- **Zoxide** - Smarter `cd` command
- **Git + Delta** - Version control with syntax-highlighted diffs
- **Impala** - WiFi manager (TUI)
- **Bluetui** - Bluetooth manager (TUI)

### Shell & Tools

- **Zsh** - Shell with oh-my-zsh and powerlevel10k
- **Eza** - Modern `ls` replacement with icons and git integration
- **Zoxide** - Smarter `cd` command
- **Git + Delta** - Version control with syntax-highlighted diffs
- **Impala** - WiFi manager (TUI)
- **Bluetui** - Bluetooth manager (TUI)

### System Features

- **PipeWire** - Modern audio server (PulseAudio + ALSA support)
- **Bluetooth** - Full Bluetooth support with experimental features
- **Docker** - Container runtime with on-demand startup
- **Keyd** - Caps Lock remapped to Hyper key (Ctrl+Shift+Alt+Super)
- **Swayidle** - Auto-lock after inactivity, lock before sleep
- **Power button** - Locks screen (hold to force shutdown)
- **Webcam** - Built-in support with video group access
- **Catppuccin** - Consistent theming across all applications
- **Spicetify** - Spotify theming with Catppuccin Mocha
- **Home Manager** - Declarative user environment
- **Multi-host** - Manage multiple machines from one repo
- **LUKS encryption ready** - Secure disk encryption support
  </text>

<old_text line=81>
Or use the shell alias:

```bash
update
```

## Rebuilding

```bash
sudo nixos-rebuild switch --flake .#guinea-pig
```

Replace `guinea-pig` with your hostname.

Or use the shell alias:

```bash
update
```

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

# Clone your config to home folder
cd ~
git clone https://github.com/YOUR-USERNAME/nixos-config
cd nixos-config

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

All configuration is managed through **home-manager modules** in `home/butcherrrr/`.

**System packages:** Edit `modules/core.nix`
**User packages & config:** Edit files in `home/butcherrrr/`
**Per-host settings:** Edit `hosts/YOUR-HOSTNAME/default.nix`

See `home/butcherrrr/README.md` for detailed module documentation.

### Quick Customization Guide

**Add a package:**

```bash
nano home/butcherrrr/packages.nix
# Add package to home.packages list
```

**Add shell alias:**

```bash
nano home/butcherrrr/shell.nix
# Add to shellAliases section
```

**Change Hyprland keybinding:**

```bash
nano home/butcherrrr/hyprland.nix
# Modify bind section
```

**Change theme:**

```bash
nano home/butcherrrr.nix
# Edit catppuccin.flavor or catppuccin.accent
```

After editing, rebuild:

```bash
sudo nixos-rebuild switch --flake .#$(hostname)
```

### Catppuccin Theming

Change theme globally by editing `home/butcherrrr.nix`:

```nix
catppuccin = {
  enable = true;
  flavor = "mocha";     # mocha, macchiato, frappe, latte
  accent = "blue";      # blue, lavender, pink, mauve, red, etc.

  # Per-app theming
  rofi.enable = true;
  waybar.enable = false;  # Using custom CSS styling
  mako.enable = true;
  hyprland.enable = true;
  hyprlock.enable = false;  # Using custom config
  fzf.enable = true;
};
```

All applications will automatically use consistent colors. Spotify is themed via Spicetify.
</text>

<old_text line=247>
| `SUPER + Space` | App launcher (Rofi) |
| `SUPER + W` | Close window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + F` | Fullscreen |
| `SUPER + V` | Toggle floating |

## Hyprland Keybindings

### Main Keybindings

| Key                           | Action                   |
| ----------------------------- | ------------------------ |
| `SUPER + Return`              | Terminal (Ghostty)       |
| `SUPER + Space`               | App launcher (Rofi)      |
| `SUPER + W`                   | Close window             |
| `SUPER + M`                   | Exit Hyprland            |
| `SUPER + F`                   | Fullscreen               |
| `SUPER + V`                   | Toggle floating          |
| `SUPER + 1-9`                 | Switch workspace         |
| `SUPER + SHIFT + 1-9`         | Move window to workspace |
| `SUPER + Arrows/HJKL`         | Move focus               |
| `SUPER + SHIFT + Arrows/HJKL` | Move window              |
| `SUPER + Mouse`               | Move/resize window       |
| `Print`                       | Screenshot (selection)   |

### Hyper Key Bindings (Caps Lock)

Caps Lock is remapped to Hyper (Ctrl+Shift+Alt+Super) via keyd:

| Key              | Action                        |
| ---------------- | ----------------------------- |
| `Hyper + Return` | Toggle terminal (workspace 1) |
| `Hyper + E`      | Toggle Zed (workspace 2)      |
| `Hyper + B`      | Toggle Firefox (workspace 3)  |
| `Hyper + H/L`    | Previous/Next workspace       |
| `Hyper + 1-9`    | Switch to workspace 1-9       |

Press Caps Lock alone = Escape
Hold Caps Lock + key = Hyper modifier
</text>

<old_text line=274>

### Media Keys

| Key                            | Action          |
| ------------------------------ | --------------- |
| `F1` / `XF86AudioMute`         | Mute/unmute     |
| `F2` / `XF86AudioLowerVolume`  | Volume down     |
| `F3` / `XF86AudioRaiseVolume`  | Volume up       |
| `F5` / `XF86MonBrightnessDown` | Brightness down |
| `F6` / `XF86MonBrightnessUp`   | Brightness up   |

All media key actions show notifications with visual feedback.

### Media Keys

| Key                            | Action          |
| ------------------------------ | --------------- |
| `F1` / `XF86AudioMute`         | Mute/unmute     |
| `F2` / `XF86AudioLowerVolume`  | Volume down     |
| `F3` / `XF86AudioRaiseVolume`  | Volume up       |
| `F5` / `XF86MonBrightnessDown` | Brightness down |
| `F6` / `XF86MonBrightnessUp`   | Brightness up   |

All media key actions show notifications with visual feedback.

## Shell Enhancements

### Eza (ls replacement)

Eza is automatically configured as an `ls` replacement with the following aliases:

```bash
ls      # eza with icons and git integration
ll      # eza -l (long format)
la      # eza -la (long format with hidden files)
lt      # eza --tree (tree view)
```

Features enabled:

- Icons for file types
- Git status indicators
- Directories listed first
- Column headers
- Zsh integration with completions

### Zoxide (cd replacement)

Smart directory navigation:

```bash
z <pattern>     # Jump to directory matching pattern
zi              # Interactive directory selection
```

Learns your most-used directories over time.

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

**Hyprland not starting:**

```bash
# Check logs
journalctl -u greetd -b

# Try manual start
Hyprland
```

**Media keys not working:**

```bash
# Check key detection
wev
# Press your volume/brightness keys and verify output
```

**WiFi not connecting:**

```bash
# Use impala TUI
impala

# Or use iwctl
iwctl station wlan0 scan
iwctl station wlan0 get-networks
iwctl station wlan0 connect "SSID"
```

## Notes

- Each host needs its own `hardware-configuration.nix`
- The folder name, flake config name, and hostname must all match
- Always commit `flake.lock` for reproducibility
- System state version: 25.11
- Caps Lock is remapped to Hyper key (tap for Escape)
- Powerlevel10k prompt config (`.p10k.zsh`) is not managed by this repo
  - Run `p10k configure` on each machine to customize

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)
