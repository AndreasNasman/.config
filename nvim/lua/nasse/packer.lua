-- https://github.com/wbthomason/packer.nvim#quickstart
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerSync", -- `PackerSync` fits my use cases better than `PackerCompile`.
	group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
	pattern = vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua/nasse/packer.lua", -- https://github.com/neovim/neovim/issues/17744
})

require("packer").startup({
	function(use)
		use({
			-- Packer
			"wbthomason/packer.nvim", -- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config.

			-- Annotation
			{
				"danymat/neogen", -- A better annotation generator. Supports multiple languages and annotation conventions.
				requires = "nvim-treesitter/nvim-treesitter",
			},

			-- Completion
			"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
			"hrsh7th/cmp-cmdline", -- nvim-cmp source for vim's cmdline
			"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
			"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
			"hrsh7th/cmp-path", -- nvim-cmp source for path
			"hrsh7th/nvim-cmp", -- A completion plugin for neovim coded in Lua.

			-- LSP
			{
				"jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
				requires = { "nvim-lua/plenary.nvim" }, -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
			},
			"neovim/nvim-lspconfig", -- Quickstart configs for Nvim LSP
			"williamboman/mason-lspconfig.nvim", -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
			"williamboman/mason.nvim", -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.

			-- Snippets
			"L3MON4D3/LuaSnip", -- Snippet Engine for Neovim written in Lua.
			"rafamadriz/friendly-snippets", -- Set of preconfigured snippets for different languages.
			"saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp

			-- Telescope
			{
				"nvim-telescope/telescope.nvim", -- Find, Filter, Preview, Pick. All lua, all the time.
				requires = { "nvim-lua/plenary.nvim" }, -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
			},

			-- Text objects
			"kana/vim-textobj-entire", -- Vim plugin: Text objects for entire buffer
			"kana/vim-textobj-user", -- Vim plugin: Create your own text objects

			-- Tim Pope
			"tpope/vim-commentary", -- commentary.vim: comment stuff out
			"tpope/vim-fugitive", -- fugitive.vim: A Git wrapper so awesome, it should be illegal
			"tpope/vim-repeat", -- repeat.vim: enable repeating supported plugin maps with "."
			"tpope/vim-surround", -- surround.vim: quoting/parenthesizing made simple
			"tpope/vim-unimpaired", -- unimpaired.vim: Pairs of handy bracket mappings

			-- Treesitter
			{
				"nvim-treesitter/nvim-treesitter", -- Nvim Treesitter configurations and abstraction layer
				run = ":TSUpdate",
			},
			"p00f/nvim-ts-rainbow", -- Rainbow parentheses for neovim using tree-sitter. Use https://sr.ht/~p00f/nvim-ts-rainbow instead

			-- UI & DX
			"folke/tokyonight.nvim", -- 🏙️ A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
			"folke/zen-mode.nvim", -- 🧘 Distraction-free coding for Neovim
			"lukas-reineke/indent-blankline.nvim", -- Indent guides for Neovim
			"nvim-tree/nvim-web-devicons", -- lua `fork` of vim-web-devicons for neovim

			-- Utility
			"arthurxavierx/vim-caser", -- Easily change word casing with motions, text objects or visual mode.
			"romainl/vim-cool", -- A very simple plugin that makes hlsearch more useful.
			"tommcdo/vim-exchange", -- Easy text exchange operator for Vim
			"windwp/nvim-autopairs", -- autopairs for neovim written by lua

			-- Miscellaneous
			{
				"glacambre/firenvim", -- Embed Neovim in Chrome, Firefox, Thunderbird and many other pieces of software.
				run = function()
					vim.fn["firenvim#install"](0)
				end,
			},
		})
	end,

	-- https://github.com/wbthomason/packer.nvim#using-a-floating-window
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})