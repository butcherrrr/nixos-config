{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.enable = false;

  imports = [
   ./hardware-configuration.nix
   ../../modules/core.nix
   ../../modules/greetd.nix
   ../../modules/hyprland.nix
  ];
}
