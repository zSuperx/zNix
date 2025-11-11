require('project').setup({ })

vim.keymap.set("n", "<leader>fp", ":ProjectFzf<CR><C-e>", { desc = "Pick a project" })
