Just a collection of NeoVim Lua scripts, based on Lazy package manager.
Tried to keep config minimal, with at least debugging, introspetion and completion functionality.
Have fun!

Install:
---
```
mv ~/.config/nvim ~/.config/nvim.bak #create backup
git clone --depth 1 https://github.com/thefish/nvim-lua-config.git ~/.config/nvim

```
then run nvim and wait everything to download and install.

full list of plugins
---
see (plugin folder)[lua/thefish/plugins]

Key mapping
---
Extensively described in (mappings file)[lua/thefish/core/mappings.lua]

Also some hacks were added to nvim-tree:

```Ctrl+f``` Find file in folder

```Ctrl+a``` Stage file/folder for git commit

```Ctrl+x``` Unstage file/folder from git commit


##### small telescope hacks

```<c-q>``` in an telesope find window to open the contents as a nvim's quickfix list. cnext and cprev to navigate. 


Custom themes
---
ir_black2 is the theme I always liked the most, and it is included but not modified for usage with NeoVim yet.

