return {
  "neovim/nvim-lspconfig",
  init = function()
    -- Add border to `:LspInfo`.
    -- `:help lspconfig-highlight`
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
