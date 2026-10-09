local slidev = require("slidev")

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
			-- prettier, not yamlfmt: yamlfmt breaks yamllint (collapses >- scalars, strips { } spaces)
			ansible = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			sh = { "shfmt" },
			python = { "ruff_format" },
			terraform = { "tofu_fmt" },
			["terraform-vars"] = { "tofu_fmt" },
			opentofu = { "tofu_fmt" },
			["opentofu-vars"] = { "tofu_fmt" },
			["*"] = { "trim_whitespace" },
		},
		format_on_save = function(bufnr)
			if slidev.is_deck(bufnr) then
				return nil
			end
			return { lsp_format = "fallback", timeout_ms = 500 }
		end,
		formatters = {
			-- tofu comes from mise: skip formatting where no version is set
			tofu_fmt = {
				condition = function(_, ctx)
					return require("functions").tool_runs({ "tofu", "version" }, ctx.dirname)
				end,
			},
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
