{ ... }:

{
  # Hyprlock Configuration (Lock Screen)
  # Parallel authentication: fingerprint OR password (configured in modules/fingerprint.nix)
  programs.hyprlock = {
    enable = true;

    settings = {
      # General settings
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0; # Seconds before requiring password
        no_fade_in = true; # Disable fade-in to prevent black screen flash
        no_fade_out = true; # Disable fade-out for instant appearance
      };

      # Background (applies to all monitors)
      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 4;
          blur_size = 10;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # Input field (password)
      input-field = [
        {
          monitor = "";
          size = "25%, 5%";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.15;
          dots_center = true;
          dots_rounding = -1;
          outer_color = "rgb(89b4fa)"; # Catppuccin blue
          inner_color = "rgb(1e1e2e)"; # Catppuccin base
          font_color = "rgb(cdd6f4)"; # Catppuccin text
          font_size = 28;
          fade_on_empty = false;
          placeholder_text = "<span foreground='##cdd6f4'>Password or Fingerprint...</span>";
          hide_input = false;
          rounding = 2;
          check_color = "rgb(f9e2af)"; # Catppuccin yellow
          fail_color = "rgb(f38ba8)"; # Catppuccin red
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 300;
          capslock_color = "rgb(f9e2af)";
          numlock_color = -1;
          bothlock_color = -1;
          invert_numlock = false;
          swap_font_color = false;
          position = "0, -8%";
          halign = "center";
          valign = "center";
        }
      ];

      # Time and Date labels
      label = [
        # Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%H:%M')\"";
          color = "rgb(cdd6f4)"; # Catppuccin text
          font_size = 150;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 12%";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%A, %B %d')\"";
          color = "rgb(cdd6f4)"; # Catppuccin text
          font_size = 28;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 2%";
          halign = "center";
          valign = "center";
        }
      ];

      # Authentication - enable parallel fingerprint authentication
      auth = {
        "fingerprint:enabled" = true;
      };
    };
  };
}
