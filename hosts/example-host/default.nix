# Host-specific configuration template
# Copy this directory to create a new host configuration
#
# Steps to add a new host:
# 1. Copy this directory: cp -r hosts/example-host hosts/YOUR-HOSTNAME
# 2. Update the hardware-configuration.nix with your actual hardware config
# 3. Customize the imports below (add/remove modules as needed)
# 4. Update timezone, locale, and other settings for this specific machine
# 5. Add your host to flake.nix in nixosConfigurations
{ hostname, user, ... }:

{
  # ============================================================================
  # Boot Configuration
  # ============================================================================
  
  # Use systemd-boot as the bootloader (modern, simple UEFI bootloader)
  boot.loader.systemd-boot.enable = true;
  
  # Allow systemd-boot to modify EFI variables (needed for boot entry management)
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Location where the EFI partition is mounted
  boot.loader.efi.efiSysMountPoint = "/boot";
  
  # Disable GRUB (we're using systemd-boot instead)
  boot.loader.grub.enable = false;

  # ============================================================================
  # System Configuration
  # ============================================================================
  
  # State version - should match your NixOS release when first installed
  # DO NOT CHANGE this on an existing system - it's used for compatibility
  # Only set this when first installing NixOS
  system.stateVersion = "25.11";
  
  # Hostname - using the variable passed from flake.nix
  # This makes it easy to reuse this configuration structure for other hosts
  networking.hostName = hostname;
  
  # System timezone - affects system clock and date display
  # Find your timezone: ls /usr/share/zoneinfo/
  time.timeZone = "Europe/Stockholm";
  
  # Default system locale - affects language, date format, currency, etc.
  # This sets the primary locale for all system messages
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Console keyboard layout - for TTY (text-only terminal, not Wayland/X)
  # This is Swedish keyboard layout for virtual consoles
  # Different from Wayland input settings (configured in Hyprland)
  console.keyMap = "sv-latin1";

  # ============================================================================
  # Module Imports
  # ============================================================================
  
  imports = [
    # Hardware configuration - auto-generated, unique per machine
    # Generate with: sudo nixos-generate-config --show-hardware-config
    ./hardware-configuration.nix
    
    # -------------------------------------------------------------------------
    # Core Modules (usually needed on all systems)
    # -------------------------------------------------------------------------
    
    # Core system configuration (users, networking, audio, packages)
    # Every system should import this
    ../../modules/core.nix
    
    # -------------------------------------------------------------------------
    # Optional Modules (comment out what you don't need)
    # -------------------------------------------------------------------------
    
    # Greetd display manager configuration (login screen)
    # Only import this if you want a graphical login
    # For servers or auto-login systems, you might skip this
    ../../modules/greetd.nix
    
    # Hyprland window manager system-level configuration
    # Only import this if this machine will use Hyprland
    # For servers or different desktop environments, skip this or replace
    ../../modules/hyprland.nix
    
    # -------------------------------------------------------------------------
    # Add your own host-specific modules here
    # -------------------------------------------------------------------------
    
    # Examples:
    # ./gaming.nix           # Gaming-specific configuration
    # ./work.nix             # Work-related tools and settings
    # ./server.nix           # Server-specific services
    # ../../modules/nvidia.nix   # NVIDIA GPU configuration
  ];
  
  # ============================================================================
  # Host-Specific Settings
  # ============================================================================
  
  # Add any configuration unique to this host here
  # Examples:
  
  # Enable SSH for remote access (useful for servers)
  # services.openssh.enable = true;
  
  # Enable CUPS for printing
  # services.printing.enable = true;
  
  # Enable Docker
  # virtualisation.docker.enable = true;
  
  # Enable virtualization (QEMU/KVM)
  # virtualisation.libvirtd.enable = true;
  
  # Mount additional filesystems
  # fileSystems."/mnt/data" = {
  #   device = "/dev/disk/by-uuid/YOUR-UUID";
  #   fsType = "ext4";
  # };
}