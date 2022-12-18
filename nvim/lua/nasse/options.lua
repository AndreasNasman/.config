-- `setup` should be run before loading the color scheme.
-- https://github.com/folke/tokyonight.nvim/issues/190#issuecomment-1237641162
require("tokyonight").setup({
	style = "moon",
	styles = {
		floats = "transparent",
		sidebars = "transparent",
	},
	transparent = true,
})

-- Color schemes should be loaded early to avoid color and plugin integration problems.
-- The configuration should therefore be placed outside the `after` directory.
-- https://github.com/folke/tokyonight.nvim/issues/260#issuecomment-1310773275
vim.cmd.colorscheme("tokyonight")

-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/#vim-opt
local opt = vim.opt

opt.clipboard = "unnamedplus"
-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.list = true
opt.listchars:append("space:⋅")
opt.magic = false
opt.number = true
opt.relativenumber = true
opt.shiftwidth = 2
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
-- `250` seems like a common low functioning value for `updatetime`.
-- Lowering it might cause problems when running certain commands.
opt.updatetime = 250
opt.wrap = false
