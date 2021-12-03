--[[

  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
Neovim init file

--]]

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------

require('settings')           -- general settings
require('other/lua')          -- helper scripts for lua
require('plugins/packer')     -- Packagemanager
require('plugins/which-key')  -- Keybindings
require('plugins/autopairs')
require('plugins/base64')
require('plugins/code_runner')
require('plugins/colorizer')
require('plugins/coq')
require('plugins/dashboard')
require('plugins/gitsigns')
require('plugins/hardtime')
require('plugins/http-client')
require('plugins/indent-blankline')
require('plugins/lspconfig')
require('plugins/lspkind')
require('plugins/lspsaga')
require('plugins/lualine')
require('plugins/neogit')
require('plugins/bufferline')
require('plugins/symbols-outline')
require('plugins/telescope')
require('plugins/neoclip')
require('plugins/project')
require('plugins/todo-comments')
require('plugins/trouble')
require('plugins/kommentary')
require('plugins/spectre')
require('plugins/clipboard-image')
