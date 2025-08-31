local Yazi = require("yazi")

Yazi.setup({
  open_for_directories = true,
})

vim.keymap.set("n", "<leader>-", ":Yazi<CR>", { desc = "Add new file in project" })
