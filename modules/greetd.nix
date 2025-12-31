{ pkgs, user, ... }:

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

        # Which user this session is for - using variable from flake.nix
        # Greetd will automatically log in this user and start Hyprland
        user = user;
      };
    };
  };
}
