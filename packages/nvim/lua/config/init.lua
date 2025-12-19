-- My personalized Neovim options

-- Options

vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- TODO: looks a bit ugly, but I've found it's got really useful telemtry
vim.o.cmdheight = 1

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

vim.o.shiftround = true -- Snap to the nearest indentation level when using `<` and `>`. INCREDIBLE

vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight search matches, but default them to off
-- in case this file was `:source`d dynamically
vim.o.hlsearch = true
vim.cmd("noh")

-- Native Neovim Keymaps
-- (plugin-specific keymaps can be found in their respective plugin setup files)

vim.g.mapleader = " "

vim.keymap.set("n", ";", ":lua vim.api.nvim_feedkeys(':', 'n', true)<CR>", { desc = "Make ; behave like :" })
vim.keymap.set("v", ";", ":lua vim.api.nvim_feedkeys(':\\'<,\\'>', 'v', true)<CR>", { desc = "Make ; behave like :" })

vim.keymap.set("n", "<Esc>", ":if v:hlsearch | noh | endif<CR>", { desc = "Unhighlight search results" })
vim.keymap.set("n", "<C-c>", ":%y+<CR>", { desc = "Copy entire file to clipboard" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape to Normal mode from Terminal Insert mode" })
-- vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape to Normal mode" })

-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-[>", ":po<CR>", { desc = "Go back 1 reference" })

vim.keymap.set("n", "<C-j>", ":m +1<CR>=j", { desc = "Move current line down" })
vim.keymap.set("n", "<C-k>", ":m -2<CR>=j", { desc = "Move current line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR><Esc>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR><Esc>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("v", ">", ">gv", { desc = "Indent selected lines" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent selected lines" })

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format file" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "suggest code action" })
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "suggest code action" })


vim.keymap.set({ "n", "v" }, "!", "gcl", { remap = true })
vim.keymap.set("n", "<Tab>", "<C-^>", { remap = true })

-- Plugins


require('config.plugins.base16-colorscheme')
require('config.plugins.blink-cmp')
require('config.plugins.tft-nvim')
require('config.plugins.fzf-lua')
require('config.plugins.transparent-nvim')
require('config.plugins.yazi-nvim')
require('config.plugins.neogit')
require('config.plugins.nvim-autopair')
require('config.plugins.conform-nvim')
require('config.plugins.uv-nvim')
-- require('config.plugins.project-nvim')
-- require('config.plugins.term-edit-nvim')
require('config.plugins.typst-preview-nvim')
require('config.plugins.scope-nvim')
require('config.plugins.fFtT-highlights-nvim')
require('config.plugins.dashboard-nvim')
require('config.plugins.nvim-web-devicons')

-- Lualine is sourced in the runtime module
-- require('config.plugins.lualine-nvim')

-- LSP


vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('nixd')
vim.lsp.enable('gopls')
vim.lsp.enable('nil_ls')
vim.lsp.enable('marksman')
vim.lsp.enable('tinymist')
vim.lsp.enable('ccls')
vim.lsp.enable('html')

-- Extra Lua code to source


require('config.extras.math-eval')
