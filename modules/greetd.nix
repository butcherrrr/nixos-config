{ pkgs, ... }:

{
  # ============================================================================
  # Greetd + tuigreet Display Manager Configuration (Login Screen)
  # ============================================================================

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };

  # Enable GNOME Keyring for credential storage
  # Will be unlocked automatically when you log in with your password
  services.gnome.gnome-keyring.enable = true;

  # Install required packages for theming
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    gnome-themes-extra
    adwaita-icon-theme
    (catppuccin-gtk.override {
      accents = [ "blue" ];
      variant = "mocha";
    })
    banana-cursor
  ];

  # Install wallpaper to system location
  environment.etc."backgrounds/nixos-config/minimalist-black-hole.png".source = ../backgrounds/minimalist-black-hole.png;

  # ============================================================================
  # Console Colors - Catppuccin Mocha
  # ============================================================================

  console.colors = [
    # Normal colors (0-7)
    "1e1e2e"  # 0: Black (Base)
    "f38ba8"  # 1: Red
    "a6e3a1"  # 2: Green
    "f9e2af"  # 3: Yellow
    "89b4fa"  # 4: Blue
    "cba6f7"  # 5: Magenta
    "94e2d5"  # 6: Cyan
    "cdd6f4"  # 7: White (Text)

    # Bright colors (8-15)
    "45475a"  # 8: Bright Black (Surface0)
    "f38ba8"  # 9: Bright Red
    "a6e3a1"  # 10: Bright Green
    "f9e2af"  # 11: Bright Yellow
    "89b4fa"  # 12: Bright Blue
    "cba6f7"  # 13: Bright Magenta
    "94e2d5"  # 14: Bright Cyan
    "cdd6f4"  # 15: Bright White
  ];
}
