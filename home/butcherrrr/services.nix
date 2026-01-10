{ ... }:

{
  # Services Configuration

  # SwayOSD - OSD overlay for volume and brightness
  # Styled with Catppuccin Mocha colors
  services.swayosd = {
    enable = true;
    stylePath = ./swayosd.css;
  };

  # SwayNC (Sway Notification Center)
  # Notification daemon with history and control center
  # Styled with Catppuccin Mocha - green background, purple text
  services.swaync = {
    enable = true;

    settings = {
      # Positioning
      positionX = "right";
      positionY = "top";

      # Notification settings
      # Timeout controls how long notifications show on screen
      # They hide after timeout but stay in notification center
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;

      # Dismissal settings
      notification-inline-replies = false;
      notification-icon-size = 48;
      notification-body-image-height = 100;
      notification-body-image-width = 200;

      # Notification center behavior
      hide-on-clear = false; # Don't hide center when clearing notifications
      hide-on-action = true; # Hide notification popup when clicking action buttons

      # Control center
      control-center-margin-top = 0;
      control-center-margin-bottom = 5;
      control-center-margin-right = 5;
      control-center-margin-left = 5;
      control-center-width = 450;
      control-center-height = 600;

      # Notification window
      notification-window-width = 450;

      # Animation
      transition-time = 300;

      # Show images in notifications (album art, icons, etc)
      image-visibility = "when-available";

      keyboard-shortcuts = true;

      # Widget configuration
      widgets = [
        "title"
        "dnd"
        "notifications"
      ];
    };

    # Catppuccin Mocha styling
    style = builtins.readFile ./swaync.css;
  };

  # SwayOSD configuration file for top-center positioning and vertical orientation
  home.file.".config/swayosd/swayosd.conf".text = ''
    [osd]
    display = vertical
    anchor = top-center
    margin-top = 50
  '';
}
