local NTFns = {}
-- live grep using Telescope inside the current directory under
-- the cursor (or the parent directory of the current file)
function NTFns.grep_folder(path)
  if not path then
    path = vim.uv.cwd()
  end
  if path.type ~= 'directory' and path.parent then
    path = path.parent.absolute_path
  end
  require('telescope.builtin').live_grep({
    search_dirs = { path },
    prompt_title = string.format('Grep in [%s]', vim.fs.basename(path)),
  })
end
return NTFns
