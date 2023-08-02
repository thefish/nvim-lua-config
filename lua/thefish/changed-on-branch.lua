local git_detect_main_branch = function()
    local mainGitBranch = vim.fn.system('git branch | grep -o -m1 "\b(master|main)\b"')
    vim.fn.setenv("PROJECT_MAIN_BRANCH",mainGitBranch)
end

git_detect_main_branch()

--show diff in files with master/main branch
local changed_on_branch = function(rtdir)
    local previewers = require('telescope.previewers')
    local pickers = require('telescope.pickers')
    local sorters = require('telescope.sorters')
    local finders = require('telescope.finders')

    print(rtdir)
    pickers.new {
        results_title = 'Modified on current branch',
        finder = finders.new_oneshot_job({
            rtdir .. '/lua/thefish/scripts/git-branch-modified.sh',
            'list'
        }),
        sorter = sorters.get_fuzzy_file(),
        previewer = previewers.new_termopen_previewer {
            get_command = function(entry)
                return {
                    rtdir .. '/lua/thefish/scripts/git-branch-modified.sh',
                    'diff',
                    entry.value
                }
            end
        },
    }:find()
end
return changed_on_branch
