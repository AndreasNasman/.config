local options = {
	clipboard = "unnamedplus",
	completeopt = "menu,menuone,noselect", -- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
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
	wrap = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
