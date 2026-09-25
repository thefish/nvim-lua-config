-- remaps
return function()
	return
	--normal-mode-stuff
	{
		{
			mode = "n",
			{ "<leader>", group = "Leader" },
			{
				"<leader><space>",
				"<cmd>Telescope buffers<cr>",
				desc = "[ ] Find buffers",
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "[/] Fuzzy fin in current file",
			},
			{ "<leader>?", require("telescope.builtin").oldfiles, desc = "[?] Find recently opened files" },

			-- PROJECT GROUP
			{ "<leader>p", group = "project" },
			{
				{ "<leader>pN", "<cmd>Telescope find_files<cr>", desc = "Find files by name" },
				{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files by name" },
				{ "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "buffers" },
				{
					"<leader>ps",
					function()
						require("telescope.builtin").live_grep()
					end,
					desc = "String search",
				},
				{
					"<leader>py",
					function()
						vim.ui.input({ prompt = "search for symbol" }, function(msg)
							require("telescope.builtin").lsp_workspace_symbols({ query = msg })
						end)
					end,
					desc = "Symbol search in workspace",
				},
				{
					"<leader>pu",
					function()
						require("telescope.builtin").treesitter()
					end,
					desc = "Symbol search in current file",
				},
				{
					"<leader>pr",
					function()
						require("telescope.builtin").lsp_references()
					end,
					desc = "Reference search in workspace",
				},

				-- Calls Sub-Group
				{ "<leader>pc", group = "Calls for word under cursor" },
				{
					{
						"<leader>pco",
						function()
							require("telescope.builtin").lsp_outgoing_calls()
						end,
						desc = "Outgoing calls",
					},
					{
						"<leader>pci",
						function()
							require("telescope.builtin").lsp_incoming_calls()
						end,
						desc = "Incoming calls",
					},
				},

				{
					"<leader>pi",
					function()
						require("telescope.builtin").lsp_implementations()
					end,
					desc = "implementations",
				},
				{
					"<leader>pd",
					function()
						require("telescope.builtin").lsp_definitions()
					end,
					desc = "definitions",
				},
				{
					"<leader>pt",
					function()
						require("telescope.builtin").lsp_type_definitions()
					end,
					desc = "type definitions",
				},
				{ "<leader>px", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

				-- Git Sub-Group
				{ "<leader>pg", group = "git" },
				{
					{ "<leader>pgg", "<cmd>Telescope git_files<cr>", desc = "Git files find" },
					{
						"<leader>pgc",
						function()
							require("thefish.changed-on-branch")(Rtdir)
						end,
						desc = "Files changed on branch",
					},
					{
						"<leader>pgD",
						"<cmd>DiffviewOpen origin/master..HEAD<cr>",
						desc = "Show diffview to origin/master",
					},
					{
						"<leader>pgm",
						function()
							require("telescope.builtin").git_commits()
						end,
						desc = "git commits",
					},
					{
						"<leader>pgs",
						function()
							require("thefish.git-status")()
						end,
						desc = "git status",
					},
					{ "<leader>pgt", "<cmd>Telescope git_stash<cr>", desc = "Stash" },
					{
						"<leader>pgb",
						function()
							require("thefish.git-bcommits")()
						end,
						desc = "current buffer commits",
					},
					{
						"<leader>pgr",
						function()
							require("thefish.git-branches")()
						end,
						desc = "branches",
					},
				},
				{ "<leader>pz", "<cmd>TodoTelescope<cr>", desc = "List TODO, FIXME and such stuff" },
			},

			-- WORD GROUP
			{ "<leader>w", group = "word" },
			{
				{ "<leader>wc", "viwu~W", desc = "Capitalize" },
				{ "<leader>wl", "viwuW", desc = "lowercase" },
				{ "<leader>wu", "viwUW", desc = "UPPERCASE" },
				{
					"<leader>ws",
					function()
						require("telescope.builtin").grep_string()
					end,
					desc = "Search in project",
				},
			},

			-- GIT OPS GROUP
			{ "<leader>h", group = "git ops" },
			{
				{
					"<leader>hs",
					function()
						require("gitsigns").stage_buffer()
					end,
					desc = "Stage buffer",
				},
				{
					"<leader>hu",
					function()
						require("gitsigns").undo_stage_buffer()
					end,
					desc = "Undo stage buffr",
				},
				{
					"<leader>hr",
					function()
						require("gitsigns").reset_buffer()
					end,
					desc = "Reset buffer",
				},
				{
					"<leader>hS",
					function()
						require("gitsigns").stage_hunk()
					end,
					desc = "Stage hunk",
				},
				{
					"<leader>hR",
					function()
						require("gitsigns").reset_hunk()
					end,
					desc = "Reset hunk",
				},
				{
					"<leader>hU",
					function()
						require("gitsigns").undo_stage_hunk()
					end,
					desc = "Undo stage hunk",
				},
				{
					"<leader>hP",
					function()
						require("gitsigns").preview_hunk()
					end,
					desc = "Preview hunk",
				},
				{
					"<leader>hb",
					function()
						require("gitsigns").blame_line({ full = true })
					end,
					desc = "Blame line",
				},
				{
					"<leader>hd",
					function()
						require("gitsigns").diffthis()
					end,
					desc = "Diff this",
				},
				{
					"<leader>hD",
					function()
						require("gitsigns").diffthis("~")
					end,
					desc = "Diff this",
				},
				{ "<leader>hv", "<Esc>:DiffviewOpen origin/master... --imply-local<cr>", desc = "DiffView this" },
				{
					"<leader>hc",
					function()
						require("thefish.git-commit-input")()
					end,
					desc = "git commit",
				},
				{
					"<leader>hp",
					function()
						require("thefish.git-push-variants").git_push_variants_menu()
					end,
					desc = "git push variants",
				},
			},

			-- TOGGLE LINE HINTS
			{ "<leader>o", group = "T[o]ggle line hints" },
			{
				{
					"<leader>ob",
					function()
						require("gitsigns").toggle_current_line_blame()
					end,
					desc = "Current line blame",
				},
				{
					"<leader>od",
					function()
						require("gitsigns").toggle_deleted()
					end,
					desc = "deleted",
				},
			},

			-- INTROSPECTION GROUP
			{ "<leader>g", group = "introspection" },
			{
				{
					"<leader>gD",
					function()
						require("telescope.builtin").lsp_definitions()
					end,
					desc = "Go to declaration",
				},
				{
					"<leader>gt",
					function()
						require("telescope.builtin").lsp_type_definitions()
					end,
				},
				{
					"<leader>gd",
					function()
						require("telescope.builtin").lsp_definitions()
					end,
					desc = "Go to definition",
				},
				{
					"<leader>gi",
					function()
						require("telescope.builtin").lsp_implementations()
					end,
					desc = "Go to implementation",
				},
				{
					"<leader>go",
					function()
						require("telescope.builtin").lsp_type_definitions()
					end,
					desc = "Go to type definitions",
				},
				{
					"<leader>gr",
					function()
						require("telescope.builtin").lsp_references()
					end,
					desc = "Go to references",
				},
				{
					"<leader>gf",
					function()
						vim.lsp.buf.format({ async = true })
					end,
					desc = "Reformat code",
				},
				{
					"<leader>ga",
					function()
						vim.lsp.buf.code_action()
					end,
					desc = "Code action",
				},
				{
					"<leader>gn",
					function()
						vim.lsp.buf.rename()
					end,
					desc = "Rename symbol",
				},
				{
					"<leader>gk",
					function()
						vim.lsp.buf.hover()
					end,
					desc = "Hover help",
				},
				{
					"<leader>gK",
					function()
						vim.lsp.buf.signature_help()
					end,
					desc = "Signature help",
				},
				{
					"<leader>ge",
					function()
						vim.diagnostic.open_float()
					end,
					desc = "display diag error",
				},
			},

			-- DEBUG GROUP
			{ "<leader>d", group = "debug" },
			{
				{
					"<leader>ds",
					function()
						require("dap").continue()
						require("dapui").open({})
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
					end,
					desc = "Start debugging session",
				},
				{
					"<leader>dt",
					function()
						if vim.bo.filetype == "go" then
							require("dap-go").debug_test()
						else
							require("dap").debug_test()
						end
						require("dapui").open({})
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
					end,
					desc = "Debug single test",
				},
				{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue to next BP" },
				{
					"<leader>dl",
					function()
						require("dap-go").debug_last_test()
					end,
					desc = "debug last test",
				},
				{
					"<leader>dv",
					function()
						require("dap.ui.widgets").hover()
					end,
					desc = "Inspect in-place",
				},
				{
					"<leader>db",
					function()
						require("dap").toggle_breakpoint()
					end,
					desc = "Breakpoint toggle",
				},
				{
					"<leader>dn",
					function()
						require("dap").step_over()
					end,
					desc = "Step over",
				},
				{
					"<leader>di",
					function()
						require("dap").step_into()
					end,
					desc = "Step into",
				},
				{
					"<leader>do",
					function()
						require("dap").step_out()
					end,
					desc = "Step out",
				},
				{
					"<leader>dC",
					function()
						require("dap").clear_breakpoints()
						require("notify")("Breakpoints cleared", "warn")
					end,
					desc = "Breakpoints clear",
				},
				{
					"<leader>de",
					function()
						require("dapui").close({})
						require("dap").terminate()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
						require("notify")("Debugger session ended", "warn")
					end,
					desc = "Stop debugging",
				},

				-- Run Test Sub-Group
				{ "<leader>dr", group = "run test" },
				{
					{ "<leader>drr", "<cmd>TestNearest<cr>", desc = "Run nearest test" },
					{ "<leader>drs", "<cmd>TestSuite<cr>", desc = "Run test suite" },
					{ "<leader>drf", "<cmd>TestFile<cr>", desc = "Run all tests for the current file" },
					{ "<leader>drl", "<cmd>TestLast<cr>", desc = "Rerun last test" },
					{ "<leader>dro", "<cmd>TestVisit<cr>", desc = "Open last test in current buffer" },
					{ "<leader>drx", "<cmd>TestEdit<cr>", desc = "Fix tests for current file" },
				},
			},

			-- SESSION GROUP
			{ "<leader>q", group = "session" },
			{
				{
					"<leader>ql",
					function()
						require("persistence").load()
					end,
					desc = "Load session for current working dir",
				},
				{
					"<leader>qs",
					function()
						require("persistence").load({ last = true })
					end,
					desc = "Restore last saved session",
				},
				{
					"<leader>qd",
					function()
						require("persistence").stop()
					end,
					desc = "Do not save session on exit",
				},
				{
					"<leader>qt",
					function()
						require("telescope.builtin").colorscheme({ enable_preview = true })
					end,
					desc = "Change theme",
				},
			},

			-- WINDOW SPLITS GROUP
			{ "<leader>s", group = "window [s]plits" },
			{
				{ "<leader>sv", "<C-w>vbs", desc = "Split window vertically" },
				{ "<leader>sh", "<C-w>s", desc = "Split window horizontally" },
				{ "<leader>se", "<C-w>=", desc = "Make splits equal size" },
				{ "<leader>sx", "<cmd>close<CR>", desc = "Close current split" },
			},

			-- TABS GROUP
			{ "<leader>t", group = "[t]abs" },
			{
				{ "<leader>to", "<cmd>tabnew<CR>", desc = "Open new tab" },
				{ "<leader>tx", "<cmd>tabclose<CR>", desc = "Close current tab" },
				{ "<leader>tn", "<cmd>tabn<CR>", desc = "Go to next tab" },
				{ "<leader>tp", "<cmd>tabp<CR>", desc = "Go to previous tab" },
				{ "<leader>tf", "<cmd>tabnew %<CR>", desc = "Open current buffer in new tab" },
			},

			{ "<leader>ee", "oif err != nil {<cr>return err<cr>}<cr><esc>kvap=$", desc = "golang if err != nil" },

			-- Non-leader Normal Mappings
			{
				"gr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "Find references",
			},
			{
				"gD",
				function()
					require("lsp").buf.declaration()
				end,
				desc = "Go to declaration",
			},
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				desc = "Go to definition",
			},
			{
				"gi",
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				desc = "Go to implementation",
			},
			{
				"go",
				function()
					require("telescope.builtin").lsp_type_definitions()
				end,
				desc = "Go to type definitions",
			},
			{
				"[p",
				function()
					vim.diagnostic.goto_next()
				end,
				desc = "Diag next",
			},
			{
				"]p",
				function()
					vim.diagnostic.goto_prev()
				end,
				desc = "Diag prev",
			},
			{
				"<C-b>",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Breakpoint toggle",
			},
			{
				"]c",
				function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						require("gitsigns").next_hunk()
					end)
					return "<Ignore>"
				end,
				desc = "Next hunk",
			},
			{
				"[c",
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						require("gitsigns").prev_hunk()
					end)
					return "<Ignore>"
				end,
				desc = "Prev hunk",
			},
			{ "<C-z>", "u<cr>", desc = "Undo on ctrl+z" },
			{ "<F2>", "<cmd>w<cr>", desc = "Save file" },
			{
				"<C-p>",
				":set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJx:set nopaste<CR>",
				desc = "copy to system clipboard",
			},
			{ "<Esc><Esc>", "<Esc>:nohl<CR>", desc = "double escape to disable highlight" },
			{ "<C-Right>", "<c-w>l", desc = "Move to right window" },
			{ "<C-Left>", "<c-w>h", desc = "Move to left window" },
			{ "<C-Up>", "<c-w>k", desc = "Move to top window" },
			{ "<C-Down>", "<c-w>j", desc = "Move to bottom window" },
			{ "<C-d>", "<c-d>zz", desc = "Move half page down and center" },
			{ "<C-u>", "<c-u>zz", desc = "Move half page down and center" },
			{ "<C-j>", "<cmd>cnext<cr>", desc = "Move to next entry in quickfix list" },
			{ "<C-k>", "<cmd>cprev<cr>", desc = "Move to previous entry in quickfix list" },
		},
	},
	-- visual mode stuff
	{
		{
			mode = "v",
			{ "jh", "<esc>", desc = "exit visual mode on fast jh" },
			{ "<C-z>", "<Esc>u<cr>v", desc = "Undo on ctrl+z" },
			{ "<F2>", "<esc><cmd>w<cr>v", desc = "Save file" },
			{
				"<C-y>",
				":<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u",
				desc = "paste from system clipboard",
			},
			{ "<C-l>", "<cmd>Telescope git_bcommits<cr>", desc = "Commits for selected lines" },

			{ "<leader>h", group = "git ops" },
			{
				{
					"<leader>hs",
					function()
						require("gitsigns").stage_hunk()({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "stage selected",
				},
				{
					"<leader>hr",
					function()
						require("gitsigns").reset_hunk()({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "reset selected",
				},
			},
		},
	},
	-- insert mode stuff
	{
		{
			mode = "i",
			{ "<C-z>", "<Esc>u<cr>i", desc = "Undo on ctrl+z" },
			{ "jh", "<esc>", desc = "exit insert mode on fast jh" },
			{ "<c-d>", "<esc>yypi", desc = "duplicate line" },
			{ "<c-y>", "<esc>ddki", desc = "delete line" },
			{ "<F2>", "<esc><cmd>w<cr>i", desc = "Save file" },
		},
	}
end
