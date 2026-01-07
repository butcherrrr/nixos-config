{ pkgs, ... }:

{
  # Yazi terminal file manager configuration

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    # Catppuccin theme will be applied automatically via the catppuccin module
    # Just need to set it in the main config

    settings = {
      manager = {
        show_hidden = false;
        sort_by = "natural";
        sort_dir_first = true;
        linemode = "size";
        show_symlink = true;
      };

      preview = {
        max_width = 1000;
        max_height = 1000;
      };

      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
          }
        ];
        image = [
          {
            run = ''imv "$@"'';
            orphan = true;
          }
        ];
        video = [
          {
            run = ''mpv "$@"'';
            orphan = true;
          }
        ];
        pdf = [
          {
            run = ''zathura "$@"'';
            orphan = true;
          }
        ];
        # Archive extractor
        archive = [
          {
            run = ''tar -xf "$@"'';
            desc = "Extract here";
          }
        ];
      };

      open = {
        rules = [
          {
            name = "*/";
            use = "edit";
          }
          {
            mime = "text/*";
            use = "edit";
          }
          {
            mime = "image/*";
            use = "image";
          }
          {
            mime = "video/*";
            use = "video";
          }
          {
            mime = "audio/*";
            use = "video";
          }
          {
            mime = "application/pdf";
            use = "pdf";
          }
          {
            mime = "application/*zip";
            use = "archive";
          }
          {
            mime = "application/x-tar";
            use = "archive";
          }
          {
            mime = "application/x-bzip2";
            use = "archive";
          }
          {
            mime = "application/x-7z-compressed";
            use = "archive";
          }
        ];
      };
    };

    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "l" ];
          run = "plugin --sync smart-enter";
          desc = "Enter directory or open file";
        }
        {
          on = [ "q" ];
          run = "quit";
          desc = "Quit";
        }
        {
          on = [ "<C-n>" ];
          run = "arrow 1";
          desc = "Move cursor down 1 line";
        }
        {
          on = [ "<C-p>" ];
          run = "arrow -1";
          desc = "Move cursor up 1 line";
        }
      ];
    };

    plugins = {
    };
  };

  home.packages = with pkgs; [
    ffmpegthumbnailer # Video thumbnails
    unar # Archive preview
    jq # JSON preview
    poppler-utils # PDF preview
    fd # File searching
    ripgrep # Content searching
    fzf # Fuzzy finding
    zoxide
  ];
}
