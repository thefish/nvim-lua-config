local function nvimtree_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- Vertical split on s
    vim.keymap.del('n', '<C-v>', { buffer = bufnr })
    vim.keymap.del('n', 's', { buffer = bufnr })
    vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))

    local ntfns = require('thefish.nvim-tree')

    vim.keymap.set('n', '<C-f>', function()
        local node = require('nvim-tree.api').tree.get_node_under_cursor()
        if not node then return end
        ntfns.grep_folder(node.absolute_path)
    end, opts('Search for text in folder'))

    vim.keymap.set('n', '<C-a>', function()
        local node = require('nvim-tree.api').tree.get_node_under_cursor()
        if not node then return end
        ntfns.git_add_path(node.absolute_path)
    end, opts('Git add path'))

    vim.keymap.set('n', '<C-x>', function()
        local node = require('nvim-tree.api').tree.get_node_under_cursor()
        if not node then return end
        ntfns.git_rm_path(node.absolute_path)
    end, opts('Git rm path (cached)'))

    vim.keymap.set('n', 't', function()
        local node = require('nvim-tree.api').tree.get_node_under_cursor()
        if not node then return end
        vim.cmd(':tabedit ' .. node.absolute_path)
    end, opts('New tab edit'))

end

return {
    'nvim-tree/nvim-tree.lua',
    keys = {
        { "<F7>", ":NvimTreeToggle<CR>", "Toggle tree view" }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    init = function()
        require('nvim-tree').setup({
            on_attach = nvimtree_on_attach,
            sort_by = "case_sensitive",
            view = {
                width = 50,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                git_ignored = false,
                --    dotfiles = true,
            },
            update_focused_file = {
                enable = true,
            },
        })
    end
}
