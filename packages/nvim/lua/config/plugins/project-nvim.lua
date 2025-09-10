require('project').setup()

vim.keymap.set("n", "<leader>fp", ":ProjectFzf<CR>", { desc = "Pick a project" })
