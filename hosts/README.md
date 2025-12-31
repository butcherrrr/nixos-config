# Hosts Directory Quick Reference

This directory contains host-specific configurations. Each subdirectory represents one physical or virtual machine.

## Directory Structure

- `nixos/` - Your primary machine (current configuration)
- `example-host/` - Template for creating new hosts

## Adding a New Host (Quick Steps)

```bash
# 1. Copy template
cp -r hosts/example-host hosts/NEW-HOSTNAME

# 2. Generate hardware config on target machine
sudo nixos-generate-config --show-hardware-config > hosts/NEW-HOSTNAME/hardware-configuration.nix

# 3. Edit hosts/NEW-HOSTNAME/default.nix
#    - Adjust timezone, locale, keyboard layout
#    - Choose which modules to import
#    - Add host-specific settings

# 4. Add to flake.nix under nixosConfigurations:
#    NEW-HOSTNAME = mkSystem {
#      hostname = "NEW-HOSTNAME";
#      system = "x86_64-linux";
#      user = "your-username";
#    };

# 5. Build and switch
sudo nixos-rebuild switch --flake .#NEW-HOSTNAME
```

## What Goes in Each Host's default.nix?

### Always Include
- Boot configuration (bootloader settings)
- System state version
- Hostname, timezone, locale
- Hardware configuration import
- Core modules import

### Conditionally Include (based on host type)
- Desktop/Laptop: `greetd.nix`, `hyprland.nix`
- Server: Skip GUI modules, add `openssh`
- Laptop: Add power management (`tlp`)
- Gaming: Add Steam, GPU drivers

## Common Module Imports

```nix
imports = [
  ./hardware-configuration.nix  # Always needed
  ../../modules/core.nix         # Always needed
  ../../modules/greetd.nix       # Only for GUI systems
  ../../modules/hyprland.nix     # Only if using Hyprland
];
```

## Host Configuration Checklist

When creating a new host configuration:

- [ ] Copy template directory
- [ ] Generate and add hardware-configuration.nix
- [ ] Set correct hostname (uses variable from flake.nix)
- [ ] Set correct timezone
- [ ] Set correct locale
- [ ] Set correct keyboard layout
- [ ] Choose appropriate module imports
- [ ] Add host-specific settings
- [ ] Add to flake.nix
- [ ] Test build before switching
- [ ] Document any quirks in comments

## Tips

- **Laptops**: Consider adding `services.tlp.enable = true;` for battery management
- **Servers**: Remove GUI modules, enable SSH, configure firewall
- **Gaming**: Add `programs.steam.enable = true;` and GPU drivers
- **Work**: Create separate user or add work-specific packages
- **Testing**: Use `sudo nixos-rebuild test --flake .#hostname` before `switch`

## See Also

- `../HOSTS.md` - Comprehensive multi-host management guide
- `../flake.nix` - Where all hosts are defined
- `../modules/` - Shared system modules