local options = {
	clipboard = "unnamedplus",
	-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
	completeopt = "menu,menuone,noselect",
	cursorline = true,
	expandtab = true,
	ignorecase = true,
	number = true,
	relativenumber = true,
	shiftwidth = 2,
	signcolumn = "yes",
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	tabstop = 2,
	termguicolors = true,
	undofile = true,
	-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
	-- `250` seems like a common low functioning value for `updatetime`.
	-- Lowering it causes problems when running e.g. `ReloadConfig`.
	updatetime = 300,
	wrap = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
