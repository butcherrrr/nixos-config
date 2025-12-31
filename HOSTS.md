# Advanced Multi-Host Management

This guide covers advanced topics for managing multiple NixOS machines. For basic setup, see `README.md`.

## Host Type Examples

### Server Configuration

Skip GUI modules, enable SSH:

```nix
# hosts/server/default.nix
imports = [
  ./hardware-configuration.nix
  ../../modules/core.nix
  # Skip greetd.nix and hyprland.nix
];

services.openssh = {
  enable = true;
  settings.PasswordAuthentication = false;
  settings.PermitRootLogin = "no";
};

networking.firewall.enable = true;
networking.firewall.allowedTCPPorts = [ 22 80 443 ];
```

### Laptop Configuration

Add power management:

```nix
# In your host's default.nix
services.tlp.enable = true;
services.blueman.enable = true;
```

### Gaming Machine

```nix
programs.steam.enable = true;
hardware.opengl.driSupport32Bit = true;
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

```nix
personal = mkSystem { user = "butcherrrr"; ... };
work = mkSystem { user = "john.doe"; ... };  # Create home/john.doe.nix
```

### Conditional Packages Based on Hostname

Use the `hostname` variable in home-manager:

```nix
# home/butcherrrr.nix
{ pkgs, hostname, ... }:
{
  home.packages = with pkgs; [
    firefox
    neovim
  ] ++ (if hostname == "work-laptop" then [ slack teams ] else []);
}
```

## Advanced Operations

### Testing Changes

```bash
sudo nixos-rebuild test --flake .#$(hostname)  # Test without committing
sudo nixos-rebuild switch --flake .#$(hostname)  # Apply permanently
```

### Build for Another Host

```bash
nixos-rebuild build --flake .#other-hostname  # Result in ./result
```

### Remote Deployment

```bash
nixos-rebuild switch --flake .#hostname --target-host user@remote-host
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

### ARM Systems

```nix
rpi4 = mkSystem {
  hostname = "rpi4";
  system = "aarch64-linux";
  user = "pi";
};
```

### Different Kernels Per Host

```nix
# In host's default.nix
boot.kernelPackages = pkgs.linuxPackages_latest;  # Latest
# boot.kernelPackages = pkgs.linuxPackages;       # LTS
```

## Troubleshooting

### Hardware Not Detected

```bash
sudo nixos-generate-config --show-hardware-config
# Compare with your hosts/*/hardware-configuration.nix
```

### Module Conflicts

Only import one display manager per host. Check your `imports` in `hosts/*/default.nix`.

## Best Practices

- Test major changes on one host before deploying to all
- Use git branches for experimental changes
- Document host-specific quirks in comments
- Keep flake inputs updated regularly
- Never share hardware-configuration.nix between machines
