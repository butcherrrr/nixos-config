{ config, pkgs, ... }:

{
  # ============================================================================
  # Home Manager Configuration
  # ============================================================================

  # State version
  # DO NOT CHANGE this on an existing installation
  home.stateVersion = "25.11";

  # ============================================================================
  # User Packages
  # ============================================================================

  # Packages installed for this user (not system-wide)
  home.packages = with pkgs; [
    # Terminals
    kitty
    ghostty

    # Wayland utilities
    wofi          # Application launcher
    waybar        # Status bar
    mako          # Notification daemon

    # Applications
    neovim
    firefox
  ];

  # ============================================================================
  # Dotfiles (Managed by Home Manager)
  # ============================================================================

  # Symlink configuration files from this repo to their expected locations
  home.file = {
    # Hyprland configuration
    ".config/hypr/hyprland.conf" = {
      source = ../dotfiles/hyprland.conf;
    };
  };
}
