-- Borders
-- Targets all LSP handlers, like hover and signature help.
local handlers = vim.lsp.handlers
for name, handler in pairs(handlers) do
    if type(handler) == 'function' then
        handlers[name] = vim.lsp.with(handler, {
            border = 'rounded',
        })
    end
end

-- Completion
vim.opt.completeopt = 'menu,menuone,noselect'

-- Cursor
vim.opt.cursorline = true
vim.opt.guicursor:append('a:blinkon100')
vim.opt.updatetime = 250 -- Speed up "highlight under cursor".

-- Diagnostics
vim.diagnostic.config({
    float = {
        border = 'rounded',
        source = true,
    },
})

-- History
vim.opt.undofile = true

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Plugin requisites
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'

-- Search & Replace
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.smartcase = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Text
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.listchars = { nbsp = '', tab = '󰌒 ', trail = '󱁐' }
