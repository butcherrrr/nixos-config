{ ... }:

{
  # Home Manager Configuration

  # State version
  # DO NOT CHANGE this on an existing installation
  home.stateVersion = "25.11";

  # Catppuccin Theme Configuration
  catppuccin = {
    enable = true;
    flavor = "mocha"; # Options: latte, frappe, macchiato, mocha
    accent = "blue";
    # Options: rosewater, flamingo, pink, mauve, red, maroon,
    #          peach, yellow, green, teal, sky, sapphire, blue, lavender

    # Per-app theming (new naming scheme)
    rofi.enable = true;
    waybar.enable = false; # Using custom manual styling in waybar.nix
    mako.enable = true;
    hyprland.enable = true;
    hyprlock.enable = false; # Using custom configuration in hyprlock.nix
    fzf.enable = true;
    tmux.enable = true;
    yazi.enable = true;
    zed.enable = false; # Using custom configuration in zed.nix
  };

  # Module Imports
  imports = [
    ./butcherrrr/packages.nix # User packages
    ./butcherrrr/shell.nix # Zsh and zoxide
    ./butcherrrr/git.nix # Git configuration
    ./butcherrrr/neovim.nix # Neovim with Nixvim
    ./butcherrrr/tmux.nix # Tmux terminal multiplexer
    ./butcherrrr/hyprland.nix # Hyprland window manager
    ./butcherrrr/hyprlock.nix # Lock screen
    ./butcherrrr/waybar.nix # Status bar
    ./butcherrrr/rofi.nix # Application launcher
    ./butcherrrr/ghostty.nix # Terminal emulator
    ./butcherrrr/yazi.nix # Terminal file manager
    ./butcherrrr/zed.nix # Zed editor
    ./butcherrrr/chromium.nix # Chromium browser
    ./butcherrrr/keyring.nix # GNOME Keyring for secret storage
    ./butcherrrr/services.nix # Mako notifications
    ./butcherrrr/theme.nix # GTK and cursor theming
    ./butcherrrr/spicetify.nix # Spotify theming
  ];
}
