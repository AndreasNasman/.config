return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    opts.ui = vim.tbl_extend("force", opts.ui or {}, {
      -- Add border to `:Mason`.
      border = "rounded",
    })
  end,
}
