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
look into lua/thefish/init.lua to see a full list of plugins

Custom scripting
---

#### Project group

```<leader>p f``` Finds file in project

```<leader>p g c``` Opens diff with git master/main tree in telescope viewer. Useful when you are doing merge requests.

##### small telescope hacks

```<c-q>``` in an telesope find window to open the contents as a nvim's quickfix list. cnext and cprev to navigate. 


Custom themes
---
ir_black2 is the theme i like the most, and it is included but not modified for usage with NeoVim yet.

