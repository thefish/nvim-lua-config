Rtdir = vim.fn.stdpath('config')


-- make sure neovim install is portable
local old_stdpath = vim.fn.stdpath
vim.fn.stdpath = function(value)
    if value == "data" then
        return Rtdir .. "/data"
    end
    return old_stdpath(value)
end



require("thefish.core")
require("thefish.lazy")


-- mason lspconfig



-- debugging

require("thefish.debugging")


