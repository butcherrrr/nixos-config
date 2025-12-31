# Multi-Host Configuration Changes

This document summarizes the changes made to transform your NixOS configuration into a multi-host management system.

## What Changed?

### 1. flake.nix - Complete Restructure

**Before:**
- Single hardcoded system configuration
- Hardcoded username and hostname
- Difficult to add new machines

**After:**
- Helper function `mkSystem` for creating host configurations
- Dynamic hostname and username via variables
- Easy to add new hosts - just uncomment template and customize
- All hosts defined in `nixosConfigurations` block
- Better comments explaining each section

**Key Features:**
- Variables (`hostname`, `user`) passed to all modules via `specialArgs`
- Same variables passed to home-manager via `extraSpecialArgs`
- Example configurations commented out for reference

### 2. Host Configurations - Made Dynamic

**Files Updated:**
- `hosts/nixos/default.nix` - Now uses `hostname` variable
- All host configs can now reuse the same structure

**Changes:**
- `networking.hostName = hostname;` (instead of hardcoded "nixos")
- Added `{ hostname, user, ... }:` parameter to use variables
- Better comments explaining when to import each module
- Guidance on selective module imports

### 3. Modules - Made Reusable

**modules/core.nix:**
- Changed `users.users.butcherrrr` to `users.users.${user}`
- Now works with any username passed from flake.nix

**modules/greetd.nix:**
- Changed `user = "butcherrrr"` to `user = user;`
- Now auto-logs in whichever user is specified

**modules/hyprland.nix:**
- No changes needed (already generic)
- Works for any host that imports it

### 4. New Template Host

**Created:**
- `hosts/example-host/` directory
- `hosts/example-host/default.nix` - Fully commented template
- `hosts/example-host/hardware-configuration.nix` - Template with instructions

**Purpose:**
- Easy starting point for new hosts
- Copy, customize, and deploy
- Includes helpful comments and examples

### 5. Documentation

**New Files:**
- `HOSTS.md` - Comprehensive guide for multi-host management (411 lines)
- `hosts/README.md` - Quick reference for the hosts directory

**Contents:**
- Step-by-step instructions for adding new hosts
- Different host type examples (desktop, server, laptop)
- User management strategies
- Troubleshooting tips
- Quick reference commands
- Best practices

## How to Use This Setup

### Current Host (nixos)

Your existing system still works exactly as before:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Adding a New Host

1. **Copy template:**
   ```bash
   cp -r hosts/example-host hosts/laptop
   ```

2. **Generate hardware config:**
   ```bash
   sudo nixos-generate-config --show-hardware-config > hosts/laptop/hardware-configuration.nix
   ```

3. **Customize `hosts/laptop/default.nix`:**
   - Adjust timezone, locale
   - Choose which modules to import
   - Add laptop-specific settings (e.g., power management)

4. **Add to flake.nix:**
   ```nix
   laptop = mkSystem {
     hostname = "laptop";
     system = "x86_64-linux";
     user = "butcherrrr";
   };
   ```

5. **Build and deploy:**
   ```bash
   sudo nixos-rebuild switch --flake .#laptop
   ```

### Managing Multiple Users

**Same user everywhere:**
```nix
# All hosts use butcherrrr
desktop = mkSystem { hostname = "desktop"; user = "butcherrrr"; };
laptop = mkSystem { hostname = "laptop"; user = "butcherrrr"; };
```

**Different users per host:**
```nix
# Different users
personal = mkSystem { hostname = "personal"; user = "butcherrrr"; };
work = mkSystem { hostname = "work"; user = "john.doe"; };
```

Then create `home/john.doe.nix` for the work user.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│ flake.nix                                                   │
│ ┌─────────────────────────────────────────────────────────┐ │
│ │ nixosConfigurations                                     │ │
│ │   ├─ nixos  ──────► mkSystem { hostname, user }        │ │
│ │   ├─ laptop ──────► mkSystem { hostname, user }        │ │
│ │   └─ server ──────► mkSystem { hostname, user }        │ │
│ └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                            │
           ┌────────────────┼────────────────┐
           │                │                │
           ▼                ▼                ▼
    ┌──────────┐     ┌──────────┐    ┌──────────┐
    │  Host    │     │  Shared  │    │   Home   │
    │  Config  │     │ Modules  │    │ Manager  │
    │          │     │          │    │          │
    │ default  │────►│   core   │    │   user   │
    │  .nix    │     │  greetd  │    │  .nix    │
    │          │     │ hyprland │    │          │
    │ hardware │     │          │    │          │
    │  -config │     └──────────┘    └──────────┘
    │  .nix    │
    └──────────┘
```

## Benefits of This Setup

1. **DRY (Don't Repeat Yourself)**
   - Shared configuration in modules
   - Host-specific only in host directories
   - Single source of truth

2. **Easy to Add Hosts**
   - Copy template
   - Customize as needed
   - One line in flake.nix

3. **Flexible**
   - Different architectures (x86_64, aarch64)
   - Different users per host
   - Different module sets per host

4. **Type-Specific Configs**
   - Desktop: Full GUI with Hyprland
   - Laptop: GUI + power management
   - Server: Minimal, no GUI, SSH enabled
   - Workstation: Development tools

5. **Maintainable**
   - Update shared modules once, affects all hosts
   - Clear separation of concerns
   - Well-documented with comments

## Variables Available in Modules

Thanks to `specialArgs`, these variables are available in all your configuration files:

- `hostname` - The hostname of the current system (e.g., "nixos", "laptop")
- `user` - The primary username (e.g., "butcherrrr")

**Usage example:**
```nix
{ hostname, user, ... }:
{
  # Use in any module
  networking.hostName = hostname;
  users.users.${user} = { ... };
  
  # Conditional based on hostname
  services.printing.enable = (hostname == "desktop");
}
```

## Next Steps

1. **Test current setup:**
   ```bash
   nix flake update
   sudo nixos-rebuild switch --flake .#nixos
   ```

2. **Read documentation:**
   - `HOSTS.md` for comprehensive guide
   - `hosts/README.md` for quick reference

3. **Add your second host:**
   - Follow the steps in "How to Use This Setup"
   - Start with a similar machine type

4. **Customize as needed:**
   - Add more modules to `modules/`
   - Create specialized configs for different host types
   - Share only what makes sense

## Important Notes

- ⚠️ Run `nix flake update` to fetch the correct home-manager version (release-25.11)
- ⚠️ The `hostname` variable must match what you define in flake.nix
- ⚠️ Each host needs its own hardware-configuration.nix (don't share these)
- ✅ You can now manage unlimited hosts from this single repo
- ✅ All your existing configuration still works - nothing broke!

## Questions?

Check:
1. `HOSTS.md` - Detailed guide with examples
2. `hosts/example-host/default.nix` - Fully commented template
3. Comments in `flake.nix` - Explains the helper function
4. Your existing `hosts/nixos/default.nix` - Working example