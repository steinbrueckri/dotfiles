--[[

  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
Neovim init file

--]]

require('plugins/packer')
require('settings')
require('other/lua')
require('other/autocmd')
require'impatient'.enable_profile()
require('plugins/which-key')
require('plugins/base64')
require('plugins/coq')
require('plugins/alpha')
require('plugins/gitsigns')
require('plugins/indent-blankline')
require('plugins/lspconfig')
require('plugins/lspkind')
require('plugins/lspsaga')
require('plugins/bufferline')
require('plugins/symbols-outline')
require('plugins/telescope')
require('plugins/project')
require('plugins/trouble')
require('plugins/spectre')
require('plugins/zettelkasten')
require('plugins/catppuccin')
require('plugins/mini')
require('plugins/formatter')
require('plugins/lastplace')
require('plugins/lualine')
require('plugins/rest')
require('plugins/diffview')
require('plugins/yanky')
require('plugins/yabs')
