vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('nasse-highlight-yank', { clear = true }),
})

-- https://github.com/stevearc/oil.nvim/issues/234
vim.api.nvim_create_autocmd('BufWinLeave', {
    callback = function()
        vim.cmd.cd('.')
    end,
    group = vim.api.nvim_create_augroup('nasse-relative-path-fix', { clear = true }),
    pattern = { 'oil:///*', 'NvimTree*' },
})
