-- remaps

return
--normal-mode-stuff
{
    ["<leader>"] = {
        p = {
            name = "project",
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
                D = { "<cmd>DiffviewOpen origin/master..HEAD<cr>","Show diffview to origin/master"},
                m = { "<cmd>Telescope git_commits<cr>", "Commits" },
                s = { "<cmd>Telescope git_status<cr>", "Status" },
                t = { "<cmd>Telescope git_stash<cr>", "Stash" },
                b = { "<cmd>Telescope git_bcommits<cr>", "Commits for curren buffer" },
                l = { "<cmd>Telescope git_bcommits_range<cr>", "Commits for curren buffer" },
            },
            t = { "<cmd>TodoTelescope<cr>", "List TODO, FIXME and such stuff" },

        },
        w = {
            name = "word",
            c = { "viwu~W", "Capitalize" },
            l = { "viwuW", "lowercase" },
            u = { "viwUW", "UPPERCASE" },
            s = { function()
                require('telescope.builtin').grep_string()
            end, "Search in project" },
        },

        h = {
            name = "git ops",
            s = { function() require('gitsigns').stage_hunk() end, "Stage hunk" },
            r = { function() require('gitsigns').reset_hunk() end, "Reset hunk" },
            S = { function() require('gitsigns').stage_buffer() end, "Stage buffer" },
            u = { function() require('gitsigns').undo_stage_hunk() end, "Undo stage hunk" },
            U = { function() require('gitsigns').undo_stage_buffer() end, "Undo stage " },
            R = { function() require('gitsigns').reset_buffer() end, "Reset buffer" },
            p = { function() require('gitsigns').preview_hunk() end, "Preview hunk" },
            b = { function() require('gitsigns').blame_line({ full = true }) end, "Blame line" },
            d = { function() require('gitsigns').diffthis() end, "Diff this" },
            D = { function() require('gitsigns').diffthis('~') end, "Diff this" },
            v = {
                -- function()
                    -- local branch = os.getenv("PROJECT_MAIN_BRANCH") or "master"
                    -- return "<Esc>:DiffviewOpen origin/" .. branch .. "... --imply-local<cr>" end, "DiffView this"
                    "<Esc>:DiffviewOpen origin/master... --imply-local<cr>", "DiffView this"
                }
            },

            t = {
                name = "Toggles",
                b = { function() require('gitsigns').toggle_current_line_blame() end, "Current line blame" },
                d = { function() require('gitsigns').toggle_deleted() end, "deleted" },
            },

            g = {
                name = "introspection",
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
                t = { function() require('telescope.builtin').colorscheme({ enable_preview = true }) end, 'Change theme' }
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

        [']c'] = { function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() require('gitsigns').next_hunk() end)
            return '<Ignore>'
        end, 'Next hunk' },
        ['[c'] = { function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() require('gitsigns').prev_hunk() end)
            return '<Ignore>'
        end, "Prev hunk" },

        {
            -- Common stuff
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
            ["<C-l>"] = { "<c-w>l", "Switch window right" },
            ["<C-h>"] = { "<c-w>h", "Switch window left" },
            ["<C-k>"] = { "<c-w>k", "Switch window up" },
            ["<C-j>"] = { "<c-w>j", "Switch window down" },

            --center on Ctrl+d and Ctrl+u
            ["<C-d>"] = { "<c-d>zz", "Move half page down and center" },
            ["<C-u>"] = { "<c-u>zz", "Move half page down and center" },


        },
    },
    -- visual mode stuff
    {
        ["jh"] = { "<esc>", "exit visual mode on fast jh" },
        -- yyp instead of that akshually
        -- ["<c-d>"] = { "<esc>yypi", "duplicate line" },
        ["<C-z>"] = { "<Esc>u<cr>v", "Undo on ctrl+z" },
        ["<F2>"] = { "<esc><cmd>w<cr>v", "Save file" },
        ["<C-y>"] = { ":<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u", "paste from system clipboard" },
        ["<C-l>"] = { "<cmd>Telescope git_bcommits<cr>", "Commits for selected lines" },

        ["<leader>"] = {
            h = {
                name = "git ops",
                s = { function() require('gitsigns').stage_hunk() { vim.fn.line('.'), vim.fn.line('v') } end,
                "stage selected" },
                r = { function() require('gitsigns').reset_hunk() { vim.fn.line('.'), vim.fn.line('v') } end,
                "reset selected" },
            },
        },
    },
    -- insert mode stuff
    {
        ["<C-z>"] = { "<Esc>u<cr>i", "Undo on ctrl+z" },
        ["jj"] = { "<esc>", "exit insert mode on fast jj" },
        ["<c-d>"] = { "<esc>yyp", "duplicate line" },
        ["<F2>"] = { "<esc><cmd>w<cr>i", "Save file" },
    }
