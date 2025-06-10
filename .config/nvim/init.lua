--   ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
--   ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
--   ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
--   ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
--   ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
--   ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
-- Neovim init file

require("functions")
require("settings")
require("keymap")
require("packagemanager")
require("autocmd")

-- some hack to switch the theme flavor with themr
local flavor = "dawn"
vim.cmd("colorscheme rose-pine-" .. flavor)
