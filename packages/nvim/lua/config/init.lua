vim.loader.enable()


-- Options

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.cmdheight = 0
vim.o.expandtab = true
vim.o.clipboard = "unnamedplus"
vim.o.timeout = false
vim.o.winborder = "rounded"

vim.o.undofile = true        -- Persistent undo
vim.o.cursorline = true
vim.o.cursorlineopt = "both" -- Highlights the line number of the cursorline
vim.o.number = true
vim.o.relativenumber = false
vim.o.signcolumn = "yes"

vim.o.shiftround = true -- Round to the nearest indentation level when using `<` and `>`. INCREDIBLE

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true -- Highlight search matches


-- Native Neovim Keymaps
-- (plugin-specific keymaps can be found in their respective plugin setup files)

vim.g.mapleader = " "

vim.keymap.set("n", ";", ":lua vim.api.nvim_feedkeys(':', 'n', true)<CR>")
vim.keymap.set("v", ";", ":lua vim.api.nvim_feedkeys(':\\'<,\\'>', 'v', true)<CR>")
vim.keymap.set("n", "<Esc>", ":if v:hlsearch | noh | endif<CR>")
vim.keymap.set("n", "<C-c>", ":%y+<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")
vim.keymap.set("n", "<C-[>", ":po<CR>")
vim.keymap.set("n", "<C-j>", ":m +1<CR>")
vim.keymap.set("n", "<C-k>", ":m -2<CR>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)


-- Plugins

require('config.plugins.blink-cmp')
require('config.plugins.tft-nvim')
require('config.plugins.fzf-lua')
require('config.plugins.transparent-nvim')
require('config.plugins.yazi-nvim')
require('config.plugins.neogit')
require('config.plugins.lualine-nvim')
require('config.plugins.nvim-autopair')
require('config.plugins.bufferline-nvim')
require('config.plugins.conform-nvim')
require('config.plugins.guess-indent-nvim')


-- LSP

vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('nixd')
vim.lsp.enable('marksman')
