{ ... }:

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

  networking.hostName = "nixos";

  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_US.UTF-8";

  # Different from Wayland input settings (configured in Hyprland)
  console.keyMap = "sv-latin1";

  # ============================================================================
  # Module Imports
  # ============================================================================

  imports = [
    ./hardware-configuration.nix

    # Core system configuration (users, networking, audio, packages)
    ../../modules/core.nix

    # Greetd display manager configuration (login screen)
    ../../modules/greetd.nix

    # Hyprland window manager system-level configuration
    ../../modules/hyprland.nix
  ];
}
