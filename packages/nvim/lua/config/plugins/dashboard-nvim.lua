require('dashboard').setup({
  theme = 'hyper',
  config = {
    hide = {
      statusline = false,
    },
    header = { '' },
    disable_move = true,
    shortcut = {
      {
        desc = 'Close the dashboard',
        group = '@property',
        key = 'q',
        action = 'lua if vim.fn.bufnr("#") ~= -1 then vim.cmd("b#") else vim.cmd("enew") end'
      }
    },
    packages = { enable = false },
    project = { enable = false },
    mru = { enable = true, limit = 5, cwd_only = true },
  }
})

vim.keymap.set('n', '<leader>d', ':Dashboard<CR>')
