# Multi-Host Management Guide

This NixOS configuration is designed to manage multiple computers from a single repository. Each host (computer) can have its own unique configuration while sharing common modules.

## Repository Structure

```
nixos-config/
├── flake.nix                    # Main flake file - defines all hosts
├── flake.lock                   # Locked dependency versions
├── hosts/                       # Host-specific configurations
│   ├── nixos/                   # Your primary machine
│   │   ├── default.nix          # Host configuration
│   │   └── hardware-configuration.nix
│   └── example-host/            # Template for new hosts
│       ├── default.nix
│       └── hardware-configuration.nix
├── modules/                     # Shared system modules
│   ├── core.nix                 # Core system configuration
│   ├── greetd.nix               # Display manager
│   └── hyprland.nix             # Hyprland window manager
└── home/                        # Home-manager user configurations
    └── butcherrrr.nix           # User-specific settings
```

## Adding a New Host

### Step 1: Create Host Directory

Copy the example host template:

```bash
cd ~/nixos-config
cp -r hosts/example-host hosts/YOUR-HOSTNAME
```

### Step 2: Generate Hardware Configuration

On the target machine, generate its hardware configuration:

```bash
# If you're on the target machine:
sudo nixos-generate-config --show-hardware-config > ~/nixos-config/hosts/YOUR-HOSTNAME/hardware-configuration.nix

# Or if you're setting up remotely:
# 1. Boot the target machine with NixOS installer
# 2. Generate config: sudo nixos-generate-config
# 3. Copy /etc/nixos/hardware-configuration.nix to your repo
```

### Step 3: Customize Host Configuration

Edit `hosts/YOUR-HOSTNAME/default.nix`:

- Set the correct timezone
- Adjust locale settings
- Choose which modules to import (remove what you don't need)
- Add host-specific configuration

Example customizations:

```nix
# For a laptop, you might want:
services.tlp.enable = true;  # Power management
services.blueman.enable = true;  # Bluetooth

# For a server, you might want:
services.openssh.enable = true;  # Remote access
# And remove greetd.nix and hyprland.nix from imports

# For a gaming machine:
programs.steam.enable = true;
hardware.opengl.driSupport32Bit = true;
```

### Step 4: Add Host to flake.nix

Edit `flake.nix` and add your host to `nixosConfigurations`:

```nix
nixosConfigurations = {
  # Existing hosts...
  nixos = mkSystem { ... };
  
  # Your new host
  YOUR-HOSTNAME = mkSystem {
    hostname = "YOUR-HOSTNAME";
    system = "x86_64-linux";  # or "aarch64-linux" for ARM
    user = "your-username";
  };
};
```

### Step 5: Build and Deploy

On the target machine:

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#YOUR-HOSTNAME
```

## Managing Different Host Types

### Desktop/Laptop Configuration

**Modules to include:**
- `core.nix` - Essential system configuration
- `greetd.nix` - Graphical login
- `hyprland.nix` - Window manager

**Additional considerations:**
- Laptop: Add power management (`services.tlp.enable = true`)
- Gaming: Enable Steam, gamemode, etc.
- Multiple monitors: Configure in Hyprland settings

### Server Configuration

**Modules to include:**
- `core.nix` - Essential system configuration

**Modules to exclude:**
- `greetd.nix` - No graphical login needed
- `hyprland.nix` - No GUI needed

**Additional configuration:**
```nix
# Enable SSH
services.openssh = {
  enable = true;
  settings.PasswordAuthentication = false;  # Security
  settings.PermitRootLogin = "no";
};

# Enable firewall
networking.firewall.enable = true;
networking.firewall.allowedTCPPorts = [ 22 80 443 ];
```

### Work Machine Configuration

You might want to create a separate work user or add work-specific packages:

```nix
# In your host's default.nix
environment.systemPackages = with pkgs; [
  slack
  zoom-us
  teams
  vscode
];
```

## User Management

### Single User Across Multiple Hosts

If you use the same username on all machines, you can share the same home-manager configuration:

```nix
# In flake.nix, all hosts use the same user
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
```

Both will use `home/butcherrrr.nix` for home-manager configuration.

### Different Users Per Host

For different users on different machines:

```nix
# In flake.nix
personal-laptop = mkSystem {
  hostname = "personal-laptop";
  system = "x86_64-linux";
  user = "butcherrrr";
};

work-laptop = mkSystem {
  hostname = "work-laptop";
  system = "x86_64-linux";
  user = "john.doe";  # Different user
};
```

Then create `home/john.doe.nix` with work-specific configuration.

### Per-Host Customization in Home-Manager

You can use the `hostname` variable in your home-manager config:

```nix
# In home/butcherrrr.nix
{ config, pkgs, hostname, ... }:

{
  home.packages = with pkgs; [
    # Common packages
    firefox
    neovim
  ] ++ (if hostname == "work-laptop" then [
    # Work-specific packages
    slack
    teams
  ] else []);
}
```

## Synchronizing Changes

### Updating All Hosts

After making changes to shared modules:

```bash
# On each host
cd ~/nixos-config
git pull
nix flake update  # Optional: update dependencies
sudo nixos-rebuild switch --flake .#$(hostname)
```

### Testing Changes Before Applying

Use `nixos-rebuild test` to test without making changes permanent:

```bash
sudo nixos-rebuild test --flake .#$(hostname)
# If everything works:
sudo nixos-rebuild switch --flake .#$(hostname)
```

### Building for a Different Host

You can build a configuration for another host from your current machine:

```bash
# Build configuration for another host
nixos-rebuild build --flake .#other-hostname

# The result will be in ./result
```

## Common Patterns

### Shared Configuration with Host-Specific Overrides

Create a base configuration that all hosts import, then override as needed:

```nix
# modules/base.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    vim
    htop
  ];
}

# hosts/laptop/default.nix
{
  imports = [ ../../modules/base.nix ];
  
  # Override or extend
  environment.systemPackages = with pkgs; [
    # Laptop-specific packages
    powertop
  ];
}
```

### Conditional Imports Based on Hardware

```nix
# In your host's default.nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix
] ++ (if builtins.pathExists ./nvidia.nix then [ ./nvidia.nix ] else []);
```

### Different System Architectures

For ARM-based systems (Raspberry Pi, Apple Silicon):

```nix
rpi4 = mkSystem {
  hostname = "rpi4";
  system = "aarch64-linux";  # ARM 64-bit
  user = "pi";
};
```

## Troubleshooting

### Host-Specific Hardware Issues

If hardware isn't detected properly:

```bash
# Regenerate hardware config
sudo nixos-generate-config --show-hardware-config
# Compare with your current hardware-configuration.nix
```

### Module Conflicts

If modules conflict (e.g., two display managers):

- Only import one display manager per host
- Use `imports` carefully in each host's `default.nix`
- Comment out modules you don't need

### Different Kernel Versions

Some hosts might need different kernels:

```nix
# In host's default.nix
boot.kernelPackages = pkgs.linuxPackages_latest;  # Latest kernel
# Or for LTS:
# boot.kernelPackages = pkgs.linuxPackages;
```

## Best Practices

1. **Keep hardware configs separate** - Never commit sensitive UUIDs to public repos without checking
2. **Test on one host first** - Test major changes on your primary machine before deploying
3. **Use git branches** - Create branches for experimental changes
4. **Document host-specific quirks** - Add comments in host configs explaining why certain options are set
5. **Regular updates** - Keep flake inputs updated: `nix flake update`
6. **Backup before major changes** - NixOS makes rollbacks easy, but backups are still good practice

## Example Configurations

### Minimal Server

```nix
# hosts/server/default.nix
{ hostname, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
  ];
  
  system.stateVersion = "25.11";
  networking.hostName = hostname;
  
  services.openssh.enable = true;
  networking.firewall.enable = true;
}
```

### Full Desktop

```nix
# hosts/desktop/default.nix
{ hostname, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/greetd.nix
    ../../modules/hyprland.nix
  ];
  
  system.stateVersion = "25.11";
  networking.hostName = hostname;
  
  # Desktop-specific features
  programs.steam.enable = true;
  services.printing.enable = true;
}
```

## Quick Reference

```bash
# Add new host
cp -r hosts/example-host hosts/NEW-HOST
sudo nixos-generate-config --show-hardware-config > hosts/NEW-HOST/hardware-configuration.nix
# Edit flake.nix and add host
sudo nixos-rebuild switch --flake .#NEW-HOST

# Update dependencies
nix flake update

# Rebuild current host
sudo nixos-rebuild switch --flake .#$(hostname)

# Test without switching
sudo nixos-rebuild test --flake .#$(hostname)

# Build for different host
nixos-rebuild build --flake .#other-host

# List all available configurations
nix flake show
```
