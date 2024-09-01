vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('nasse-highlight-yank', { clear = true }),
})
