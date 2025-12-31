# Hosts Directory

Each subdirectory represents one machine. Current hosts:

- `guinea-pig/` - Test machine (for testing this repo)
- `example-host/` - Template (copy this for new hosts)

## Quick Add New Host

```bash
# 1. Copy template
cp -r hosts/example-host hosts/NEW-NAME

# 2. Edit hosts/NEW-NAME/default.nix (timezone, locale, modules)

# 3. Add to flake.nix under nixosConfigurations

# 4. On target machine after NixOS install:
cp /etc/nixos/hardware-configuration.nix hosts/NEW-NAME/

# 5. Rebuild
sudo nixos-rebuild switch --flake .#NEW-NAME
```

## What Each Host Contains

- `default.nix` - Host configuration (timezone, modules, settings)
- `hardware-configuration.nix` - Auto-generated hardware config (unique per machine)

## Module Selection

Edit `default.nix` imports based on host type:

**Desktop/Laptop:**
- `core.nix` + `greetd.nix` + `hyprland.nix`

**Server:**
- `core.nix` only

## See Also

- `../README.md` - Main documentation and setup guide
- `../HOSTS.md` - Comprehensive multi-host management guide
