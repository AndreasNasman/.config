return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = {
        { "mode" },
        { "searchcount" },
      },
      lualine_b = {
        {
          "branch",
          -- https://github.com/nvim-lualine/lualine.nvim#component-options
          ---@param str string
          fmt = function(str)
            if os.getenv("PWD") == os.getenv("CAMBRI_TOOL") then
              -- Only display e.g. `CT-1234` branch name part when in the `cambri2` repo.
              return str:match("%u+-%d+")
            else
              return str
            end
          end,
        },
      },
    },
  },
}
