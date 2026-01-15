vim.lsp.config("rust_analyzer",
  --- @type vim.lsp.ClientConfig
  {
    settings = {
      ['rust-analyzer'] = {
        lens = {
          enable = true,
          run = {
            enable = true
          },
          implementations = {
            enable = true
          },
          references = {
            adt = {
              enable = true
            },
            method = {
              enable = true
            },
            trait = {
              enable = true
            },
            enumVariant = {
              enable = true
            }
          }
        },
      }
    }
  })
