function ColorMyPencils(color)
    color = color or "habamax"
    vim.cmd.colorscheme(color)

    -- transparent bg
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
