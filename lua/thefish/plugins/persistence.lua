-- save and load sessions
return {
    'folke/persistence.nvim',
    event = "BufReadPre",
    config = function()
        require('persistence').setup({
            dir = vim.fn.expand(Rtdir .. '/sessions/'),
            options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
        })
    end,
}
