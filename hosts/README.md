# Hosts Directory

Each subdirectory represents one machine configuration. Current hosts:

- `guinea-pig/` - Primary host (desktop/laptop)
- `example-host/` - Template (copy this for new hosts)

## Directory Structure

Each host directory contains:

```
hosts/YOUR-HOSTNAME/
├── default.nix                 # Host-specific configuration
└── hardware-configuration.nix  # Auto-generated hardware config
```

## Quick Reference

### Adding a New Host

```bash
# 1. Copy template
cp -r hosts/example-host hosts/NEW-HOSTNAME

# 2. Edit hosts/NEW-HOSTNAME/default.nix
nano hosts/NEW-HOSTNAME/default.nix
# Adjust: hostname, timezone, locale, which modules to import

# 3. Add to flake.nix under nixosConfigurations
nano flake.nix

# 4. On target machine after NixOS install:
sudo nixos-generate-config --root /mnt  # During installation
# Or after first boot:
sudo nixos-generate-config

# 5. Copy hardware config to your repo
cp /etc/nixos/hardware-configuration.nix hosts/NEW-HOSTNAME/

# 6. Commit and push
git add hosts/NEW-HOSTNAME/
git commit -m "Add NEW-HOSTNAME configuration"
git push

# 7. Rebuild on target machine
sudo nixos-rebuild switch --flake .#NEW-HOSTNAME
```

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
    ../../modules/greetd.nix      # Display manager
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

This file is auto-generated and contains hardware-specific settings:

- **File systems**: Partitions and mount points
- **Boot configuration**: initrd modules, kernel modules
- **CPU**: Microcode updates (Intel/AMD)
- **Swap**: Swap file or partition configuration
- **Network interfaces**: Detected network hardware

**Important**:

- Never manually edit unless you know what you're doing
- Never copy between machines (each has unique hardware)
- Regenerate if you change hardware: `sudo nixos-generate-config`

## Module Selection

Choose which modules to import based on host type:

### Desktop/Laptop

Full graphical environment with Hyprland:

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix        # Base system (required)
  ../../modules/greetd.nix      # Display manager
  ../../modules/hyprland.nix    # Hyprland + portals
];
```

### Server

Minimal setup without GUI:

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix        # Base system only
];
```

Then add server-specific services in `default.nix`:

```nix
services.openssh.enable = true;
networking.firewall.allowedTCPPorts = [ 22 ];
```

### Laptop (with power management)

Desktop setup plus power optimization:

```nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix
  ../../modules/greetd.nix
  ../../modules/hyprland.nix
];

# Laptop-specific
services.tlp.enable = true;
services.libinput.enable = true;
```

## Available System Modules

Located in `modules/`:

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

- Minimal display manager
- Auto-login to Hyprland
- Starts window manager automatically

Skip this for servers or if you want manual login.

### hyprland.nix

**For desktop/laptop hosts**

Provides:

- Hyprland window manager (system-level)
- XDG desktop portals (Hyprland + GTK)
- Wayland utilities (wl-clipboard, grim, slurp)

User-specific Hyprland config is in `home/butcherrrr/hyprland.nix`.

## Host-Specific Configuration Examples

### Different Timezone

```nix
# In hosts/YOUR-HOST/default.nix
time.timeZone = "America/New_York";
```

### Different Kernel

```nix
# Latest kernel
boot.kernelPackages = pkgs.linuxPackages_latest;

# Specific version
boot.kernelPackages = pkgs.linuxPackages_6_6;
```

### NVIDIA Graphics

```nix
services.xserver.videoDrivers = [ "nvidia" ];
hardware.nvidia.modesetting.enable = true;
```

### Static IP

```nix
networking.interfaces.eth0.ipv4.addresses = [{
  address = "192.168.1.100";
  prefixLength = 24;
}];
```

### Encrypted Drive

```nix
boot.initrd.luks.devices."cryptroot" = {
  device = "/dev/disk/by-uuid/YOUR-UUID";
  preLVM = true;
};
```

## Flake Integration

Each host must be defined in `flake.nix`:

```nix
nixosConfigurations = {
  guinea-pig = mkSystem {
    hostname = "guinea-pig";
    system = "x86_64-linux";
    user = "butcherrrr";
  };

  # Add your new host here
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

## Rebuilding

### Current Host

```bash
sudo nixos-rebuild switch --flake .#$(hostname)
```

Or use the shell alias:

```bash
nrs
```

### Specific Host

```bash
sudo nixos-rebuild switch --flake .#guinea-pig
```

### Test Without Committing

```bash
sudo nixos-rebuild test --flake .#$(hostname)
```

### Build Only (Don't Activate)

```bash
sudo nixos-rebuild build --flake .#$(hostname)
```

## Troubleshooting

### Can't Find Host Configuration

**Error**: `error: attribute 'nixosConfigurations.YOUR-HOST' missing`

**Solution**: Check that hostname matches in:

- Directory name
- `flake.nix` config
- `networking.hostName` in `default.nix`

### Hardware Config Missing

**Error**: `error: getting status of '/nix/store/.../hardware-configuration.nix': No such file or directory`

**Solution**: Generate hardware config:

```bash
sudo nixos-generate-config
cp /etc/nixos/hardware-configuration.nix hosts/YOUR-HOST/
```

### Module Not Found

**Error**: `error: path '/etc/nixos/modules/core.nix' does not exist`

**Solution**: Check import paths use relative paths:

```nix
imports = [
  ../../modules/core.nix  # Correct (relative)
];
```

Not:

```nix
imports = [
  /etc/nixos/modules/core.nix  # Wrong (absolute)
];
```

### Build Succeeds But System Won't Boot

**Solution**: Boot into previous generation from bootloader, then:

```bash
sudo nixos-rebuild switch --rollback
```

Check `hardware-configuration.nix` for correct boot settings.

## Best Practices

1. **One host, one directory** - Keep each machine's config separate
2. **Commit hardware config** - Track hardware-configuration.nix in git
3. **Document quirks** - Add comments for host-specific workarounds
4. **Use example-host** - Copy from template for consistency
5. **Test before push** - Rebuild successfully before committing
6. **Keep it simple** - Put shared config in modules/, not per-host
7. **Regular backups** - Push to GitHub/GitLab after major changes

## See Also

- `../README.md` - Main documentation and setup guide
- `../HOSTS.md` - Advanced multi-host management (servers, laptops, etc.)
- `../home/butcherrrr/README.md` - Home Manager modules documentation
- `../modules/` - System-wide modules documentation
