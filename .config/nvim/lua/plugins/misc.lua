-- load plugins without special configuration
require("todo-comments").setup()
require("neogit").setup()
require("Comment").setup()
require("colorizer").setup()
require("arachne").setup {notes_directory = "~/notes"}
require("symbols-outline").setup()
require"lspsaga".init_lsp_saga {error_sign = "", warn_sign = "", hint_sign = "", infor_sign = ""}
-- base64
vim.g.vim_base64_disable_default_key_mappings = 1
