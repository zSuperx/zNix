vim.api.nvim_create_user_command("F",
    function(args)
        vim.lsp.buf.format()
    end
    , {
        nargs = 0,
        desc = "Format file using built-in formatter",
    })

vim.api.nvim_create_user_command("Fw",
    function(args)
        vim.lsp.buf.format()
        vim.cmd("w", args)
    end
    , {
        nargs = 0,
        desc = "Format file using built-in formatter",
    })

vim.api.nvim_create_user_command("FW",
    function(args)
        vim.lsp.buf.format()
        vim.cmd("w", args)
    end
    , {
        nargs = 0,
        desc = "Format file using built-in formatter",
    })

local range_formatting = function()
    local start_row = vim.api.nvim_buf_get_mark(0, "<")[0]
    local end_row = vim.api.nvim_buf_get_mark(0, ">")[0]
    vim.lsp.buf.format({
        range = {
            ["start"] = { start_row, 0 },
            ["end"] = { end_row, 0 },
        },
        async = true,
    })
end

vim.keymap.set("v", "<leader>lf", range_formatting, { desc = "Range Formatting" })
