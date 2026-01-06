# Advanced Multi-Host Management

This guide covers advanced topics for managing multiple NixOS machines. For basic setup, see `README.md`.

## Host Type Examples

### Desktop/Laptop Configuration

Full Hyprland desktop environment:

```nix
# hosts/desktop/default.nix
{ config, pkgs, lib, hostname, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/greetd.nix
    ../../modules/console.nix
    ../../modules/hyprland.nix
  ];

  # Hostname
  networking.hostName = hostname;

  # Timezone and locale
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System state version
  system.stateVersion = "25.11";
}
```

### Server Configuration

Minimal setup without GUI, with SSH enabled:

```nix
# hosts/server/default.nix
{ config, pkgs, lib, hostname, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    # Skip greetd.nix, console.nix, and hyprland.nix
  ];

  networking.hostName = hostname;

  # Timezone and locale
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # SSH configuration
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];  # SSH only
  };

  # System state version
  system.stateVersion = "25.11";
}
```

### Laptop Configuration

Desktop setup with power management and Bluetooth:

```nix
# hosts/laptop/default.nix
{ config, pkgs, lib, hostname, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/greetd.nix
    ../../modules/console.nix
    ../../modules/hyprland.nix
  ];

  networking.hostName = hostname;

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Laptop-specific: Power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

  # Laptop-specific: Better touchpad support
  services.libinput.enable = true;

  # System state version
  system.stateVersion = "25.11";
}
```

### Gaming Machine

Desktop with Steam and GPU acceleration:

```nix
# hosts/gaming-rig/default.nix
{ config, pkgs, lib, hostname, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/greetd.nix
    ../../modules/console.nix
    ../../modules/hyprland.nix
  ];

  networking.hostName = hostname;

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Gaming: Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Gaming: 32-bit graphics support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Gaming: GameMode for performance
  programs.gamemode.enable = true;

  # System state version
  system.stateVersion = "25.11";
}
```

## User Management

### Single User Across Multiple Hosts

If the same username is used on all machines, the same home-manager configuration can be shared:

```nix
# In flake.nix, all hosts use the same user
nixosConfigurations = {
  laptop = mkSystem {
    hostname = "laptop";
    system = "x86_64-linux";
    user = "butcherrrr";  # Same user
  };

  desktop = mkSystem {
    hostname = "desktop";
    system = "x86_64-linux";
    user = "butcherrrr";  # Same user
  };

  server = mkSystem {
    hostname = "server";
    system = "x86_64-linux";
    user = "butcherrrr";  # Same user
  };
};
```

All hosts will use `home/butcherrrr.nix` for home-manager configuration.

### Different Users Per Host

```nix
# In flake.nix
nixosConfigurations = {
  personal = mkSystem {
    hostname = "personal";
    system = "x86_64-linux";
    user = "butcherrrr";  # Uses home/butcherrrr.nix
  };

  work = mkSystem {
    hostname = "work";
    system = "x86_64-linux";
    user = "john.doe";  # Uses home/john.doe.nix (needs to be created)
  };
};
```

Create `home/john.doe.nix` following the same structure as `home/butcherrrr.nix`.

### Host-Specific Home Manager Configuration

Use the `hostname` variable for conditional configuration:

```nix
# home/butcherrrr/packages.nix
{ pkgs, hostname, ... }:

{
  home.packages = with pkgs; [
    firefox
    neovim

    # Server-specific packages
  ] ++ (if hostname == "server" then [
    htop
    tmux
  ] else [])

  # Laptop-specific packages
  ++ (if hostname == "laptop" then [
    brightnessctl
    powertop
  ] else []);
}
```

Or create separate module files:

```nix
# home/butcherrrr.nix
{ hostname, ... }:

{
  imports = [
    ./butcherrrr/packages.nix
    ./butcherrrr/shell.nix
    ./butcherrrr/git.nix
  ] ++ (if hostname != "server" then [
    # Desktop-only modules
    ./butcherrrr/hyprland.nix
    ./butcherrrr/waybar.nix
    ./butcherrrr/rofi.nix
    ./butcherrrr/ghostty.nix
  ] else []);

  home.stateVersion = "25.11";
}
```

## Advanced Operations

### Testing Changes

Test without making changes permanent:

```bash
sudo nixos-rebuild test --flake .#$(hostname)
```

The system will revert on next reboot.

### Building Without Activating

Build the configuration without switching:

```bash
sudo nixos-rebuild build --flake .#$(hostname)
```

The result will be in `./result`. Check the build before switching.

### Build for Another Host

Build a configuration for a different machine:

```bash
nixos-rebuild build --flake .#other-hostname
```

Useful for testing configurations before deploying.

### Remote Deployment

Deploy to a remote machine over SSH:

```bash
nixos-rebuild switch --flake .#hostname --target-host user@remote-host
```

The remote machine must have SSH access and nix flakes enabled.

### Dry Run

See what would change without applying:

```bash
nixos-rebuild dry-build --flake .#$(hostname)
```

Shows which packages would be installed/removed.

### Rollback

If something breaks, rollback to previous generation:

```bash
sudo nixos-rebuild switch --rollback
```

Or boot into a previous generation from the bootloader menu.

## Architecture Support

### x86_64 Systems (Intel/AMD)

```nix
desktop = mkSystem {
  hostname = "desktop";
  system = "x86_64-linux";
  user = "butcherrrr";
};
```

### ARM64 Systems (Raspberry Pi, Apple Silicon)

```nix
rpi4 = mkSystem {
  hostname = "rpi4";
  system = "aarch64-linux";
  user = "pi";
};
```

Note: Apple Silicon Macs require Asahi Linux for NixOS support.

### Cross-Compilation

Build ARM64 system on x86_64:

```nix
# In the host's default.nix
nixpkgs.config.allowUnsupportedSystem = true;
```

This is slower but useful for preparing configs before deploying to ARM hardware.

## Kernel Configuration

### Using Latest Kernel

```nix
# In the host's default.nix
boot.kernelPackages = pkgs.linuxPackages_latest;
```

### Using LTS Kernel

```nix
boot.kernelPackages = pkgs.linuxPackages;  # Default LTS
```

### Using Specific Kernel Version

```nix
boot.kernelPackages = pkgs.linuxPackages_6_6;  # Specific version
```

## Hardware-Specific Configuration

### NVIDIA Graphics

```nix
# hosts/HOSTNAME/default.nix
services.xserver.videoDrivers = [ "nvidia" ];

hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = false;
  open = false;  # Use proprietary driver
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
};

# For Hyprland
environment.sessionVariables = {
  LIBVA_DRIVER_NAME = "nvidia";
  XDG_SESSION_TYPE = "wayland";
  GBM_BACKEND = "nvidia-drm";
  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  WLR_NO_HARDWARE_CURSORS = "1";
};
```

### AMD Graphics

```nix
# hosts/HOSTNAME/default.nix
hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

# AMD GPU drivers
boot.initrd.kernelModules = [ "amdgpu" ];
```

### Intel Graphics

```nix
# hosts/HOSTNAME/default.nix
hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];
};
```

## Storage Configuration

### LUKS Encryption

```nix
# In hardware-configuration.nix or default.nix
boot.initrd.luks.devices."cryptroot" = {
  device = "/dev/disk/by-uuid/ACTUAL-UUID";
  preLVM = true;
};
```

### Btrfs Snapshots

```nix
# Enable snapper for automatic snapshots
services.snapper.configs = {
  home = {
    SUBVOLUME = "/home";
    ALLOW_USERS = [ "butcherrrr" ];
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
  };
};
```

## Network Configuration

### Static IP

```nix
networking.interfaces.eth0.ipv4.addresses = [{
  address = "192.168.1.100";
  prefixLength = 24;
}];

networking.defaultGateway = "192.168.1.1";
networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
```

### Wireguard VPN

```nix
networking.wireguard.interfaces.wg0 = {
  ips = [ "10.100.0.2/24" ];
  privateKeyFile = "/root/wireguard-keys/private";

  peers = [{
    publicKey = "SERVER_PUBLIC_KEY";
    allowedIPs = [ "0.0.0.0/0" ];
    endpoint = "vpn.example.com:51820";
    persistentKeepalive = 25;
  }];
};
```

## Troubleshooting

### Hardware Not Detected

Regenerate hardware configuration:

```bash
sudo nixos-generate-config --show-hardware-config
```

Compare with `hosts/*/hardware-configuration.nix` and update as needed.

### Module Conflicts

**Problem**: Conflicting display managers.

**Solution**: Only import greetd.nix once per host. Check imports in `hosts/*/default.nix`.

### Build Failures

```bash
# Show detailed error trace
sudo nixos-rebuild switch --flake .#$(hostname) --show-trace

# Update flake inputs
nix flake update

# Clean build cache
nix-collect-garbage -d
```

### Disk Space Issues

```bash
# Remove old generations
sudo nix-collect-garbage --delete-older-than 7d

# List generations
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Delete specific generation
sudo nix-env --delete-generations 10 --profile /nix/var/nix/profiles/system
```

## Best Practices

1. **Test on one host first** - Test major changes on one machine before deploying to all
2. **Use git branches** - Create branches for experimental changes
3. **Document quirks** - Add comments for host-specific workarounds
4. **Keep flake.lock updated** - Run `nix flake update` regularly
5. **Never share hardware-configuration.nix** - Each machine needs its own
6. **Commit before major changes** - Easy to rollback if something breaks
7. **Use descriptive hostnames** - Makes managing multiple hosts easier
8. **Backup the config** - Push to GitHub/GitLab regularly
9. **Test rollback** - Verify rollback to previous generation works
10. **Monitor disk usage** - Clean old generations periodically

## Deployment Workflow

### Initial Setup

1. Install NixOS on target machine
2. Generate hardware config: `sudo nixos-generate-config`
3. Clone the config repo
4. Copy `hardware-configuration.nix` to `hosts/NEW-HOST/`
5. Create `hosts/NEW-HOST/default.nix` (copy from example)
6. Add host to `flake.nix`
7. Commit and push
8. Deploy: `sudo nixos-rebuild switch --flake .#NEW-HOST`

### Regular Updates

```bash
# Pull latest config
cd ~/nixos-config
git pull

# Update flake inputs (packages)
nix flake update

# Apply changes
sudo nixos-rebuild switch --flake .#$(hostname)

# Push updated flake.lock
git add flake.lock
git commit -m "Update flake.lock"
git push
```

### Emergency Recovery

1. Reboot into previous generation from bootloader
2. Or manually rollback: `sudo nixos-rebuild switch --rollback`
3. Fix the issue in the config
4. Test: `sudo nixos-rebuild test --flake .#$(hostname)`
5. Apply: `sudo nixos-rebuild switch --flake .#$(hostname)`

## Resources

- [NixOS Manual - Configuration](https://nixos.org/manual/nixos/stable/#ch-configuration)
- [NixOS Wiki - Multi-Host Management](https://nixos.wiki/wiki/Flakes)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Package Search](https://search.nixos.org/packages)
- [NixOS Discourse](https://discourse.nixos.org/)
