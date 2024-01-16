return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- Configure only floating windows to show the source with multiple diagnostics.
        -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-source-in-diagnostics
        -- `:help vim.diagnostic`
        float = {
          source = "if_many",
        },
        virtual_text = {
          source = false,
        },
      },
    },
  },
}
