{...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        options = {
          shiftwidth = 4;
          tabstop = 4;
          expandtab = true;
        };

        autocmds = [
          {
            enable = true;
            event = ["BufEnter"];
            pattern = ["*.nix"];
            command = ":lua vim.opt_local.tabstop=2; vim.opt_local.shiftwidth=2";
          }
        ];
        keymaps = [
          {
            key = "<C-n>";
            mode = "n";
            silent = true;
            action = ":Neotree toggle<CR>";
          }
          {
            key = ";";
            mode = "n";
            noremap = true;
            action = ":";
          }
          {
            key = "<Esc>";
            mode = "t";
            noremap = true;
            action = "<C-\\><C-n>";
          }
          {
            key = "<Tab>";
            mode = "n";
            silent = true;
            action = ":bnext<CR>";
          }
          {
            key = "<S-Tab>";
            mode = "n";
            silent = true;
            action = ":bprev<CR>";
          }
          {
            key = "<C-.>";
            mode = "n";
            silent = true;
            noremap = true;
            action = ":lua vim.lsp.buf.code_action()<CR>";
          }
        ];

        lsp = {
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = true;
          lsplines.enable = true;
          nvim-docs-view.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableLSP = true;
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
          python.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
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
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

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

        utility.multicursors.enable = true;

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

        session = {
          nvim-session-manager.enable = true;
        };

        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}
