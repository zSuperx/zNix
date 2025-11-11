require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    nix = { 'nixfmt' },
  }
})

