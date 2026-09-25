return {
	"williamboman/mason-lspconfig.nvim", -- Fixed organization name to williamboman
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"stylua",
					"goimports",
					"gofmt",
					"pint",
					"php-cs-fixer",
					"prettierd",
					"prettier",
					"golangci-lint",
					"php-debug-adapter",
					"phpcs",
					"pretty-php",
					"prometheus-pint",
					"protolint",
				},
			},
		},
		"neovim/nvim-lspconfig",
	},
	opts = {
		-- Cleaned up package names matching the official Mason registry
		ensure_installed = {
			"bashls",
			"golangci_lint_ls",
			"gopls",
			"html",
			"intelephense",
			"lua_ls",
			"protols",
			"ruff",
			"rust_analyzer",
			"yamlls",
			"vtsls",
		},
		handlers = {
			-- 1. The default handler
			function(server_name)
				-- Guard clause to prevent ts_ls from loading if it sneaks onto your system
				if server_name == "ts_ls" then
					return
				end
				require("lspconfig")[server_name].setup({})
			end,

			-- 2. Custom override handler specifically for gopls
			["gopls"] = function()
				require("lspconfig").gopls.setup({
					root_dir = function(fname)
						local util = require("lspconfig.util")
						return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
					end,
					settings = {
						gopls = {
							semanticTokens = true,
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
						},
					},
				})
			end,

			-- 3. Custom override handler for vtsls
			["vtsls"] = function()
				require("lspconfig").vtsls.setup({
					settings = {
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
							},
						},
					},
				})
			end,
		},
	},
}
