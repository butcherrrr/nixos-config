{ pkgs, ... }:

{
  # ============================================================================
  # Greetd Display Manager Configuration (Login Screen)
  # ============================================================================

  services.greetd = {
    enable = true;

    settings = {
      # Default session configuration - what happens when you log in
      default_session = {
        # Command to run after successful login
        command = "${pkgs.hyprland}/bin/Hyprland";

        # Greetd will automatically log in this user and start Hyprland
        user = "butcherrrr";
      };
    };
  };
}
