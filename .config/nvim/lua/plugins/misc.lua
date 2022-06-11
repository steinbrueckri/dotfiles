-- load plugins without special configuration
require("todo-comments").setup()
require('neogit').setup()
require('Comment').setup()
require("colorizer").setup()

-- iamcco/markdown-preview.nvim",run = function()
vim.fn["mkdp#util#install"]()
