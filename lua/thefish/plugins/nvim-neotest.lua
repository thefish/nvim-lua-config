return {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-go",
    },
    init = function()
        require("neotest").setup({
            -- your neotest config here
            adapters = {
                require("neotest-go"),
            },
        })
    end,
}
