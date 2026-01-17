{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

let
  # Import custom theme from separate file
  customTheme = import ./themes/zed-custom-catppuccin.nix;
in
{
  # Zed Editor Configuration
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;

    userSettings = {
      # Panel settings
      notification_panel = {
        button = false;
      };
      git_panel = {
        button = false;
      };
      outline_panel = {
        button = false;
      };
      project_panel = {
        sticky_scroll = true;
        button = false;
        dock = "right";
      };

      # Window and UI
      window_decorations = "client";
      tab_bar = {
        show_tab_bar_buttons = true;
        show_nav_history_buttons = false;
      };
      title_bar = {
        show_menus = false;
        show_user_picture = false;
        show_onboarding_banner = true;
        show_project_items = true;
        show_branch_name = false;
      };

      # Toolbar and buttons
      debugger = {
        button = false;
      };
      search = {
        button = false;
      };
      toolbar = {
        agent_review = false;
        selections_menu = false;
        quick_actions = false;
        breadcrumbs = false;
      };

      # Editor appearance
      colorize_brackets = false;
      indent_guides = {
        background_coloring = "disabled";
        coloring = "indent_aware";
      };
      show_wrap_guides = true;
      relative_line_numbers = "enabled";

      # Fonts
      ui_font_size = 24;
      ui_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 21;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_features = {
        calt = true;
      };
      assistant_font_family = "JetBrainsMono Nerd Font";
      assistant_font_size = 17;
      agent_buffer_font_size = 21.0;

      # Editor behavior
      tab_size = 2;
      hard_tabs = false;
      soft_wrap = "none";
      show_whitespaces = "selection";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;
      scroll_beyond_last_line = "one_page";
      vertical_scroll_margin = 3;

      # Agent and AI
      agent = {
        default_model = {
          provider = "copilot_chat";
          model = "claude-sonnet-4.5";
        };
        model_parameters = [ ];
      };
      features = {
        edit_prediction_provider = "copilot";
      };
      edit_predictions = {
        mode = "subtle";
      };

      # Extensions
      auto_install_extensions = {
        catppuccin = true;
        catppuccin-icons = true;
        nix = true;
        hyprlang = true;
      };

      # Git
      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = true;
        };
      };

      # LSP
      lsp = {
        rust-analyzer = {
          binary = {
            path = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          };
        };
        nixd = {
          binary = {
            path = "${pkgs.nixd}/bin/nixd";
          };
        };
      };

      icon_theme = "Catppuccin Mocha";

      # Custom theme definitions
      # Catppuccin Mocha theme loaded from ./themes/zed-custom-catppuccin.nix
      themes = customTheme.themes;

      # Theme selection - using custom Catppuccin Mocha theme
      # Using lib.mkForce to override any other theme definitions
      theme = lib.mkForce {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Mocha";
      };

      # Telemetry
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      terminal = {
        button = false;
        font_family = "JetBrainsMono Nerd Font";
        font_size = 21;
        shell = {
          program = "zsh";
        };
      };

      format_on_save = "on";
      autosave = "on_focus_change";

      vim_mode = true;
    };

    extensions = [
      "nix"
      "catppuccin-icons"
      "hyprlang"
    ];
  };
}
