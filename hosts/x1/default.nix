{ hostname, ... }:

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
    ../../modules/core.nix
    ../../modules/greetd.nix
    ../../modules/hyprland.nix
  ];
}
