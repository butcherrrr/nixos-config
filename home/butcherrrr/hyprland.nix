{ ... }:

{
  # ============================================================================
  # Hyprland Configuration
  # ============================================================================

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Monitor configuration
      # Format: monitor = "NAME,RESOLUTION,POSITION,SCALE"
      # Examples:
      #   - ",preferred,auto,1"        # Auto detect, 100% scale
      #   - ",preferred,auto,1.25"     # Auto detect, 125% scale
      #   - ",preferred,auto,1.5"      # Auto detect, 150% scale
      #   - "eDP-1,1920x1080,0x0,1"    # Specific monitor, 1080p, 100% scale
      monitor = [
        "HDMI-A-1,3840x2160@60,0x0,2"
        "eDP-1,1920x1080@60,1920x0,1.5"
      ];

      workspace = [
        "1,monitor:HDMI-A-1,default:true"
        "2,monitor:HDMI-A-1"
        "3,monitor:HDMI-A-1"
        "4,monitor:HDMI-A-1"
        "5,monitor:HDMI-A-1"
        "6,monitor:eDP-1,default:true"
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

        follow_mouse = 1;
        touchpad.natural_scroll = false;
        sensitivity = 0;
      };

      # General settings
      general = {
        gaps_in = 6;
        gaps_out = 14;
        border_size = 1;
        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration
      decoration = {
        rounding = 2;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      # Window rules
      windowrulev2 = [
        "opacity 0.95 0.95,class:.*"
        # Floating TUI utilities (bluetui, impala)
        "float,class:(com.mitchellh.ghostty.floating)"
        "center,class:(com.mitchellh.ghostty.floating)"
        "size 900 600,class:(com.mitchellh.ghostty.floating)"
        # Workspace assignments
        "workspace 1,class:(com.mitchellh.ghostty)$"
        "workspace 2,class:(dev.zed.Zed)"
        "workspace 3,class:(firefox)"
      ];

      # Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        # Force split to the right (natural direction)
        force_split = 2;  # 0 = follow mouse, 1 = left, 2 = right
        split_width_multiplier = 1.0;
      };

      # Misc settings
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # Variables
      "$mainMod" = "SUPER";
      "$hyper" = "CTRL ALT SHIFT SUPER";

      # Keybindings
      bind = [
        # Applications
        "$hyper, Return, exec, ghostty"
        "$mainMod, Space, exec, rofi -show drun"
        "$hyper, T, exec, ~/.local/bin/toggle-terminal"
        "$hyper, E, exec, ~/.local/bin/toggle-zed"
        "$hyper, B, exec, ~/.local/bin/toggle-firefox"

        # Window management
        "$mainMod, W, killactive"
        "$mainMod, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, F, fullscreen"

        # Move focus (arrow keys)
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move focus (vim keys)
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

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

        # Volume control
        ", XF86AudioRaiseVolume, exec, ~/.local/bin/volume up"
        ", XF86AudioLowerVolume, exec, ~/.local/bin/volume down"
        ", XF86AudioMute, exec, ~/.local/bin/volume mute"

        # Brightness control
        ", XF86MonBrightnessUp, exec, ~/.local/bin/brightness up"
        ", XF86MonBrightnessDown, exec, ~/.local/bin/brightness down"
      ];

      # Hyper key bindings
      bindd = [
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
        "ALT, L, Cycle to next window, cyclenext"
        "ALT, H, Cycle to prev window, cyclenext, prev"
        "$hyper, F, Full width, fullscreen, 1"
      ];

      # Autostart
      exec-once = [
        "waybar"
        "mako"
        "swaybg -i ~/.config/hypr/wallpaper.jpg -m fill"
      ];
    };
  };
}
