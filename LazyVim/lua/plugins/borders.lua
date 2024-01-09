-- Add a border for diagnostics.
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

return {
  -- Add a border for LSP hover and signature help.
  {
    "noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  -- Add a border for completion and documentation menus.
  {
    "hrsh7th/nvim-cmp",
    --- @param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.window = vim.tbl_extend("force", opts.window or {}, {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      })
    end,
  },
  -- Add a border for `:LspInfo`.
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  -- Add a border for `:Mason`.
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  -- Add a border for `:WhichKey`.
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = "rounded",
      },
    },
  },
}
