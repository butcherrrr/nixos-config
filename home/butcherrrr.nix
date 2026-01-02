{ config, pkgs, ... }:

{
  # ============================================================================
  # Home Manager Configuration
  # ============================================================================

  # State version
  # DO NOT CHANGE this on an existing installation
  home.stateVersion = "25.11";

  # ============================================================================
  # Catppuccin Theme Configuration
  # ============================================================================

  catppuccin = {
    enable = true;
    flavor = "mocha";  # Options: latte, frappe, macchiato, mocha
    accent = "blue";   # Options: rosewater, flamingo, pink, mauve, red, maroon,
                       #          peach, yellow, green, teal, sky, sapphire, blue, lavender
  };

  # ============================================================================
  # User Packages
  # ============================================================================

  # Packages installed for this user (not system-wide)
  home.packages = with pkgs; [
    # Terminals
    kitty
    ghostty

    # Icons
    papirus-icon-theme

    # Wayland utilities
    rofi          # Application launcher
    waybar        # Status bar
    mako          # Notification daemon
    swaybg        # Wallpaper manager

    # Applications
    neovim
    firefox
    zed-editor
    # zen-browser (uncomment when stable or https://medium.com/@notquitethereyet_/installing-zen-browser-on-nixos-%EF%B8%8F-7ae541f5533f)

    # Shell
    zsh-powerlevel10k
    zoxide
  ];

  # ============================================================================
  # Dotfiles (Managed by Home Manager)
  # ============================================================================

  # Symlink configuration files from this repo to their expected locations
  home.file = {
    # Hyprland configuration
    ".config/hypr/hyprland.conf" = {
      source = ../dotfiles/hyprland/hyprland.conf;
    };

    # Waybar configuration
    ".config/waybar/config" = {
      source = ../dotfiles/waybar/config.json;
    };

    # Waybar stylesheet
    ".config/waybar/style.css" = {
      source = ../dotfiles/waybar/style.css;
    };

    # Wallpaper
    ".config/hypr/wallpaper.jpg" = {
      source = ../backgrounds/minimalist-black-hole.png;
    };

    # Ghostty configuration
    ".config/ghostty/config" = {
      source = ../dotfiles/ghostty/config;
    };

    # Rofi configuration
    ".config/rofi/config.rasi" = {
      source = ../dotfiles/rofi/config.rasi;
    };
  };

  # ============================================================================
  # Shell Configuration
  # ============================================================================

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      update = "sudo nixos-rebuild switch --flake .#$(hostname)";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "zoxide" ];
      theme = "";  # Empty - using powerlevel10k instead
    };

    initContent = ''
      # Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Initialize zoxide (smart cd replacement)
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };
}
