vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('nasse-highlight-yank', { clear = true }),
})

vim.api.nvim_create_autocmd('WinNew', {
    callback = function()
        local window = vim.api.nvim_get_current_win()
        local config = vim.api.nvim_win_get_config(window)
        -- Target floating windows like hover and signature help.
        -- I tried checking the buffer name, but it's an empty string,
        -- and the file type is 'markdown', which is too broad.
        if config.relative == 'win' then
            vim.wo.winhighlight = 'NormalFloat:None'
        end
    end,
    group = vim.api.nvim_create_augroup('nasse-floating-window-background-removal', { clear = true }),
})
