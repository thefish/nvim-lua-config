local options = {
    ['push'] = {
        ['command'] = 'git push'
    },
    ['upstream set and push'] = {
         ['command'] = "git push -u origin $(git branch --show-current)"
     },
    ['commit and push'] = {
         ['command'] = 'git commit -am "%s" && git push',
         ['prompt'] = "git commit message",
     },
    ['squash commits and force push'] = {
         ['command'] = 'git reset $(git merge-base master $(git branch --show-current)) && git add -A && git commit -m "%s" && git push -f',
         ['prompt'] = "squashed commit message",
    },
}

-- cuz its easier to preserve order this way
local keyset = {
    'push',
    'commit and push',
    'upstream set and push',
    'squash commits and force push',
}
-- local n=0

-- for k,v in pairs(options) do
--   n=n+1
--   keyset[n]=k
-- end

local execute = function (str)
   vim.fn.system(str)
   -- print(str)
end

return function ()
    vim.ui.select(
        keyset,
        {
            prompt = "Select push mode",
            telescope = require("telescope.themes").get_cursor(),
        },
        function (selected)
            print(selected)
            if options[selected].prompt ~= nil then
                vim.ui.input(
                    {prompt=options[selected]['prompt']},
                    function (msg)
                        local cmd = string.format(options[selected]['command'], msg)
                        execute(cmd)
                    end
                )
            else
                execute(options[selected]['command'])
            end
        end
    )
end
