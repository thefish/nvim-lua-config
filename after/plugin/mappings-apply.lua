-- force keybindings
local wk = require("which-key")
wk.setup()

local wkOpts = {
	mode = "n", -- NORMAL mode
	-- prefix: use "<leader>f" for example for mapping everything related to finding files
	-- the prefix is prepended to every mapping part of `mappings`
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
	expr = false, -- use `expr` when creating keymaps
}

local normal, visual, insert = require("thefish.core.mappings")()

-- Notice we pass normal, visual, and insert directly to wk.add()
-- Inject your standard wkOpts right at the top-level array.
-- All child nodes nested within `normal` inherit these options cleanly.
wk.add(vim.tbl_extend("force", {
	mode = "n",
	silent = true,
	noremap = true,
	nowait = true,
}, normal))
wk.add(normal)
wk.add(visual)
wk.add(insert)

vim.opt.mouse = ""
