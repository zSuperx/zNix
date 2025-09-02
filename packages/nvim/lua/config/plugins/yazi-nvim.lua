require("yazi").setup()

vim.keymap.set("n", "<leader>-", ":Yazi<CR>", { desc = "Add new file in project" })
vim.keymap.set("n", "<leader>cw", ":Yazi cwd<CR>", { desc = "Add new file in project" })
