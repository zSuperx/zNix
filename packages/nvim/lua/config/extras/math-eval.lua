-- Giga-useful function to evaluate mathematical expressions and print their result
vim.api.nvim_create_user_command('Eval', function()
  -- Get visual selection
  local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(start_line, end_line)

  if #lines == 0 then
    print("No text selected")
    return
  end

  -- Trim text properly if it's a single line
  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  lines[1] = string.sub(lines[1], start_col)

  local code = table.concat(lines, "\n")

  local ok, result = pcall(loadstring("return " .. code))
  if not ok then
    ok, result = pcall(loadstring(code))
  end

  if ok and vim.inspect(result) ~= "nil" then
    local function insert_after(bufnr, row, col, text)
      bufnr = bufnr or 0
      local lc = vim.api.nvim_buf_line_count(bufnr)
      if row < 0 then row = 0 end
      if row >= lc then row = lc - 1 end

      local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1] or ""
      if col < 0 then col = 0 end
      col = math.min(col, #line)                          -- clamp to end of line

      local insert_col = math.min(col + 1, #line)         -- insert after col
      lines = vim.split(text, '\n', { trimempty = true }) -- split into lines for set_text
      vim.api.nvim_buf_set_text(bufnr, row, insert_col, row, insert_col, lines)
    end

    insert_after(0, end_line - 1, end_col - 1, " = " .. vim.inspect(result))
  else
    print("Error: not a valid expression")
  end
end, { range = true })

vim.keymap.set("v", "<leader>e", ":Eval<CR>")

