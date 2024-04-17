local GPVars = {}

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
         ['command'] = 'git reset $(git merge-base master $(git branch --show-current)) && git add $(ls -d ./*/) && git commit -m "%s" && git push -f',
         ['prompt'] = "squash, commit and force push",
    },
}

local keyset = {}
local n=0

for k,v in pairs(options) do
  n=n+1
  keyset[n]=k
end
table.sort(keyset, function(a,b) return #a<#b end)

local execute = function (str)
   vim.fn.system(str)
   -- print(str)
end

function GPVars.git_push_variants_menu()
    vim.ui.select(
        keyset,
        {
            prompt = "Select push mode",
            telescope = require("telescope.themes").get_cursor(),
        },
        function (selected)
            if (options ~= nil and options[selected] ~= nil and options[selected]['command'] ~= nil) then
                if options[selected]['prompt'] ~= nil then
                    vim.ui.input(
                        {prompt=options[selected]['prompt']},
                        function (msg)
                            if msg ~= nil then
                                local cmd = string.format(options[selected]['command'], msg)
                                execute(cmd)
                            end
                        end
                    )
                else
                    execute(options[selected]['command'])
                end
            end
        end
    )
end

return GPVars
