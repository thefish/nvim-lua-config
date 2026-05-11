return {
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1, -- High priority is needed if you will use `autoremap()`
		config = function()
			require("langmapper").setup({--[[ your config ]]
			})
		end,
	},
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			local translate_key = require("langmapper.utils").translate_keycode
			-- don't show mappings translated by langmapper.nvim. Show entry if func returns true
			opts.filter = function(mapping)
				return mapping.lhs
					and mapping.lhs == translate_key(mapping.lhs, "default", "ru")
					and mapping.desc
					and mapping.desc:find("LM") == nil
			end
		end,
	},
}
