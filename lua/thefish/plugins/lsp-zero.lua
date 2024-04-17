return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        { 'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required
    },
    init = function ()
        local lsp_zero = require('lsp-zero')
        require('mason').setup({})
        require('mason-lspconfig').setup({
            handlers = {
                -- this first function is the "default handler"
                -- it applies to every language server without a "custom handler"
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,

                -- this is the "custom handler" for `lua_ls`
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            },
        })
    end,
}
