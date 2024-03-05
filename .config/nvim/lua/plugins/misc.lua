-- TODO: Split into multiple files?
return {
	{ "psliwka/vim-smoothie" },
	{ "dhruvasagar/vim-table-mode" },
	{ "simrat39/symbols-outline.nvim", lazy = true },
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },
	{ "numToStr/Comment.nvim", config = true },
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
		config = function()
			vim.opt.termguicolors = true
		end,
	}, -- remove, rename - Vim sugar for the UNIX shell commands that need it the most
	{ "chrisgrieser/nvim-genghis", dependencies = { "stevearc/dressing.nvim" } },
	{ "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },
	{
		"Mofiqul/dracula.nvim",
		config = function()
			vim.cmd([[colorscheme dracula]])
		end,
	},
	{
		"2kabhishek/nerdy.nvim",
		lazy = true,
		dependencies = { "stevearc/dressing.nvim", "nvim-telescope/telescope.nvim" },
		cmd = "Nerdy",
	},
}
