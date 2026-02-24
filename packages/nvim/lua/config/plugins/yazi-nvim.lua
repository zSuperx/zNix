require("yazi").setup({
  --- @param chosen_file string
  open_file_function = function(chosen_file, config, state)
    local pdf_suffix = ".pdf"
    if chosen_file:sub(- #pdf_suffix):lower() == pdf_suffix then
      -- Open PDFs with xdg-open and detach the process
      vim.fn.jobstart({ "xdg-open", chosen_file }, { detach = true })
    else
      -- Open everything else normally
      vim.cmd(string.format("edit %s", vim.fn.fnameescape(chosen_file)))
    end
  end,

  integrations = {
    grep_in_directory = function (directory)
      require("fzf-lua").live_grep({
        cwd = directory,
      })
    end
  }
})

vim.keymap.set("n", "<leader>-", ":Yazi<CR>", { desc = "Open Yazi in current file's directory" })
vim.keymap.set("n", "<leader>cw", ":Yazi cwd<CR>", { desc = "Open Yazi in project root" })
