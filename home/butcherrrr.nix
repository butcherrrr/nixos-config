{ config, pkgs, ... }:

{
  # ============================================================================
  # Home Manager Configuration
  # ============================================================================

  # DO NOT CHANGE this on an existing installation
  # It's used to maintain compatibility with existing setup
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
  # Hyprland Window Manager Configuration (User-Level)
  # ============================================================================

  wayland.windowManager.hyprland = {
    # Enable Hyprland for this user
    enable = true;

    # Hyprland settings - all configuration goes here
    settings = {

      # ========================================================================
      # Input Configuration
      # ========================================================================

      input = {
        # Keyboard layout - Swedish keyboard
        # This is for Wayland/Hyprland, separate from console keymap
        kb_layout = "se";

        # Mouse focus follows cursor (1 = yes, 0 = no)
        follow_mouse = 1;

        # Touchpad settings
        touchpad = {
          # Natural scrolling (false = traditional scrolling direction)
          # true = scroll down moves content down (like on phones)
          # false = scroll down moves content up (traditional)
          natural_scroll = true;
        };
      };

      # ========================================================================
      # General Window Manager Settings
      # ========================================================================

      general = {
        # Space between windows in pixels
        gaps_in = 5;

        # Space between windows and screen edges in pixels
        gaps_out = 10;

        # Width of window borders in pixels
        border_size = 2;

        # Active window border color (gradient from cyan to mint green)
        # Format: rgba(RRGGBBAA) where AA is alpha (transparency)
        # "45deg" creates a 45-degree gradient between the two colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";

        # Inactive window border color (gray with transparency)
        "col.inactive_border" = "rgba(595959aa)";

        # Window layout algorithm
        # "dwindle" = Fibonacci-like spiral layout (new windows split existing ones)
        # Alternative: "master" = master-stack layout
        layout = "dwindle";
      };

      # ========================================================================
      # Decoration Settings (Visual Effects)
      # ========================================================================

      decoration = {
        # Corner rounding radius in pixels
        # Higher = more rounded window corners
        rounding = 5;

        # Blur settings for transparent windows
        blur = {
          # Enable blur effect
          enabled = true;

          # Blur intensity (higher = more blur)
          size = 3;

          # Number of blur passes (higher = smoother but slower)
          passes = 1;
        };

        # Enable drop shadows behind windows
        drop_shadow = true;

        # Shadow spread distance in pixels
        shadow_range = 4;

        # Shadow intensity (1-4, higher = more intense)
        shadow_render_power = 3;
      };

      # ========================================================================
      # Animation Settings
      # ========================================================================

      animations = {
        # Enable animations (set to false for better performance on weak systems)
        enabled = true;

        # Define custom bezier curves for animations
        # Format: name, x1, y1, x2, y2
        # This creates a smooth acceleration curve
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        # Animation configurations
        # Format: "type, enabled, speed, curve, style"
        animation = [
          # Window open/move animations - uses custom bezier curve
          "windows, 1, 7, myBezier"

          # Window close animations - slight zoom out effect
          "windowsOut, 1, 7, default, popin 80%"

          # Border color transitions between active/inactive
          "border, 1, 10, default"

          # Fade in/out animations
          "fade, 1, 7, default"

          # Workspace switch animations
          "workspaces, 1, 6, default"
        ];
      };

      # ========================================================================
      # Keybindings
      # ========================================================================

      # Regular keybindings - press and release
      # Format: "MODIFIERS, key, action, parameters"
      bind = [
        # -------------------- Application Shortcuts --------------------

        # SUPER+Return = Open terminal (Kitty)
        "SUPER, Return, exec, kitty"

        # SUPER+Space = Open application launcher
        "SUPER, Space, exec, wofi --show drun"

        # -------------------- Window Management --------------------

        # SUPER+W = Close active window (kill)
        "SUPER, W, killactive"

        # SUPER+M = Exit Hyprland (logout)
        "SUPER, M, exit"

        # SUPER+V = Toggle floating mode for current window
        "SUPER, V, togglefloating"

        # SUPER+P = Pseudo-tile (window acts like tiled but is floating)
        "SUPER, P, pseudo"

        # SUPER+J = Toggle split direction (horizontal/vertical)
        "SUPER, J, togglesplit"

        # SUPER+F = Toggle fullscreen for current window
        "SUPER, F, fullscreen"

        # -------------------- Focus Movement (Arrow Keys) --------------------

        # Move focus between windows using arrow keys
        "SUPER, left, movefocus, l"    # Move focus left
        "SUPER, right, movefocus, r"   # Move focus right
        "SUPER, up, movefocus, u"      # Move focus up
        "SUPER, down, movefocus, d"    # Move focus down

        # -------------------- Focus Movement (Vim Keys) --------------------

        # Same as arrow keys but using Vim-style hjkl keys
        "SUPER, h, movefocus, l"       # Move focus left (h)
        "SUPER, l, movefocus, r"       # Move focus right (l)
        "SUPER, k, movefocus, u"       # Move focus up (k)
        "SUPER, j, movefocus, d"       # Move focus down (j)

        # -------------------- Workspace Switching --------------------

        # SUPER+[1-9,0] = Switch to workspace 1-10
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        # -------------------- Move Windows to Workspaces --------------------

        # SUPER+SHIFT+[1-9,0] = Move active window to workspace 1-10
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        # -------------------- Workspace Scrolling --------------------

        # Scroll through workspaces with mouse wheel while holding SUPER
        "SUPER, mouse_down, workspace, e+1"    # Next workspace
        "SUPER, mouse_up, workspace, e-1"      # Previous workspace

        # -------------------- Screenshots --------------------

        # Print = Take screenshot of selected area and copy to clipboard
        # grim captures the screen, slurp lets you select area, wl-copy copies to clipboard
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
      ];

      # ========================================================================
      # Mouse Bindings
      # ========================================================================

      # Mouse button bindings - hold key + drag mouse
      # Format: "MODIFIERS, mouse:button, action"
      bindm = [
        # SUPER + Left Click (button 272) = Move window by dragging
        "SUPER, mouse:272, movewindow"

        # SUPER + Right Click (button 273) = Resize window by dragging
        "SUPER, mouse:273, resizewindow"
      ];

      # ========================================================================
      # Autostart Programs
      # ========================================================================

      exec-once = [
        "waybar"
        "mako"
      ];
    };
  };
}
