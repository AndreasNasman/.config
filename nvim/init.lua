require('options')
require('keymaps')
require('autocommands')
require('user-commands')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    install = { colorscheme = { 'tokyonight' } },
    performance = {
        rtp = {
            disabled_plugins = {
                'editorconfig',
                'gzip',
                'man',
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
})
