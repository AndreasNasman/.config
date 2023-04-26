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
          fmt = function(str)
            if os.getenv("PWD") == os.getenv("CAMBRI_TOOL") then
              -- Only display `CT-1234` branch name part when in the `cambri2` repo.
              return str:sub(6, 12)
            else
              return str
            end
          end,
        },
      },
    },
  },
}
