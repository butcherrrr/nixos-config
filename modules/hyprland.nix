{ pkgs, ... }:

{
  # ============================================================================
  # Hyprland Window Manager Configuration (System-Level)
  # ============================================================================

  # Enable Hyprland at the system level
  # This installs Hyprland and sets up necessary system integrations
  # User-specific settings are in Home Manager
  programs.hyprland.enable = true;

  # ============================================================================
  # XDG Desktop Portal Configuration
  # ============================================================================

  # XDG Desktop Portals provide a standardized way for apps to interact with the desktop
  # They handle things like: file pickers, screenshots, screen sharing, etc.
  xdg.portal = {
    # Enable the XDG desktop portal service
    enable = true;

    # Portal backends to use
    # Each portal provides different functionality for different types of apps
    extraPortals = [
      # Hyprland-specific portal - optimized for Hyprland features
      # Handles screen capture, window selection, etc. in Hyprland
      pkgs.xdg-desktop-portal-hyprland

      # GTK portal - provides file pickers and other GTK app integrations
      # Needed for proper file dialogs in GTK applications (many Linux apps)
      pkgs.xdg-desktop-portal-gtk
    ];

    # Configure which portal to use by default
    config.common.default = "*";
  };

  # ============================================================================
  # Wayland Utilities
  # ============================================================================

  # System-wide packages needed for Wayland/Hyprland functionality
  environment.systemPackages = with pkgs; [
    # Clipboard manager for Wayland
    # Allows copy/paste between applications in Wayland
    wl-clipboard

    # Screenshot tool - captures screen/window/region
    # Works with Wayland compositors
    grim

    # Screen region selector - allows selecting an area of the screen
    # Used with grim for selective screenshots
    slurp
  ];
}
