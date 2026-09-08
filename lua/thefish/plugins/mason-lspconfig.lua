return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	handlers = {
		-- 1. The default handler (configures all other servers automatically)
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,

		-- 2. Your custom override handler specifically for gopls
		["gopls"] = function()
			require("lspconfig").gopls.setup({
				-- Force a fallback workspace root if go.mod isn't found,
				-- ensuring gopls attaches instead of remaining completely silent.
				root_dir = function(fname)
					local util = require("lspconfig.util")
					return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
				end,
				settings = {
					gopls = {
						semanticTokens = true,
						-- Recommended Go workspace features:
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
		end,
	},
}
