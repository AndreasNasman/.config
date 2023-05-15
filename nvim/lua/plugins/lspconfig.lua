return {
  "neovim/nvim-lspconfig",
  init = function()
    -- `:help lspconfig-highlight`
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
