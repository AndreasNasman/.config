local set = vim.keymap.set
local builtin = require("telescope.builtin")
set("n", "<Leader>ff", builtin.find_files, { desc = "Search for files (respecting .gitignore)" })
set(
	"n",
	"<Leader>fg",
	builtin.live_grep,
	{ desc = "Search for a string and get results live as you type, respects .gitignore" }
)
set(
	"n",
	"<Leader>fb",
	builtin.buffers,
	{ desc = "Lists open buffers in current neovim instance, opens selected buffer on `<cr>`" }
)
set(
	"n",
	"<Leader>fh",
	builtin.help_tags,
	{ desc = "Lists available help tags and opens a new window with the relevant help info on `<cr>`" }
)

require("telescope").setup({
	defaults = {
		-- https://github.com/nvim-telescope/telescope.nvim#layout-display
		layout_config = {
			horizontal = { height = 0.95, width = 0.95 },
		},
		-- `help telescope.defaults.history`
		mappings = {
			i = {
				["<C-Down>"] = require("telescope.actions").cycle_history_next,
				["<C-Up>"] = require("telescope.actions").cycle_history_prev,
			},
		},
	},
})
