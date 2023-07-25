Rtdir = vim.fn.stdpath('config')
vim.wo.number = true

vim.opt.undodir = Rtdir .. "/undo"
vim.opt.backupdir = Rtdir .. "/backup"
vim.opt.directory = Rtdir .. "/swap"

-- make sure neovim install is portable
local old_stdpath = vim.fn.stdpath
vim.fn.stdpath = function(value)
    if value == "data" then
        return Rtdir .. "/data"
    end
    return old_stdpath(value)
end

vim.bo.undofile = true
vim.g.mapleader = " "

-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazyOpts = {
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    defaults = {
        -- lazy = false, -- should plugins be lazy-loaded?
        version = nil,
        -- default `cond` you can use to globally disable a lot of plugins
        -- when running inside vscode for example
        cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    }
}

local function nvimtree_on_attach(bufnr)
    print("reconfiuring nvim-tree")
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
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
    end, opts('Find files containing textin folder'))
end

local plugins = {
    --whichkey
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        keys = {
            { "<F7>", ":NvimTreeToggle<CR>", "Toggle tree view" }
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        init = function()
            print("nvim-tree init")

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
                    --    dotfiles = true,
                },
                update_focused_file = {
                    enable = true,
                },
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- autocompletion and stuff
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        init = function()
            require 'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "go",
                    "gomod",
                    "gosum",
                    "haskell_persistent",
                    "html",
                    "javascript",
                    "json",
                    "php",
                    "python",
                    "rust",
                    "sql",
                    "typescript"
                },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                -- List of parsers to ignore installing (for "all")
                -- ignore_install = { "javascript" },

                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = {
                    enable = true,

                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    -- disable = { "c", "rust" },
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
    {
        'nvim-treesitter/playground',
        event = "VeryLazy",
    },
    {

    },
    -- lsp
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    { "rcarriga/nvim-notify" },
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    {
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
    },
    {
        'leoluz/nvim-dap-go',
        dependencies = { 'mfussenegger/nvim-dap' }
    },

    -- colorschemes
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        event = "VeryLazy",
    },
    { 'tomasiser/vim-code-dark' },
    {
        "folke/tokyonight.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = {},
    },
    {
        'tanvirtin/monokai.nvim',
        event = "VeryLazy",
    },
    {
        'projekt0n/github-nvim-theme',
        event = "VeryLazy",
    },
    {
        'mhartington/oceanic-next',
        event = "VeryLazy",
    },
    {
        'jacoborus/tender.vim',
        event = "VeryLazy",
    },
    {
        'lunacookies/vim-substrata',
        event="VeryLazy",
    },

    -- helpful tricks
    -- todo comments
    {
        'folke/todo-comments.nvim',
        event = "BufRead",
        config = function() require('todo-comments').setup() end,
    },
    -- save and load sessions
    {
        'folke/persistence.nvim',
        event = "BufReadPre",
        config = function()
            require('persistence').setup({
                dir = vim.fn.expand(Rtdir .. '/sessions/'),
                options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
            })
        end,
    },
    -- modern statusline
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
}

--  TODO   check it twice

require("lazy").setup(plugins, lazyOpts)

-- debugging

require("thefish.debugging")

-- remaps

local mappings = {
    ["<leader>"] = {
        p = {
            name = "+project",
            f = { "<cmd>Telescope find_files<cr>", "Find files" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
            s = { function()
                require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
            end, "Project search for word" },
            g = {
                name = "git",
                g = { "<cmd>Telescope git_files<cr>", "Git files find" },
                c = { function()
                    require('thefish.changed-on-branch')(Rtdir)
                end, "Files changed on branch" },
            },

        },
        w = {
            name = "+word",
            c = { "viwu~W", "Capitalize" },
            l = { "viwuW", "lowercase" },
            u = { "viwUW", "UPPERCASE" },
            s = { function()
                require('telescope.builtin').grep_string()
            end, "Search in project" },
        },
        g = {
            name = "+introspection",
            D = { function() require('lsp').buf.declaration() end, "Go to declaration" },
            d = { function() require('telescope.builtin').lsp_definitions() end, "Go to definition" },
            i = { function() require('telescope.builtin').lsp_implementations() end, "Go to implementation" },
            o = { function() require('telescope.builtin').lsp_type_definitions() end, "Go to type definitions" },
            r = { function() require('telescope.builtin').lsp_references() end, "Go to references" },
            f = { function() vim.lsp.buf.format({ async = true }) end, "Reformat code" },
            a = { function() vim.lsp.buf.code_action() end, "Code action" },
            n = { function() vim.lsp.buf.rename() end, "Rename symbol" },

            k = { function() vim.lsp.buf.hover() end, "Hover help" },
            K = { function() vim.lsp.buf.signature_help() end, "Signature help" },

        },
        d = {
            name = 'debug',
            s = { function()
                require('dap').continue()
                require('dapui').open({})
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
            end, "Start debugging session" },
            t = { function()
                if (vim.bo.filetype == 'go') then
                    require('dap-go').debug_test()
                else
                    require('dap').debug_test()
                end
                require('dapui').open({})
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
            end, "Debug single test" },
            l = { function() require('dap-go').debug_last_test() end, "debug last test" },
            v = { function() require('dap.ui.widgets').hover() end, "Inspect in-place" },
            b = { function() require('dap').toggle_breakpoint() end, "Breakpoint toggle" },
            n = { function() require('dap').step_over() end, "Step over" },
            i = { function() require('dap').step_into() end, "Step into" },
            o = { function() require('dap').step_out() end, "Step out" },
            C = { function()
                require('dap').clear_breakpoints()
                require('notify')("Breakpoints cleared", "warn")
            end, "Breakpoints clear" },
            e = { function()
                require('dapui').close({})
                require('dap').terminate()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
                require("notify")("Debugger session ended", "warn")
            end, "Stop debugging" }
        },
        q = {
            name = 'sessions',
            s = { function() require('persistence').load() end, 'Load session for current working dir' },
            l = { function() require('persistence').load({ last = true }) end, 'Restore last session' },
            d = { function() require('persistence').stop() end, 'Do not save session on exit' },
            t = { function() require('telescope.builtin').colorscheme({enable_preview=true}) end, 'Change theme'}
        },

    },

    ["gr"] = { function() require('telescope.builtin').lsp_references() end, "Find references" },
    ["gD"] = { function() require('lsp').buf.declaration() end, "Go to declaration" },
    ["gd"] = { function() require('telescope.builtin').lsp_definitions() end, "Go to definition" },
    ["gi"] = { function() require('telescope.builtin').lsp_implementations() end, "Go to implementation" },
    ["go"] = { function() require('telescope.builtin').lsp_type_definitions() end, "Go to type definitions" },
    ["[d"] = { function() vim.diagnostic.goto_next() end, "Diag next" },
    ["]d"] = { function() vim.diagnostic.goto_prev() end, "Diag prev" },
    ["<C-b>"] = { function() require('dap').toggle_breakpoint() end, "Breakpoint toggle" },

}
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

local wk = require("which-key")

wk.register(
    {
        ["<C-z>"] = { "u<cr>", "Undo on ctrl+z" },
        ["<F2>"] = { "<cmd>w<cr>", "Save file" },
        ["<C-p>"] = { ":set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJx:set nopaste<CR>", "copy to system clipoard" },
        ["<Esc><Esc>"] = { "<Esc>:nohl<CR>", "double escape to disable highlight" },
        -- set moving between windows to ctrl+arrows
        ["<C-Right>"] = { "<c-w>l", "" },
        ["<C-Left>"] = { "<c-w>h", "" },
        ["<C-Up>"] = { "<c-w>k", "" },
        ["<C-Down>"] = { "<c-w>j", "" },
        -- set moving between windows to ctrl+hjkl
        ["<C-l>"] = { "<c-w>l", "" },
        ["<C-h>"] = { "<c-w>h", "" },
        ["<C-k>"] = { "<c-w>k", "" },
        ["<C-j>"] = { "<c-w>j", "" },


    },
    { mode = "n", noremap = true }
)
wk.register(
    {
        ["jh"] = { "<esc>", "exit visual mode on fast jh" },
        ["<c-d>"] = { "<esc>yypi", "duplicate line" },
        ["<C-z>"] = { "<Esc>u<cr>v", "Undo on ctrl+z" },
        ["<F2>"] = { "<esc><cmd>w<cr>v", "Save file" },
        ["<C-y>"] = { ":<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u", "paste from system clipboard" },
    },
    { mode = "v", noremap = true }
)
wk.register(
    {
        ["<C-z>"] = { "<Esc>u<cr>i", "Undo on ctrl+z" },
        ["jh"] = { "<esc>", "exit insert mode on fast jh" },
        ["<c-d>"] = { "<esc>yyp", "duplicate line" },
        ["<F2>"] = { "<esc><cmd>w<cr>i", "Save file" },
    },
    { mode = "i", noremap = true }
)

wk.register(mappings, wkOpts)

local set = vim.opt  --set options
set.tabstop = 4      -- Force tabs to be displayed/expanded to 2 spaces (instead of default 8).
set.softtabstop = 4  -- Make Vim treat <Tab> key as 4 spaces, but respect hard Tabs.
-- I don't think this one will do what you want.
set.expandtab = true -- Turn Tab keypresses into spaces.  Sounds like this is happening to you.
-- You can still insert real Tabs as [Ctrl]-V [Tab].
set.shiftwidth = 4   -- When auto-indenting, indent by this much.
-- (Use spaces/tabs per "expandtab".)
vim.cmd('retab')     -- Change all the existing tab characters to match the current tab settings
-- scroloff
set.scrolloff = 8

-- small nuances

-- delete trailing white spaces except for markdown
function DeleteTrailingWS()
    if (vim.bo.filetype == 'markdown') then
        return
    end
    vim.api.nvim_command([[normal mz]])
    vim.cmd([[%s/\s\+$//ge]])
    vim.api.nvim_command([[normal 'z]])
end

vim.api.nvim_create_autocmd('BufWritePre', { callback = DeleteTrailingWS })


-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', { pattern = "*", command = "silent! normal! g;" })

-- disable mouse
vim.opt.mouse = nil
