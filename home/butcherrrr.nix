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
    swaybg        # Wallpaper manager

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
    
    # Waybar configuration
    ".config/waybar/config" = {
      source = ../dotfiles/waybar-config.json;
    };
    
    # Waybar stylesheet
    ".config/waybar/style.css" = {
      source = ../dotfiles/waybar-style.css;
    };
    
    # Wallpaper
    ".config/hypr/wallpaper.jpg" = {
      source = ../backgrounds/minimalist-black-hole.png;
    };
  };
}
