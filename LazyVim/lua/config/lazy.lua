local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- Bootstrap `lazy.nvim`.
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  checker = {
    -- Automatically check for plugin updates without a popup notification.
    enabled = true,
    notify = false,
  },
  install = {
    -- Try to load a color scheme when starting an installation during startup
    colorscheme = {
      "catppuccin",
    },
  },
  performance = {
    rtp = {
      -- Disable unneeded RTP plugins.
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  spec = {
    -- Add LazyVim and import its plugins.
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
    },
    -- Import custom plugins and overrides.
    {
      import = "plugins",
    },
  },
  ui = {
    -- Add a border for `:Lazy`.
    border = "rounded",
  },
})
