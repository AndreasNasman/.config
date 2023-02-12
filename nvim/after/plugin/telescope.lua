local builtin = require("telescope.builtin")

local set = vim.keymap.set

-- stylua: ignore start
set("n", "<Leader>fb", builtin.buffers, { desc = "Lists open buffers in current neovim instance, opens selected buffer on `<cr>`" })
set("n", "<Leader>fd", builtin.lsp_document_symbols, { desc = "Lists git status for current directory" })
set("n", "<Leader>ff", builtin.find_files, { desc = "Search for files (respecting .gitignore)" })
set("n", "<Leader>fg", builtin.git_status, { desc = "Lists git status for current directory" })
set("n", "<Leader>fh", builtin.help_tags, { desc = "Lists available help tags and opens a new window with the relevant help info on `<cr>`" })
set("n", "<Leader>fm", builtin.man_pages, { desc = "Lists manpage entries, opens them in a help window on `<cr>`" })
set("n", "<Leader>fo", builtin.oldfiles, { desc = "Lists previously open files, opens on `<cr>`" })
set("n", "<Leader>fs", builtin.live_grep, { desc = "Search for a string and get results live as you type, respects .gitignore" })
-- stylua: ignore end

-- https://github.com/nvim-telescope/telescope.nvim/issues/2041
local pickers = {}
for b, _ in pairs(builtin) do
	pickers[b] = { fname_width = 101 }
end

require("telescope").setup({
	defaults = {
		-- https://github.com/nvim-telescope/telescope.nvim#layout-display
		layout_config = {
			vertical = { height = 0.95, width = 0.95 },
		},
		layout_strategy = "vertical",

		-- `help telescope.defaults.history`
		mappings = {
			i = {
				["<C-Down>"] = require("telescope.actions").cycle_history_next,
				["<C-Up>"] = require("telescope.actions").cycle_history_prev,
			},
		},
	},
	pickers = pickers,
})
