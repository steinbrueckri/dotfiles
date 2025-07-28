return {
	"mhartington/formatter.nvim",
	keys = {
		{ "<Leader> ", "<cmd>FormatWrite<cr>", mode = { "n" }, desc = "Format" },
	},

	lazy = false,

	config = function()
		require("formatter").setup({
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				yaml = {
					require("formatter.filetypes.yaml").prettier,
				},
				ansible = {
					require("formatter.filetypes.yaml").yamlfmt,
				},
				html = {
					require("formatter.filetypes.html").prettier,
				},
				json = {
					require("formatter.filetypes.json").prettier,
				},
				sh = {
					require("formatter.filetypes.sh").shfmt,
				},
				python = {
					require("formatter.filetypes.python").ruff,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})
	end,
}
