# Multi-Host Management

## Current Hosts

- `x1/` - Primary laptop
- `guinea-pig/` - Test/build laptop

## Directory Structure

Each host directory contains:

```
hosts/HOSTNAME/
├── default.nix                 # Host-specific configuration
└── hardware-configuration.nix  # Auto-generated hardware config
```

---

## Bootstrap on Fresh NixOS Install

After installing NixOS from USB, the minimal installation doesn't include git. Bootstrap the system to clone this repo:

```bash
# Enable networking (if needed)
# For WiFi via NetworkManager (if available in minimal install)
nmcli device wifi connect "SSID" password "PASSWORD"

# Use nix-shell to temporarily get git and vim
nix-shell -p git vim

# Clone the repo via HTTPS
git clone https://github.com/butcherrrr/nixos-config
cd nixos-config
```

Once the repo is cloned, proceed with adding the new host configuration.

---

## Adding a New Host

```bash
# 1. Copy an existing host as a template
cp -r hosts/x1 hosts/NEW-HOSTNAME

# 2. Edit hosts/NEW-HOSTNAME/default.nix
vim hosts/NEW-HOSTNAME/default.nix
# Adjust: hostname, timezone, locale, which modules to import

# 3. Add to flake.nix under nixosConfigurations
vim flake.nix

# 4. On target machine after NixOS install:
sudo nixos-generate-config --root /mnt  # During installation
# Or after first boot:
sudo nixos-generate-config

# 5. Copy hardware config to the repo
cp /etc/nixos/hardware-configuration.nix hosts/NEW-HOSTNAME/

# 6. Commit and push
git add hosts/NEW-HOSTNAME/
git commit -m "Add NEW-HOSTNAME configuration"
git push

# 7. Rebuild on target machine
sudo nixos-rebuild switch --flake .#NEW-HOSTNAME
```

---

## Host Configuration Files

### default.nix

This file contains host-specific settings:

- **Hostname**: Set via `networking.hostName`
- **Timezone**: Set via `time.timeZone`
- **Locale**: Set via `i18n.defaultLocale` and `i18n.extraLocaleSettings`
- **Bootloader**: Configure systemd-boot or GRUB
- **Module imports**: Which system modules to use
- **Host-specific packages**: Packages only needed on this machine
- **Hardware settings**: GPU drivers, power management, etc.

**Example:**

```nix
{ config, pkgs, lib, hostname, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix        # Base system
    ../../modules/greetd.nix      # Greetd + tuigreet login
    ../../modules/console.nix     # Console configuration
    ../../modules/hyprland.nix    # Window manager
  ];

  # Hostname
  networking.hostName = hostname;

  # Timezone and locale
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System state version
  system.stateVersion = "25.11";
}
```

### hardware-configuration.nix

This file is auto-generated and contains hardware-specific settings.

**Important**:

- Never manually edit unless necessary and understood
- Never copy between machines (each has unique hardware)
- Regenerate if hardware changes: `sudo nixos-generate-config`

---

## Host Type Examples

### Desktop/Laptop

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix
  ../../modules/greetd.nix
  ../../modules/console.nix
  ../../modules/hyprland.nix
];
```

### Server

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix
  # Skip greetd.nix, console.nix, hyprland.nix
];

services.openssh.enable = true;
```

### Laptop (with power management)

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix
  ../../modules/greetd.nix
  ../../modules/console.nix
  ../../modules/hyprland.nix
];

services.tlp.enable = true;
services.libinput.enable = true;
```

---

## Available System Modules

Located in `../modules/`:

### core.nix

**Required for all hosts**

Provides:

- User account configuration
- Networking (iwd for WiFi)
- Keyboard layout and keyd (Caps Lock → Hyper)
- Audio (PipeWire)
- Bluetooth
- Fonts (JetBrainsMono Nerd Font)
- System packages (curl, wget, ripgrep, jq, impala, bluetui, btop)
- Zsh system-wide

### greetd.nix

**For desktop/laptop hosts**

Provides:

- Greetd display manager with tuigreet (text-based login)
- Password-based login with Catppuccin theming
- Automatic Hyprland startup after login
- Gnome-keyring integration via PAM (unlocks with login password)

Skip this for servers or for manual login.

### console.nix

**For desktop/laptop hosts**

Provides:

- Large console font configuration (ter-v32n)
- Lower resolution for bigger text (consoleMode = "1")
- Quieted boot messages
- Intel graphics driver early loading

Skip this for servers or if console appearance doesn't matter.

### hyprland.nix

**For desktop/laptop hosts**

Provides:

- Hyprland window manager (system-level)
- XDG desktop portals (Hyprland + GTK)
- Wayland utilities (wl-clipboard, grim, slurp)

User-specific Hyprland config is in `../home/butcherrrr/hyprland.nix`.

---

## Flake Integration

Each host must be defined in `../flake.nix`:

```nix
nixosConfigurations = {
  guinea-pig = mkSystem {
    hostname = "guinea-pig";
    system = "x86_64-linux";
    user = "butcherrrr";
  };

  # Add new host here
  new-hostname = mkSystem {
    hostname = "new-hostname";
    system = "x86_64-linux";
    user = "butcherrrr";
  };
};
```

**Important**: The hostname in three places must match:

1. Directory name: `hosts/new-hostname/`
2. Flake config: `new-hostname = mkSystem { hostname = "new-hostname"; ... }`
3. Actual machine hostname (set by `networking.hostName`)
