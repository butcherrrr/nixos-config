{ hostname, ... }:

{
  # Boot Configuration

  # Use systemd-boot as the bootloader (modern, simple UEFI bootloader)
  boot.loader.systemd-boot.enable = true;

  # Allow systemd-boot to modify EFI variables (needed for boot entry management)
  boot.loader.efi.canTouchEfiVariables = true;

  # Location where the EFI partition is mounted
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Disable GRUB (we're using systemd-boot instead)
  boot.loader.grub.enable = false;

  # System Configuration

  # State version - should match NixOS release when first installed
  # DO NOT CHANGE this on an existing system - used for compatibility
  system.stateVersion = "25.11";

  # Hostname - using the variable passed from flake.nix
  networking.hostName = hostname;

  # System timezone
  time.timeZone = "Europe/Stockholm";

  # This sets the primary locale for all system messages
  i18n.defaultLocale = "en_US.UTF-8";

  # Console keyboard layout - for TTY (text-only terminal, not Wayland/X)
  console.keyMap = "sv-latin1";

  # Module Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/console.nix
    ../../modules/greetd.nix
    ../../modules/hyprland.nix
  ];
}
