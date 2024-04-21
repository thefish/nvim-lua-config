local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    search = {
        command = "rg",
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    }
}


return {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    event = 'VimEnter',
    opts = opts,
    config = function()
        require('todo-comments').setup(opts)
    end,
}
