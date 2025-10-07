vim.env.FZF_DEFAULT_OPTS = nil
local utils = require("fzf-lua.utils")
local path = require("fzf-lua.path")
local actions = require('fzf-lua.actions')

require('fzf-lua').setup({
  'border-fused',
  files = {
    actions = {
      ["default"] = actions.file_edit,
    }
  },
  keymap = {
    fzf = {
      ["start"] = "unbind(down,up)+hide-input",
      ["j"] = "down",
      ["k"] = "up",
      ["q"] = "abort",
      ["i"] = "show-input+unbind(i,j,k)",
      ["ctrl-e"] = 'transform:if [[ "$FZF_INPUT_STATE" = enabled ]]; then echo "hide-input+rebind(i,j,k)"; fi',
      ["ctrl-d"] = "half-page-down",
      ["ctrl-u"] = "half-page-up",
    }
  },
  grep = {
    actions = {
      ["ctrl-f"] = { actions.grep_lgrep },
    },
  },
  buffers = {
    fzf_opts = {
      ["--header-lines"] = false,
    },
    actions = {
      ["ctrl-d"] = {
        reload = true,
        fn = function(selected, opts)
          for _, sel in ipairs(selected) do
            local entry = path.entry_to_file(sel, opts)
            local bufnr = entry.bufnr

            local is_dirty = utils.buffer_is_dirty(bufnr, true, false)

            -- If file isn't loaded. Not sure why this is needed, but it's from
            -- the original!
            if not bufnr then
              goto continue
            end

            -- If the current file has unsaved changes, prompt the user to save
            if is_dirty then
              local save_dialog = function()
                return utils.save_dialog(bufnr)
              end
              if not vim.api.nvim_buf_call(bufnr, save_dialog) then
                goto continue
              end
            end

            -- The current buffer is actually the picker - so the alt buffer lets
            -- us see the file we're currently editing
            local current_buf = vim.fn.bufnr("#")

            if bufnr == current_buf then
              -- replace current buf with scratch buf in all windows
              local windows = vim.fn.win_findbuf(current_buf)

              local new_buf = vim.api.nvim_create_buf(false, true)
              for _, win in ipairs(windows) do
                vim.api.nvim_win_set_buf(win, new_buf)
              end
            end

            vim.api.nvim_buf_delete(bufnr, { force = true })
            ::continue::
          end
        end,
      },
    }
  }
})


FzfLua.register_ui_select()

vim.keymap.set("n", "<leader>fl", FzfLua.builtin, { desc = "Open FzfLua's menu--with FzfLua!" })
vim.keymap.set("n", "<leader>fr", FzfLua.resume, { desc = "Resume previous FzfLua search" })
vim.keymap.set("n", "<leader>ff", FzfLua.files, { desc = "Pick buffers from project directory" })
vim.keymap.set("n", "<leader>ft", FzfLua.tabs, { desc = "Pick tab from existing tabs" })
vim.keymap.set("n", "<leader>fb", FzfLua.buffers, { desc = "Pick buffers from open buffers" })
vim.keymap.set("n", "<leader>fg", FzfLua.live_grep, { desc = "Pick buffers from live grep" })
