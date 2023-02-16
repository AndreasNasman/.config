-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/wbthomason/packer.nvim#quickstart
--vim.api.nvim_create_autocmd("BufWritePost", {
--command = "source <afile> | PackerSync", -- `PackerSync` fits my use cases better than `PackerCompile`.
--group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
--pattern = vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua/nasse/packer.lua", -- https://github.com/neovim/neovim/issues/17744
--})

require("lazy").setup({
	-- Annotation
	{
		"danymat/neogen", -- A better annotation generator. Supports multiple languages and annotation conventions.
		config = true,
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	-- Comments
	"tpope/vim-commentary", -- commentary.vim: comment stuff out

	-- Completion
	"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
	"hrsh7th/cmp-cmdline", -- nvim-cmp source for vim's cmdline
	"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
	"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
	"hrsh7th/cmp-path", -- nvim-cmp source for path
	"hrsh7th/nvim-cmp", -- A completion plugin for neovim coded in Lua.

	-- Dependencies
	"nvim-lua/plenary.nvim", -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.

	-- Git
	{
		"lewis6991/gitsigns.nvim", -- Git integration for buffers
		config = true,
	},
	"tpope/vim-fugitive", -- fugitive.vim: A Git wrapper so awesome, it should be illegal
	"tpope/vim-rhubarb", -- rhubarb.vim: GitHub extension for fugitive.vim

	-- History
	"mbbill/undotree", -- The undo history visualizer for VIM

	-- LSP
	{
		"j-hui/fidget.nvim", -- Standalone UI for nvim-lsp progress
		opts = {
			window = {
				blend = 0,
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"neovim/nvim-lspconfig", -- Quickstart configs for Nvim LSP
	{
		"RubixDev/mason-update-all", -- Easily update all Mason packages with one command
		config = true,
	},
	"williamboman/mason-lspconfig.nvim", -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
	"williamboman/mason.nvim", -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Install and upgrade third party tools automatically
		opts = {
			ensure_installed = { "eslint_d", "luacheck", "prettierd", "stylua" },
		},
	},

	-- Snippets
	"L3MON4D3/LuaSnip", -- Snippet Engine for Neovim written in Lua.
	"rafamadriz/friendly-snippets", -- Set of preconfigured snippets for different languages.
	"saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp

	-- Telescope
	{
		"nvim-telescope/telescope.nvim", -- Find, Filter, Preview, Pick. All lua, all the time.
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Text objects
	{
		"kana/vim-textobj-entire", -- Vim plugin: Text objects for entire buffer
		dependencies = { "kana/vim-textobj-user" },
	},
	"kana/vim-textobj-user", -- Vim plugin: Create your own text objects

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter", -- Nvim Treesitter configurations and abstraction layer
		build = ":TSUpdate",
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		opts = {
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
		},
	},
	"p00f/nvim-ts-rainbow", -- Rainbow parentheses for neovim using tree-sitter. Use https://sr.ht/~p00f/nvim-ts-rainbow instead

	-- UI & DX
	{
		"folke/tokyonight.nvim", -- 🏙️ A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
		-- https://github.com/folke/lazy.nvim#-colorschemes
		config = function(_, opts)
			--- `setup` should be run before loading the color scheme.
			--- https://github.com/folke/tokyonight.nvim/issues/190#issuecomment-1237641162
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
		lazy = false, -- Load this during startup since it's the main color scheme.
		opts = {
			style = "moon",
		},
		priority = 1000, -- Load this before all the other start plugins.
	},
	"folke/zen-mode.nvim", -- 🧘 Distraction-free coding for Neovim
	{
		"lukas-reineke/indent-blankline.nvim", -- Indent guides for Neovim
		opts = {
			show_current_context = true,
			show_current_context_start = true,
		},
	},
	"nvim-tree/nvim-web-devicons", -- lua `fork` of vim-web-devicons for neovim
	"tpope/vim-repeat", -- repeat.vim: enable repeating supported plugin maps with "."
	"tpope/vim-surround", -- surround.vim: quoting/parenthesizing made simple
	"tpope/vim-unimpaired", -- unimpaired.vim: Pairs of handy bracket mappings

	-- Utility
	"arthurxavierx/vim-caser", -- Easily change word casing with motions, text objects or visual mode.
	"romainl/vim-cool", -- A very simple plugin that makes hlsearch more useful.
	"tommcdo/vim-exchange", -- Easy text exchange operator for Vim
	{
		"windwp/nvim-autopairs", -- autopairs for neovim written by lua
		config = function(_, opts)
			-- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			require("nvim-autopairs").setup(opts)
		end,
		opts = {
			check_ts = true,
		},
	},

	-- Miscellaneous
	{
		"glacambre/firenvim",
		config = function()
			vim.fn["firenvim#install"](0)
		end,

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		-- cond = not not vim.g.started_by_firenvim,
	},
})
