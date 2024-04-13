local gcselect = function()
    vim.ui.select({'apple', 'banana', 'mango'}, {
        prompt = "Title",
        telescope = require("telescope.themes").get_cursor(),
    }, function(selected) end)
end;


local gcinput = function ()
    vim.ui.input({
        prompt = "Commit msg",
        telescope = require("telescope.themes").get_cursor(),
    }, function(input) end)
end

return function()
    local msg = gcinput()
    vim.fn.system(string.format('git commit -am "%s"', msg))
end
