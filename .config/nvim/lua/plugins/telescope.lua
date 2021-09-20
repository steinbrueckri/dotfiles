-----------------------------------------------------------
-- telescope configuration file
-----------------------------------------------------------

-- Plugin: telescope
-- https://github.com/nvim-telescope/telescope.nvim
-----------------------------------------------------------

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { '.git/', 'node_modules/' },
    color_devicons = true,
  }
}

require('telescope').load_extension('ultisnips')
require('telescope').load_extension('project')

