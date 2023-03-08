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
		"nvim-telescope/telescope-fzf-native.nvim", -- 💤 A modern plugin manager for Neovim
		build = "make",
	},
	{
		"nvim-telescope/telescope.nvim", -- Find, Filter, Preview, Pick. All lua, all the time.
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			require("telescope").load_extension("fzf")
			require("telescope").setup(vim.tbl_deep_extend("force", opts, {
				defaults = {
					-- `help telescope.defaults.history`
					mappings = {
						i = {
							["<C-Down>"] = require("telescope.actions").cycle_history_next,
							["<C-Up>"] = require("telescope.actions").cycle_history_prev,
						},
					},
				},
			}))
		end,
		opts = {
			defaults = {
				-- https://github.com/nvim-telescope/telescope.nvim#layout-display
				layout_config = {
					horizontal = { height = 0.99, width = 0.99 },
				},
			},
		},
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
		"Mofiqul/dracula.nvim", -- Dracula colorscheme for neovim written in Lua
		-- https://github.com/folke/lazy.nvim#-colorschemes
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
		lazy = false, -- Load this during startup since it's the main color scheme.
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
})
