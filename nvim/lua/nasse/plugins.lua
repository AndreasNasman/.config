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

-- Helper functions for large files.

-- https://github.com/nvim-treesitter/nvim-treesitter#modules
local disable = function(_, buf)
	local max_filesize = 1000 * 1024 -- 1 MB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

-- https://github.com/nvim-telescope/telescope.nvim/issues/857#issuecomment-846368690
local buffer_previewer_maker = function(filepath, bufnr, opts)
	opts = opts or {}
	if opts.use_ft_detect == nil then
		local ft = require("plenary.filetype").detect(filepath)
		opts.use_ft_detect = false
		require("telescope.previewers.utils").regex_highlighter(bufnr, ft)
	end
	require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
end

require("lazy").setup({
	-- Commenting
	{
		"danymat/neogen", -- A better annotation generator. Supports multiple languages and annotation conventions.
		config = true,
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	"tpope/vim-commentary", -- commentary.vim: comment stuff out

	-- Completion
	"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
	"hrsh7th/cmp-cmdline", -- nvim-cmp source for vim's cmdline
	"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
	"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
	"hrsh7th/cmp-path", -- nvim-cmp source for path
	"hrsh7th/nvim-cmp", -- A completion plugin for neovim coded in Lua.

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
				buffer_previewer_maker = buffer_previewer_maker,
				-- https://github.com/nvim-telescope/telescope.nvim#layout-display
				layout_config = {
					vertical = { height = 0.99, width = 0.99 },
				},
				layout_strategy = "vertical",
			},
			pickers = {
				quickfix = {
					show_line = false,
				},
				lsp_references = {
					show_line = false,
				},
			},
		},
	},

	-- Text objects
	{
		"kana/vim-textobj-entire", -- Vim plugin: Text objects for entire buffer
		dependencies = { "kana/vim-textobj-user" },
	},

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
				disable = disable,
				enable = true,
			},
			indent = {
				disable = disable,
				enable = true,
			},
			-- https://gitlab.com/HiPhish/nvim-ts-rainbow2
			rainbow = {
				disable = disable,
				enable = true,
			},
		},
	},
	{
		"HiPhish/nvim-ts-rainbow2", -- Rainbow delimiters for Neovim through Tree-sitter
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	-- UI
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
			styles = {
				floats = "transparent",
				sidebars = "transparent",
			},
			transparent = true,
		},
		priority = 1000, -- Load this before all the other start plugins.
	},
	{
		"nvim-lualine/lualine.nvim",
		config = true,
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	"nvim-tree/nvim-web-devicons", -- lua `fork` of vim-web-devicons for neovim

	-- Utility & DX
	"arthurxavierx/vim-caser", -- Easily change word casing with motions, text objects or visual mode.
	{
		"zbirenbaum/copilot-cmp", -- Lua plugin to turn github copilot into a cmp source
		config = true,
		dependencies = "copilot.lua",
	},
	"romainl/vim-cool", -- A very simple plugin that makes hlsearch more useful.
	"tpope/vim-repeat", -- repeat.vim: enable repeating supported plugin maps with "."
	"tpope/vim-surround", -- surround.vim: quoting/parenthesizing made simple
	"tpope/vim-unimpaired", -- unimpaired.vim: Pairs of handy bracket mappings
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

	-- Dependencies
	"kana/vim-textobj-user", -- Vim plugin: Create your own text objects
	"nvim-lua/plenary.nvim", -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
	{
		"zbirenbaum/copilot.lua", -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
		-- https://github.com/zbirenbaum/copilot-cmp#install
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = false,
			},
		},
	},
}, {
	ui = {
		border = "rounded",
	},
})
