return {
  "noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = true,
    },
    -- https://github.com/folke/noice.nvim/issues/226#issuecomment-1340758028
    views = {
      mini = {
        win_options = {
          winblend = 0,
        },
      },
    },
  },
}
