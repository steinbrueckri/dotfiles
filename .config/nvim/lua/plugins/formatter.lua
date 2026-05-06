return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<Leader> ",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "Format",
		},
	},
	opts = {
		formatters_by_ft = {
			jinja = { "djlint" },
			htmldjango = { "djlint" },
			lua = { "stylua" },
			markdown = { "rumdl" },
			yaml = { "prettier" },
			ansible = { "yamlfmt" },
			html = { "prettier" },
			json = { "prettier" },
			sh = { "shfmt" },
			python = { "ruff_format" },
			["*"] = { "trim_whitespace" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
		formatters = {
			rumdl = {
				command = "rumdl",
				args = { "fmt", "-", "--quiet" },
				stdin = true,
			},
			djlint = {
				command = "djlint",
				args = { "--reformat", "--quiet", "-" },
				stdin = true,
			},
			yamlfmt = {
				prepend_args = {
					"-formatter",
					"retain_line_breaks=true,eof_newline=true,include_document_start=true",
				},
			},
		},
	},
}
