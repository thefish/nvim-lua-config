SqlConnections = {}

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/nvim-cmp' },     -- Required
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
        },                        -- Required
        { 'hrsh7th/cmp-buffer' }, -- Optional, same buffer completion
        { 'hrsh7th/cmp-path' },   -- Optional, file system path completion
        -- { 'hrsh7th/cmp-cmdline' },  -- Optional, command line completion
    },
    init = function()
        local lsp_zero = require('lsp-zero')
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'bashls',
                'bufls',
                'cssls',
                'dockerls',
                'golangci_lint_ls',
                'gopls',
                'graphql',
                'jsonls',
                'lua_ls',
                'pyright',
                'rust_analyzer',
                'vimls',
                'yamlls',
                'phpactor',
            },
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
