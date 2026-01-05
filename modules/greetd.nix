{ pkgs, ... }:

{
  # ============================================================================
  # Greetd Display Manager Configuration (Login Screen)
  # ============================================================================

  # Auto-login and immediately lock with hyprlock
  # This gives you a hyprlock login experience
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "butcherrrr";
      };
    };
  };

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
