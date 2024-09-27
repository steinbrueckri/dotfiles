-- NOTE: connections are managed in .local/share/db_ui/connections.json
-- cat .local/share/db_ui/connections.json
-- [{"url": "ssh://jumphost:postgresql://user:pass@db_server_name/db_name", "name": "connection_name"}]

return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "pbogut/vim-dadbod-ssh", lazy = true },
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g["compe.source.vim_dadbod_completion"] = true
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				require("cmp").setup.buffer({
					sources = {
						{ name = "vim-dadbod-completion" },
					},
				})
			end,
		})
	end,
}
