return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "luacheck",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = {
          "luacheck",
        },
      },
    },
  },
}
