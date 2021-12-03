-----------------------------------------------------------
-- Neoclip configuration file
-----------------------------------------------------------

-- Plugin: neoclip
-- https://github.com/AckslD/nvim-neoclip.lua
-----------------------------------------------------------

require('neoclip').setup({
  history = 1000,
  filter = nil,
  enable_persistant_history = true,
  preview = true,
  default_register = '"',
  content_spec_column = false,
  on_paste = {
    set_reg = false,
  },
  keys = {
    i = {
      select = '<cr>',
      paste = '<c-p>',
      paste_behind = '<c-k>',
    },
    n = {
      select = '<cr>',
      paste = 'p',
      paste_behind = 'P',
    },
  },
})
