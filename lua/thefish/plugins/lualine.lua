return {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
        sections = {
            lualine_c = {
                {
                    'filename',
                    path = 1,
                    file_status = true,
                },
            },
        },
    },
}
