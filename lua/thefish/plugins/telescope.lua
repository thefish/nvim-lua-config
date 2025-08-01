return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.*',
    -- or                              , branch = '0.1.x',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        defaults = {
            path_display = { "smart" }, -- find files easier
        }
    }
}
