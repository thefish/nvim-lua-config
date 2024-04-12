return {
    "folke/which-key.nvim",
    event = "VimEnter",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function ()
        local wk = require('which-key')
        wk.setup()
        local wkOpts = {
            mode = "n", -- NORMAL mode
            -- prefix: use "<leader>f" for example for mapping everything related to finding files
            -- the prefix is prepended to every mapping part of `mappings`
            prefix = "",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = false, -- use `nowait` when creating keymaps
            expr = false,   -- use `expr` when creating keymaps
        }

        local normal, visual, insert = require("thefish.core.wk-key-mappings")

        wk.register(normal, wkOpts)

        wk.register(visual,{ mode = "v", noremap = true })

        wk.register(insert,{ mode = "i", noremap = true })
    end;
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}
