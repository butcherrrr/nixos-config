{ pkgs, ... }:

{
  # ============================================================================
  # Zed Editor Configuration
  # ============================================================================

  programs.zed-editor = {
    enable = true;

    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 14;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_features = {
        calt = true;
      };

      tab_size = 2;
      hard_tabs = false;
      soft_wrap = "none";
      show_whitespaces = "selection";
      project_panel = {
        dock = "right";
      };
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;

      scroll_beyond_last_line = "one_page";
      vertical_scroll_margin = 3;

      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = true;
        };
      };

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

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
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
      "catppuccin"
    ];
  };
}
