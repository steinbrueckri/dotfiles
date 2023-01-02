-- load plugins without special configuration
require("todo-comments").setup()
require("neogit").setup()
require("Comment").setup()
require("colorizer").setup()
require("arachne").setup {notes_directory = "~/notes"}
-- base64
vim.g.vim_base64_disable_default_key_mappings = 1
