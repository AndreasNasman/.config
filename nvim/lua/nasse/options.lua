-- `:help clipboard-wsl`
vim.g.clipboard = {
	name = "WslClipboard",
	copy = {
		["+"] = "clip.exe",
		["*"] = "clip.exe",
	},
	paste = {
		["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
	},
	cache_enabled = 0,
}

-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/#vim-opt
local opt = vim.opt

-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.expandtab = true
opt.fillchars = "eob: "
opt.guicursor:append("a:blinkon100")
opt.ignorecase = true
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
