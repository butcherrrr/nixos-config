{ ... }:

{
  # Hyprland Configuration
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Monitor configuration
      # Format: monitor = "NAME,RESOLUTION,POSITION,SCALE"
      monitor = [
        "HDMI-A-1,3840x2160@60,0x0,1.5"
        "eDP-1,1920x1080@60,2560x0,1"
      ];

      workspace = [
        "1,default:true"
        "2"
        "3"
        "4"
        "5"
        "6,monitor:eDP-1"
        "7,monitor:eDP-1"
        "8,monitor:eDP-1"
      ];

      # Input configuration
      input = {
        kb_layout = "se";
        kb_variant = "nodeadkeys";

        # Keyboard repeat settings
        repeat_rate = 40;
        repeat_delay = 300;

        # Start with numlock on
        numlock_by_default = true;

        follow_mouse = 0;
        touchpad.natural_scroll = true;
        sensitivity = 0;
      };

      # General settings
      general = {
        gaps_in = 8;
        gaps_out = 18;
        border_size = 1;
        # Catppuccin Mocha mauve border colors
        "col.active_border" = "rgba(cba6f7ff)"; # Catppuccin mauve
        "col.inactive_border" = "rgba(313244ff)"; # Catppuccin surface0
        layout = "dwindle";
        allow_tearing = false;
      };

      # Render settings for Intel GPU optimization
      render = {
        # Direct scanout when possible (reduces compositing overhead)
        direct_scanout = true;
      };

      # Decoration
      decoration = {
        rounding = 12;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          offset = "0 4";
          color = "rgba(0000004D)";
          color_inactive = "rgba(00000026)";
        };
        # Window transparency
        active_opacity = 0.95;
        inactive_opacity = 0.85;
      };

      # Window rules
      windowrulev2 = [
        # TUI utilities (btop, bluetui, impala, fastfetch) - floating, centered, pinned
        "float,class:(com.mitchellh.ghostty.tui)"
        "center,class:(com.mitchellh.ghostty.tui)"
        "pin,class:(com.mitchellh.ghostty.tui)"
        "size 80% 80%,class:(com.mitchellh.ghostty.tui)"
        # Workspace assignments
        "workspace 1,class:(com.mitchellh.ghostty)$"
        "workspace 2,class:(dev.zed.Zed)"
        "maximize,class:(dev.zed.Zed)"
        "workspace 3,class:(chromium-browser)"
        "workspace 3,class:(firefox)"
      ];

      # Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          # Window creation/destruction animations
          "windows, 1, 5, default, slide"
          "windowsOut, 1, 5, default, slide"

          # Focus change animation (affects cyclenext window switching)
          # Format: "fade, ENABLED, SPEED, CURVE"
          # Lower speed = faster fade (try 3-10)
          "fade, 1, 5, default"

          # Workspace switching animation
          "workspaces, 1, 5, default"

          # Alternative fade options for cyclenext:
          # "fade, 1, 3, default"  - faster fade
          # "fade, 1, 7, default"  - slower fade
          # "fade, 0"              - disable fade (instant switch)
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        # Force split to the right (natural direction)
        force_split = 2; # 0 = follow mouse, 1 = left, 2 = right
        split_width_multiplier = 1.0;
      };

      # Misc settings
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        # VRR (Variable Refresh Rate) - 0 = off, 1 = on, 2 = fullscreen only
        vrr = 0;
      };

      # Variables
      "$mainMod" = "SUPER";
      "$hyper" = "CTRL ALT SHIFT SUPER";

      # Keybindings
      bind = [

        # Applications
        "$hyper, Return, exec, ghostty"
        "$mainMod, Space, exec, rofi -show drun"
        "$hyper, T, exec, ~/.local/bin/toggle-app ghostty ghostty"
        "$hyper, E, exec, ~/.local/bin/toggle-app zed zeditor"
        "$hyper, C, exec, ~/.local/bin/toggle-app chromium-browser chromium"
        "$hyper, B, exec, ~/.local/bin/toggle-app firefox firefox"

        # Window management
        "$mainMod, W, killactive"
        "$mainMod, M, exit"
        "$mainMod, P, pseudo"
        "$mainMod, S, togglesplit"
        "$mainMod, F, fullscreen"

        # Move focus (arrow keys)
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Screenshot
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"

        # Reload configuration
        "$mainMod SHIFT, R, exec, hyprctl reload"

        # Lock screen
        "$mainMod, Escape, exec, hyprlock"

        # Volume control
        ", XF86AudioRaiseVolume, exec, ~/.local/bin/volume up"
        ", XF86AudioLowerVolume, exec, ~/.local/bin/volume down"
        ", XF86AudioMute, exec, ~/.local/bin/volume mute"

        # Brightness control
        ", XF86MonBrightnessUp, exec, ~/.local/bin/brightness up"
        ", XF86MonBrightnessDown, exec, ~/.local/bin/brightness down"

        # Power button
        ", XF86PowerOff, exec, hyprlock"

        # Notification center
        "$mainMod, N, exec, swaync-client -t -sw"

        # Wallpaper cycling
        "CTRL $mainMod, Space, exec, ~/.local/bin/wallpaper next"

        # Cycle through windows on current workspace
        # Note: cyclenext uses fade animation only (controlled by fade setting above)
        # For different animations, use movefocus with directional keys instead
        "$mainMod, H, cyclenext, prev"
        "$mainMod, L, cyclenext"

        # Alternative: Use movefocus for directional movement (uses windows animation)
        # Uncomment these and comment out cyclenext above if you want slide/popin animations:
        # "$mainMod, H, movefocus, l"
        # "$mainMod, L, movefocus, r"
      ];

      # Hyper key bindings
      bindd = [
        "$mainMod, C, Universal copy, sendshortcut, CTRL, Insert,"
        "$mainMod, V, Universal paste, sendshortcut, SHIFT, Insert,"
        "$mainMod, X, Universal cut, sendshortcut, CTRL, X,"
        "$hyper, H, Switch to previous active workspace, workspace, m-1"
        "$hyper, L, Switch to next active workspace, workspace, m+1"
        "$hyper, code:10, Switch to workspace 1, workspace, 1"
        "$hyper, code:11, Switch to workspace 2, workspace, 2"
        "$hyper, code:12, Switch to workspace 3, workspace, 3"
        "$hyper, code:13, Switch to workspace 4, workspace, 4"
        "$hyper, code:14, Switch to workspace 5, workspace, 5"
        "$hyper, code:15, Switch to workspace 6, workspace, 6"
        "$hyper, code:16, Switch to workspace 7, workspace, 7"
        "$hyper, code:17, Switch to workspace 8, workspace, 8"
        "$hyper, code:18, Switch to workspace 9, workspace, 9"
        "$hyper, code:19, Switch to workspace 10, workspace, 10"
        "$hyper, F, Full width, fullscreen, 1"
      ];

      # Autostart
      exec-once = [
        "waybar"
        "swaync"
        # Start awww daemon for animated wallpaper transitions
        "awww-daemon"
        # Set random wallpaper at startup (after awww daemon starts)
        "sleep 1 && ~/.local/bin/wallpaper random"
        # Start swayidle for automatic screen locking after inactivity
        "swayidle -w timeout 300 'hyprlock' lock 'hyprlock' before-sleep 'hyprlock'"
      ];
    };
  };
}
