-----------------------------------------------------------
-- treesitter and extensions configuration file
-----------------------------------------------------------

-- Plugin: treesitter + extensions
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/p00f/nvim-ts-rainbow
-----------------------------------------------------------

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,                 -- false will disable the whole extension
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}
