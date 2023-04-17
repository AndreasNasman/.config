return {
  "folke/tokyonight.nvim",
  opts = {
    on_highlights = function(highlight)
      local purple_space = "#351a35"
      highlight.CursorLine = {
        bg = purple_space,
      }
    end,
    styles = {
      floats = "transparent",
      sidebars = "transparent",
    },
    transparent = true,
  },
}
