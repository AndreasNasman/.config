return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function(_, opts)
      require("telescope").load_extension("fzf")
      require("telescope").setup(opts)
    end,
    opts = {
      defaults = {
        layout_config = {
          vertical = { height = 0.99, width = 0.99 },
        },
        layout_strategy = "vertical",
      },
    },
  },
}
