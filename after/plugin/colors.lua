function ColorMyPencils(color)
    color = color or "github_light_high_contrast"
    vim.cmd.colorscheme(color)

    -- transparent bg
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
