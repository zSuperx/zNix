local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },
    rust = { 'rustfmt' },
    nix = { 'nixfmt' },
  }
})

vim.keymap.set("n", "<leader>lf", conform.format, { desc = "Format file" })
