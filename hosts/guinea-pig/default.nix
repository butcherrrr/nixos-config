# Host-specific configuration for: nixos
# This file defines settings unique to this particular machine
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
  # DO NOT CHANGE this on an existing system
  system.stateVersion = "25.11";

  # Hostname - using the variable passed from flake.nix
  # This makes it easy to reuse this configuration structure for other hosts
  networking.hostName = hostname;

  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_US.UTF-8";

  # Console keymap is configured in modules/core.nix

  # ============================================================================
  # Module Imports
  # ============================================================================

  imports = [
    # Hardware configuration - auto-generated, unique per machine
    ./hardware-configuration.nix

    # Core system configuration (users, networking, audio, packages)
    # Every system should import this
    ../../modules/core.nix

    # Greetd display manager configuration (login screen)
    # Only import this if you want a graphical login
    # For servers, you might skip this
    ../../modules/greetd.nix

    # Hyprland window manager system-level configuration
    # Only import this if this machine will use Hyprland
    # For servers or different desktop environments, skip this
    ../../modules/hyprland.nix
  ];
}
