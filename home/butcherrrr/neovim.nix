{ pkgs, ... }:

{
  # ============================================================================
  # Neovim Configuration with LazyVim
  # ============================================================================

  programs.neovim = {
    enable = true;
    defaultEditor = true;  # Set as default EDITOR
    viAlias = true;        # alias vi to nvim
    vimAlias = true;       # alias vim to nvim
    vimdiffAlias = true;   # alias vimdiff to nvim -d

    # Extra packages available to Neovim
    extraPackages = with pkgs; [
      # Language servers
      lua-language-server
      nil  # Nix LSP
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted  # HTML, CSS, JSON
      pyright  # Python
      gopls    # Go
      rust-analyzer  # Rust

      # Formatters
      stylua    # Lua
      nixpkgs-fmt  # Nix
      nodePackages.prettier  # JS, TS, JSON, YAML, Markdown
      black     # Python

      # Tools (ripgrep and git already in system/home-manager)
      fd        # Telescope dependency
      gcc       # Treesitter compiler
      gnumake   # Build tool
      unzip     # Mason dependency
    ];

    # Environment variables
    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- Set leader key before loading lazy.nvim
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      -- LazyVim setup
      require("lazy").setup({
        spec = {
          -- Import LazyVim
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },

          -- Catppuccin colorscheme
          {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            lazy = false,
            opts = {
              flavour = "mocha",
              integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                  enabled = true,
                  indentscope_color = "",
                },
              },
            },
          },

          -- Import LazyVim extras
          { import = "lazyvim.plugins.extras.lang.typescript" },
          { import = "lazyvim.plugins.extras.lang.json" },
          { import = "lazyvim.plugins.extras.lang.python" },
          { import = "lazyvim.plugins.extras.lang.rust" },
          { import = "lazyvim.plugins.extras.lang.go" },
          { import = "lazyvim.plugins.extras.formatting.prettier" },
          { import = "lazyvim.plugins.extras.linting.eslint" },
          { import = "lazyvim.plugins.extras.ui.mini-animate" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        install = { colorscheme = { "catppuccin-mocha" } },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })

      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.termguicolors = true
      vim.opt.undofile = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.updatetime = 250
      vim.opt.signcolumn = "yes"
      vim.opt.splitright = true
      vim.opt.splitbelow = true

      -- Force Catppuccin theme after everything loads
      vim.cmd.colorscheme "catppuccin-mocha"
    '';
  };

  # Symlink LazyVim config directory
  home.file.".config/nvim/lua/config" = {
    source = ../../config/nvim/lua/config;
    recursive = true;
  };

  home.file.".config/nvim/lua/plugins" = {
    source = ../../config/nvim/lua/plugins;
    recursive = true;
  };
}
