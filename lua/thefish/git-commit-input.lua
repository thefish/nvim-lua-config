local gcselect = function()
    vim.ui.select({'apple', 'banana', 'mango'}, {
        prompt = "Title",
        telescope = require("telescope.themes").get_cursor(),
    }, function(selected) end)
end;

local input
local gcinput = function ()
    vim.ui.input({
        prompt = "Commit msg",
        telescope = require("telescope.themes").get_cursor(),
    }, function(str) input = str end)
end


local function run_input(opts)
  opts = opts or {}
  local tx, rx = channel.oneshot()
  vim.ui.input(opts, tx)
  if opts.after_fn then
    opts.after_fn()
  end
  return rx()
end


return function()
    -- local msg = run_input({prompt = "commit msg"})
    vim.ui.input({prompt="git commit msg"}, function (msg)
        -- print("trololo")
        vim.fn.system(string.format('git commit -am "%s"', msg))
        -- print(vim.inspect(string.format('git commit -am "%s"', msg)))
        -- print('ololo')
    end)
end
