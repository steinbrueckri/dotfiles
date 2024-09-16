-- TODO: Split into multiple files?
return {
	{ "psliwka/vim-smoothie" },
	{
		"Kicamon/markdown-table-mode.nvim",
		event = "VeryLazy",
		config = function()
			require("markdown-table-mode").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		keys = {
			{ "<leader>to", "<cmd>SymbolsOutline<cr>" },
		},
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},
	-- Now build in to nvim -> https://github.com/neovim/neovim/pull/28176
	-- { "numToStr/Comment.nvim", config = true },
	{
		"ethanholz/nvim-lastplace",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			vim.opt.termguicolors = true
		end,
	}, -- remove, rename - Vim sugar for the UNIX shell commands that need it the most
	{
		"chrisgrieser/nvim-genghis",
		event = "VeryLazy",
		dependencies = { "stevearc/dressing.nvim" },
	},
	{ "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },
	{
		"Mofiqul/dracula.nvim",
		config = function()
			vim.cmd([[colorscheme dracula]])
		end,
	},
	{
		"2kabhishek/nerdy.nvim",
		event = "VeryLazy",
		dependencies = { "stevearc/dressing.nvim", "nvim-telescope/telescope.nvim" },
		cmd = "Nerdy",
	},
}
