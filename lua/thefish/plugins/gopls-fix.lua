return function()
	require("lspconfig").gopls.setup({
		-- Ensure it grabs the current buffer path correctly:
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern("go.mod", ".git")(fname)
		end,
		-- Your existing settings below
		settings = {
			gopls = {
				semanticTokens = true,
			},
		},
	})
end
