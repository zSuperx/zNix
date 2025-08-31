require('lualine').setup({
  options = {
    section_separators = "",
    component_separators = "",
    refresh = {
      statusline = 500,
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = {
          right = ''
        },
      }
    },
    lualine_b = {
      {
        'filetype',
        icon_only = true,
        icon = { align = 'left' },
      },

      {
        'filename',
        symbols = { modified = ' ', readonly = ' ' },
        separator = {
          right = ''
        },
      },

      {
        "",
        draw_empty = true,
        separator = { left = '', right = '' },
      },
    },
    lualine_c = {
      {
        "diff",
        symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the diff symbols
        separator = { right = '' }
      },
      {
        "macro_recording",
        fmt = function()
          local recording_register = vim.fn.reg_recording()
          if recording_register == "" then
            return ""
          else
            return "Recording @" .. recording_register
          end
        end,
      },
    },

    lualine_x = {
      {
        -- Lsp server name
        function()
          local buf_ft = vim.bo.filetype
          local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

          if excluded_buf_ft[buf_ft] then
            return ""
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients({ bufnr = bufnr })

          if vim.tbl_isempty(clients) then
            return "No Active LSP"
          end

          local active_clients = {}
          for _, client in ipairs(clients) do
            table.insert(active_clients, client.name)
          end

          return table.concat(active_clients, ", ")
        end,
        icon = ' ',
        separator = { left = '' },
      },
      {
        "diagnostics",
        sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc' },
        symbols = { error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 ' },
        colored = true,
        update_in_insert = false,
        always_visible = false,
        diagnostics_color = {
          color_error = { fg = 'red' },
          color_warn = { fg = 'yellow' },
          color_info = { fg = 'cyan' },
        },
      }
    },
    lualine_y = {
      {
        "",
        draw_empty = true,
        separator = { left = '', right = '' }
      },
      {
        'searchcount',
        maxcount = 999,
        timeout = 120,
        separator = { left = '' },
      },
      {
        "branch",
        icon = ' •',
        separator = { left = '' },
      },
    },
    lualine_z = {
      {
        "",
        draw_empty = true,
        separator = { left = '' },
      },
      {
        "progress",
        separator = { left = '' }
      },
      { "location" },
      {
        "fileformat",
        symbols = {
          unix = '', -- e712
          dos = '', -- e70f
          mac = '', -- e711
        },
      },
    },
  }
})
