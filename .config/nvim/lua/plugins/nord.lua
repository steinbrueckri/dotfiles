vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true

-- Load the colorscheme
require('nord').set()
vim.api.nvim_command "colorscheme nord"
