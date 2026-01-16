return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- Shell & Scripting
				"bash",
				"fish",

				-- DevOps & Infrastructure
				"dockerfile",
				"hcl",
				"terraform",
				"yaml",
				"toml",
				"ini",
				"make",

				-- Web & Templates
				"html",
				"css",
				"javascript",
				"jinja",
				"htmldjango",

				-- Data & Config
				"json",
				"jsonc",
				"xml",
				"csv",

				-- Python
				"python",
				"requirements",

				-- Git
				"diff",
				"git_config",
				"gitcommit",
				"gitignore",
				"git_rebase",

				-- Documentation
				"markdown",
				"markdown_inline",
				"rst",           -- reStructuredText

				-- Neovim config
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"query",
				"regex",

				-- SQL
				"sql",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
