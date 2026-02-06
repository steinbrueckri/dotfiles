return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<Leader> ",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "Format",
		},
	},
	lazy = false,
	config = function()
		require("conform").setup({
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

			-- Auto-format beim Speichern
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		})

		-- Custom settings for formatters
		require("conform").formatters.rumdl = {
			command = "rumdl",
			args = { "fmt", "-", "--quiet" },
			stdin = true,
		}
		require("conform").formatters.djlint = {
			command = "djlint",
			args = { "--reformat", "--quiet", "-" },
			stdin = true,
		}
		require("conform").formatters.yamlfmt = {
			prepend_args = {
				"-formatter",
				"retain_line_breaks=true,eof_newline=true,include_document_start=true",
			},
		}
	end,
}
