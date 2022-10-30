require("nasse.options")
require("nasse.keymaps")
require("nasse.plugins")
require("nasse.colorscheme")
require("nasse.cmp")
require("nasse.commands")

-- Highlight on yank.
-- `:h lua-highlight`
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])
