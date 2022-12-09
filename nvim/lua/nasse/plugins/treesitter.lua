-- https://github.com/nvim-treesitter/nvim-treesitter#available-modules
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},

  -- https://github.com/p00f/nvim-ts-rainbow/#installation-and-setup
	rainbow = {
		enable = true,
		extended_mode = false,
	},
})
