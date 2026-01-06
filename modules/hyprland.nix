{ pkgs, ... }:

{
  # Enable Hyprland at the system level
  # User-specific settings are in Home Manager
  programs.hyprland.enable = true;

  # XDG Desktop Portals provide a standardized way for apps to interact with the desktop
  xdg.portal = {
    # Enable the XDG desktop portal service
    enable = true;

    # Portal backends to use
    extraPortals = [
      # Hyprland-specific portal
      pkgs.xdg-desktop-portal-hyprland

      # GTK portal
      pkgs.xdg-desktop-portal-gtk
    ];

    config.common.default = "*";
  };

  # System-wide packages needed for Wayland/Hyprland functionality
  environment.systemPackages = with pkgs; [
    # Clipboard manager for Wayland
    wl-clipboard

    # Screenshot tool - captures screen/window/region
    grim

    # Screen region selector
    slurp
  ];
}
