return {
  "neovim/nvim-lspconfig",
  init = function()
    -- Add border to `:LspInfo`.
    -- `:help lspconfig-highlight`
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
  opts = {
    servers = {
      tsserver = {
        settings = {
          implicitProjectConfiguration = {
            -- https://www.reddit.com/r/neovim/comments/132ax85/comment/jiacvuy/
            checkJs = true,
          },
        },
      },
    },
  },
}
