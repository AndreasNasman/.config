return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "grammarly-languageserver",
    })

    opts.ui = vim.tbl_extend("force", opts.ui or {}, {
      border = "rounded",
    })
  end,
}
