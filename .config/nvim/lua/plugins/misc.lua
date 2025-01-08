return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			direction = "float",
			close_on_exit = true,
			shell = "/opt/homebrew/bin/fish"
		},
	},
	{ "nmac427/guess-indent.nvim", opts = {} },
	{
		"otavioschwanck/arrow.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			-- or if using `mini.icons`
			-- { "echasnovski/mini.icons" },
		},
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			cursor_color = "#50FA7B",
		},
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},
	{
		"Kicamon/markdown-table-mode.nvim",
		event = "VeryLazy",
		config = function()
			require("markdown-table-mode").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},
	{
		"ethanholz/nvim-lastplace",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {},
	},
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
