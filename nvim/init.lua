require('options')
require('keymaps')
require('autocommands')
require('user-commands')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    defaults = {
        lazy = true,
    },
    install = { colorscheme = { 'catppuccin' } },
    performance = {
        rtp = {
            disabled_plugins = {
                'editorconfig',
                'gzip',
                -- 'man',
                -- 'matchit',
                -- 'matchparen',
                'netrwPlugin',
                'osc52',
                'rplugin',
                'shada',
                'spellfile',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    ui = {
        backdrop = 100,
        border = 'rounded',
    },
})
