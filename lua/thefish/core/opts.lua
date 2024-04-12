local set = vim.opt  --set options

set.undodir = Rtdir .. "/undo"
set.backupdir = Rtdir .. "/backup"
set.directory = Rtdir .. "/swap"

vim.wo.number = true

vim.bo.undofile = true
vim.g.mapleader = " "



set.tabstop = 4      -- Force tabs to be displayed/expanded to 2 spaces (instead of default 8).
set.softtabstop = 4  -- Make Vim treat <Tab> key as 4 spaces, but respect hard Tabs.
-- I don't think this one will do what you want.
set.expandtab = true -- Turn Tab keypresses into spaces.  Sounds like this is happening to you.
-- You can still insert real Tabs as [Ctrl]-V [Tab].
set.shiftwidth = 4   -- When auto-indenting, indent by this much.
-- (Use spaces/tabs per "expandtab".)
vim.cmd('retab')     -- Change all the existing tab characters to match the current tab settings
-- scroloff
set.scrolloff = 8
-- nowrap
vim.wo.wrap = false

-- small nuances

-- delete trailing white spaces except for markdown
function DeleteTrailingWS()
    if (vim.bo.filetype == 'markdown') then
        return
    end
    vim.api.nvim_command([[normal mz]])
    vim.cmd([[%s/\s\+$//ge]])
    vim.api.nvim_command([[normal 'z]])
end

vim.api.nvim_create_autocmd('BufWritePre', { callback = DeleteTrailingWS })

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', { pattern = "*", command = "silent! normal! g;" })

-- disable mouse
vim.opt.mouse = nil
