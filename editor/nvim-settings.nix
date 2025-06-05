_: {
  config.vim = {
    viAlias = true;
    vimAlias = true;
    debugMode = {
      enable = false;
      level = 16;
      logFile = "/tmp/nvim.log";
    };

    options = {
      # Default tab size = 4
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      # Sync clipboard with system (wl-copy)
      clipboard = "unnamedplus";
    };

    autocmds = [
      {
        # Sets the tab size to 2 in .nix files
        enable = true;
        event = ["BufEnter"];
        pattern = ["*.nix"];
        command = ":lua vim.opt_local.tabstop=2; vim.opt_local.shiftwidth=2";
      }
    ];
    keymaps = [
      # Makes ; behave like : and opens the Ex-command line
      { key = ";"; mode = "n"; noremap = true; action = ":lua vim.api.nvim_feedkeys(':', 'n', true)<CR>"; }
      { key = "<Esc>"; mode = "n"; noremap = true; action = ":if v:hlsearch | noh | endif<CR>"; }
      { key = "<C-c>"; mode = "n"; noremap = true; action = ":%y+<CR>"; }
      { key = "<Esc>"; mode = "t"; noremap = true; action = "<C-\\><C-n>"; }
      { key = "<Tab>"; mode = "n"; silent = true; action = ":bnext<CR>"; }
      { key = "<S-Tab>"; mode = "n"; silent = true; action = ":bprev<CR>"; }
      { key = "<C-[>"; mode = "n"; silent = true; noremap = true; action = ":po<CR>"; }
      { key = "<C-j>"; mode = "n"; silent = true; noremap = true; action = ":m +1<CR>"; }
      { key = "<C-k>"; mode = "n"; silent = true; noremap = true; action = ":m -2<CR>"; }
    ];

    lineNumberMode = "number";

    lsp = {
      enable = true;
      formatOnSave = false;
      lspkind.enable = false;
      lightbulb.enable = false;
      trouble.enable = true;
      lspSignature.enable = true;
      otter-nvim.enable = true;
      nvim-docs-view.enable = true;
    };

    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
    };
    
    fzf-lua.enable = true;

    # This section does not include a comprehensive list of available language modules.
    # To list all available language module options, please visit the nvf manual.
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # Languages that will be supported in default and maximal configurations.
      nix.enable = true;
      markdown.enable = true;

      # Languages that are enabled in the maximal configuration.
      lua.enable = true;
      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html.enable = true;
      ts.enable = true;
      python = {
        enable = true;
        format = {
          enable = true;
          type = "black";
        };
      };
      rust = {
        enable = true;
        crates.enable = true;
      };
    };

    diagnostics.config = {
      virtual_text = true;
      virtual_lines = true;
    };

    visuals = {
      nvim-scrollbar.enable = true;
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;

      highlight-undo.enable = true;
      indent-blankline.enable = true;

      # Fun
      cellular-automaton.enable = false;
    };

    statusline = {
      lualine = {
        enable = true;
        theme = "catppuccin";
      };
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
    };

    autopairs.nvim-autopairs.enable = true;

    autocomplete.nvim-cmp = {
      enable = true;
    };
    snippets.luasnip.enable = true;

    filetree = {
      nvimTree = {
        enable = false;
        mappings.toggle = "<C-n>";
        setupOpts = {
          diagnostics.enable = true;
          diagnostics.show_on_dirs = true;
          view.width = {
            min = 30;
            max = -1;
            padding = 1;
          };
        };
      };
    };

    tabline = {
      nvimBufferline = {
        enable = true;
        setupOpts = {
          options.sort_by = "insert_at_end";
          options.indicator.style = "underline";
        };
      };
    };

    treesitter.context.enable = false;

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    telescope.enable = true;

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
    };

    minimap = {
      minimap-vim.enable = false;
      codewindow.enable = true; # lighter, faster, and uses lua for configuration
    };

    dashboard = {
      dashboard-nvim.enable = false;
      alpha.enable = true;
    };

    notify = {
      nvim-notify.enable = false;
    };

    projects = {
      project-nvim.enable = false;
    };

    utility = {
      multicursors.enable = true;
      yazi-nvim.enable = true;
    };

    notes = {
      todo-comments.enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false; # the theme looks terrible with catppuccin
      illuminate.enable = true;
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          ruby = "120";
          java = "130";
          go = ["90" "130"];
        };
      };
      fastaction.enable = true;
    };

    comments = {
      comment-nvim = {
        enable = true;
        mappings = {
          toggleSelectedBlock = " /";
          toggleCurrentLine = " /";
        };
      };
    };
  };
}
