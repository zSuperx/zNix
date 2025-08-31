local cmp = require('blink.cmp')
local lsp_capabilities = cmp.get_lsp_capabilities()
local default_providers = { "lsp", "path", "snippets", "omni" }

vim.lsp.config('*', {
  capabilities = lsp_capabilities,
})

cmp.setup({
  keymap = {
    preset = "none",

    ["<C-Space>"] = { "show", "hide" },

    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-f>"] = { "accept", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },

  completion = {
    -- Autoselect the first element, but don't insert it. Instead, just preview
    -- the insert with ghost text.
    list = {
      selection = {
        preselect = true,
        -- Ghost text is preferable
        auto_insert = false,
      },
    },
    ghost_text = { enabled = true },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },

    -- I'd prefer to have this through nvim-autopairs, but I couldn't get it
    -- working. See https://github.com/windwp/nvim-autopairs/issues/477
    accept = {
      auto_brackets = {
        enabled = true,

        -- Pipe operators there - no need
        blocked_filetypes = { "gleam" },
      },
    },
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "none",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },

    completion = {
      -- In cmdline, we want to manually select something - and once it's
      -- selected, we can keep scrolling
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },

      menu = { auto_show = true },
    },
  },

  snippets = { preset = "luasnip" },

  signature = {
    enabled = true,

    window = { show_documentation = true },
  },

  -- Prioritizes exact matches higher
  fuzzy = {
    implementation = "prefer_rust_with_warning",

    sorts = {
      "exact",
      -- defaults
      "score",
      "sort_text",
    },
  },

  sources = {
    default = default_providers,

    providers = {
      -- autosnippets are automatically expanded, so showing the completion
      -- would be a waste of time
      snippets = { opts = { show_autosnippets = false } },

      -- Filtered version of `lsp` that only contains snippets. We do this so we
      -- can only see snippets when pressing Ctrl+s
      lsp_snippets = {
        name = "LSP Snippets",
        module = "blink.cmp.sources.lsp",
        transform_items = function(_, items)
          return vim.tbl_filter(function(item)
            return item.kind == require("blink.cmp.types").CompletionItemKind.Snippet
          end, items)
        end,
      },
    },
  },
})
