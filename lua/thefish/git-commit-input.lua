return function()
    vim.ui.input({prompt="git commit msg"}, function (msg)
        vim.fn.system(string.format('git commit -am "%s"', msg))
    end)
end
