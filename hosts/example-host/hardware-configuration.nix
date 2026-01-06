# Hardware Configuration Template
#
# This file should be replaced with actual hardware configuration
# Generate hardware configuration with:
#   sudo nixos-generate-config --show-hardware-config > hosts/HOSTNAME/hardware-configuration.nix
#
# This is just a placeholder to show the structure

{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # ============================================================================
  # Kernel Modules
  # ============================================================================

  # Available kernel modules for initrd (loaded during boot)
  # Common modules:
  #   - "xhci_pci" "ehci_pci" "ahci" - USB and SATA controllers
  #   - "nvme" "sd_mod" - NVMe and SCSI disk support
  #   - "usb_storage" - USB storage devices
  #   - "thunderbolt" - Thunderbolt support
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  # Kernel modules to load in initrd
  boot.initrd.kernelModules = [ ];

  # Regular kernel modules to load
  # Common options:
  #   - "kvm-intel" or "kvm-amd" - Virtualization support
  boot.kernelModules = [ "kvm-intel" ];

  # Extra kernel module packages
  boot.extraModulePackages = [ ];

  # ============================================================================
  # Filesystems
  # ============================================================================

  # Root filesystem
  # Replace with actual UUID from: lsblk -f
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";
    fsType = "ext4"; # or "btrfs", "xfs", "zfs", etc.
  };

  # Boot partition (EFI System Partition)
  # Replace with actual boot partition UUID
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/XXXX-XXXX";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ]; # Security: only root can read
  };

  # ============================================================================
  # Swap Configuration
  # ============================================================================

  # Swap devices (if swap partition or swap file exists)
  # swapDevices = [
  #   { device = "/dev/disk/by-uuid/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"; }
  # ];
  swapDevices = [ ];

  # ============================================================================
  # Hardware Platform
  # ============================================================================

  # CPU architecture
  # Use "x86_64-linux" for Intel/AMD 64-bit
  # Use "aarch64-linux" for ARM 64-bit (e.g., Raspberry Pi 4, Apple Silicon)
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # CPU microcode updates (security and stability fixes)
  # For Intel CPUs:
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # For AMD CPUs, use this instead:
  # hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
