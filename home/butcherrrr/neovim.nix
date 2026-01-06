{ pkgs, ... }:

{
  # Nixvim Configuration
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Core Settings
    opts = {
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      termguicolors = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      updatetime = 250;
      signcolumn = "yes";
      splitright = true;
      splitbelow = true;
      scrolloff = 8;
      sidescrolloff = 8;
      wrap = false;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      conceallevel = 0;
    };

    # Colorscheme
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = false;
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          treesitter = true;
          notify = false;
          mini = {
            enabled = true;
            indentscope_color = "";
          };
        };
      };
    };

    # Plugins
    plugins = {
      # LSP
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          nil_ls.enable = true;
          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          pyright.enable = true;
          gopls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      # Completion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };

      # Snippets
      luasnip.enable = true;

      # Treesitter
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Telescope
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };

      # File explorer
      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          window.width = 30;
        };
      };

      # Git
      gitsigns = {
        enable = true;
        settings.current_line_blame = true;
      };

      # Status line
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "catppuccin";
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
          };
        };
      };

      # Buffer line
      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            separator_style = "slant";
          };
        };
      };

      # Which-key
      which-key.enable = true;

      # Auto pairs
      nvim-autopairs.enable = true;

      # Comments
      comment.enable = true;

      # Indent guides
      indent-blankline.enable = true;

      # Dashboard
      alpha = {
        enable = true;
        settings = {
          layout = [
            {
              type = "padding";
              val = 2;
            }
            {
              type = "text";
              val = [
                "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
                "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
                "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
                "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
                "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
                "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
              ];
              opts = {
                position = "center";
                hl = "Type";
              };
            }
          ];
        };
      };

      # Formatting
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            nix = [ "nixpkgs_fmt" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            json = [ "prettier" ];
            yaml = [ "prettier" ];
            markdown = [ "prettier" ];
            python = [ "black" ];
          };
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
        };
      };

      # Notifications
      notify.enable = true;

      # Web devicons (explicitly enable to avoid deprecation warning)
      web-devicons.enable = true;
    };

    # Keymaps
    globals.mapleader = " ";
    globals.maplocalleader = "\\";

    keymaps = [
      # File explorer
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle file explorer";
      }

      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move to left window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move to bottom window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move to top window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move to right window";
      }

      # Buffer navigation
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next buffer";
      }

      # Save and quit
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<cr>";
        options.desc = "Save file";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<cr>";
        options.desc = "Quit";
      }

      # Better indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }
    ];

    extraPackages = with pkgs; [
      # Language servers (already provided by nixvim LSP config)

      # Formatters
      stylua
      nixpkgs-fmt
      nodePackages.prettier
      black

      # Tools
      fd
      ripgrep
      git
    ];
  };
}
