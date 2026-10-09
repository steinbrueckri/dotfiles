return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		-- OpenTofu and variable files share the Terraform grammar
		vim.treesitter.language.register("terraform", { "terraform-vars", "opentofu", "opentofu-vars" })

		require("tree-sitter-manager").setup({
			ensure_installed = {
				-- Shell & Scripting
				"bash",
				"fish",

				-- DevOps & Infrastructure
				"dockerfile",
				"hcl",
				"terraform",
				"helm",
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
				"rst",

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
		})
	end,
}
