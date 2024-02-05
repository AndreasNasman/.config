local cmp = require("cmp")

return {
  "hrsh7th/nvim-cmp",
  opts = {
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    mapping = {
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    },
  },
}
