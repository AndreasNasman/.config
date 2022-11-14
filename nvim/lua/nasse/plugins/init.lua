-- https://github.com/wbthomason/packer.nvim#quickstart
-- `PackerSync` fits my use cases better than `PackerCompile`.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost $XDG_CONFIG_HOME/nvim/lua/nasse/plugins/init.lua source <afile> | PackerSync
  augroup end
]])

require("packer").startup({
	function(use)
		-- Packer
		use("wbthomason/packer.nvim") -- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config.

		-- Color scheme
		use("folke/tokyonight.nvim") -- 🏙️ A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.

		-- Completion & Snippets
		use({
			"hrsh7th/cmp-buffer", --  nvim-cmp source for buffer words
			"hrsh7th/cmp-cmdline", --  nvim-cmp source for vim's cmdline
			"hrsh7th/cmp-nvim-lsp", --  nvim-cmp source for neovim builtin LSP client
			"hrsh7th/cmp-path", --  nvim-cmp source for path
			"hrsh7th/nvim-cmp", -- A completion plugin for neovim coded in Lua.
		})
		use({
			"L3MON4D3/LuaSnip", --  Snippet Engine for Neovim written in Lua.
			"rafamadriz/friendly-snippets", --  Set of preconfigured snippets for different languages.
			"saadparwaiz1/cmp_luasnip", --  luasnip completion source for nvim-cmp
		})

		-- LSP
		use({
			"neovim/nvim-lspconfig", --  Quickstart configs for Nvim LSP
			"williamboman/mason-lspconfig.nvim", --  Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
			"williamboman/mason.nvim", --  Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
		})

		-- Text objects
		use({
			"kana/vim-textobj-entire", -- Vim plugin: Text objects for entire buffer
			"kana/vim-textobj-user", -- Vim plugin: Create your own text objects
		})

		-- Tim Pope
		use({
			"tpope/vim-commentary", -- commentary.vim: comment stuff out
			"tpope/vim-fugitive", -- fugitive.vim: A Git wrapper so awesome, it should be illegal
			"tpope/vim-repeat", -- repeat.vim: enable repeating supported plugin maps with "."
			"tpope/vim-surround", -- surround.vim: quoting/parenthesizing made simple
			"tpope/vim-unimpaired", -- unimpaired.vim: Pairs of handy bracket mappings
		})

		-- Utility
		use("arthurxavierx/vim-caser") --  Easily change word casing with motions, text objects or visual mode.
		use("romainl/vim-cool") -- A very simple plugin that makes hlsearch more useful.

		-- Miscellaneous
		use({
			"glacambre/firenvim", -- Embed Neovim in Chrome, Firefox, Thunderbird and many other pieces of software.
			run = function()
				vim.fn["firenvim#install"](0)
			end,
		})
	end,

	-- https://github.com/wbthomason/packer.nvim#using-a-floating-window
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})

require("nasse.plugins.firenvim")
require("nasse.plugins.fugitive")
