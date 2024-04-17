local lsp = require('lsp-zero')

-- NO lsp.preset('recommended') TO AVOID RUINING KEYBINDINGS
lsp.preset({
    name = 'recommended',
    preserve_mappings = true,
    set_lsp_keymaps = {
        omit = {
            "<F2>",
            "gd",
            "gr",
        },
    },
})


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local luasnip = require('luasnip')

cmp.setup({
        --     completion = {
        --         autocomplete = false,
        --     },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }),
            -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<Tab>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),

        }),
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            {name = 'nvim_lsp'},
            {name = 'luasnip'},
            {name = 'buffer'},
            {name = 'path'},
        }),
    })

    lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
            error = 'E',
            warn = 'W',
            hint = 'H',
            info = 'I'
        }
    })

    lsp.setup()
