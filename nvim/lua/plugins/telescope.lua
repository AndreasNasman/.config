-- https://github.com/nvim-telescope/telescope.nvim/issues/857#issuecomment-846368690
local buffer_previewer_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then
    local ft = require("plenary.filetype").detect(filepath, {})
    opts.use_ft_detect = false
    require("telescope.previewers.utils").regex_highlighter(bufnr, ft)
  end
  require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
end

-- https://github.com/nvim-telescope/telescope.nvim/issues/2041
local picker_config = {}
for builtin, _ in pairs(require("telescope.builtin")) do
  picker_config[builtin] = { show_line = false }
end

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
        buffer_previewer_maker = buffer_previewer_maker,
        layout_config = {
          vertical = {
            height = 0.99,
            width = 0.99,
          },
        },
        layout_strategy = "vertical",
      },
      pickers = picker_config,
    },
  },
}
