{ pkgs, ... }:

{
  # ============================================================================
  # Zed Editor Configuration
  # ============================================================================

  programs.zed-editor = {
    enable = true;

    # User settings
    userSettings = {
      # UI
      ui_font_size = 16;
      buffer_font_size = 14;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_features = {
        calt = true;
      };

      # Editor behavior
      tab_size = 2;
      hard_tabs = false;
      soft_wrap = "editor_width";
      show_whitespaces = "selection";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;

      # Scrolling
      scroll_beyond_last_line = "one_page";
      vertical_scroll_margin = 3;

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

      # Telemetry
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Terminal
      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
        shell = {
          program = "zsh";
        };
      };

      # Format on save
      format_on_save = "on";

      # Autosave
      autosave = "on_focus_change";

      # Vim mode (optional)
      vim_mode = false;
    };

    # Extensions to install
    extensions = [
      "nix"
      "catppuccin"
    ];
  };
}
