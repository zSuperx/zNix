require('lualine').setup({
  options = {
    theme = "base16",
    section_separators = "",
    component_separators = "",
    globalstatus = true,
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
        symbols = { modified = '', readonly = '', unnamed = '' },
        fmt = function(name)
          if vim.bo.modified then
            -- Highlight group will color both filename and symbol
            return "%#LualineModifiedFile#" .. name .. " ●%*"
          else
            return name
          end
        end,
      },
      {
        "",
        draw_empty = true,
        separator = { left = '', right = '' },
      },
    },
    lualine_c = {
      {
        'altfile',
        color = { gui='italic' },
        fmt = function()
          local alt = vim.fn.bufnr('#')
          if alt ~= -1 then
            local full_alt_path = vim.api.nvim_buf_get_name(alt)

            return vim.fn.fnamemodify(full_alt_path, ":t")
          else
            return ""
          end
        end,
      },
      {
        "diff",
        symbols = { added = '+', modified = '~', removed = '-' },
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

local lualine_hl = vim.api.nvim_get_hl(0, { name = "lualine_b_normal" })
local lualine_hl_new = vim.tbl_extend('force', lualine_hl, { fg = "#6cbf43", bold = true, italic = true })
vim.api.nvim_set_hl(0, "LualineModifiedFile", lualine_hl_new)
