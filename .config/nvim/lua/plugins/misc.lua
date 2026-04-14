return {
	{
		"emmanueltouzery/apidocs.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		cmd = { "ApidocsSearch", "ApidocsInstall", "ApidocsOpen", "ApidocsSelect", "ApidocsUninstall" },
		config = function()
			require("apidocs").setup({ picker = "snacks" })
		end,
		keys = {
			{ "<leader>fd", "<cmd>ApidocsOpen<cr>", desc = "Search Api Doc" },
		},
	},
	{
		"rachartier/tiny-cmdline.nvim",
		init = function()
			vim.o.cmdheight = 0
		end,
	},
	{ "nmac427/guess-indent.nvim", opts = {} },
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
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				names = false,
			},
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {},
	},
	{
		"2kabhishek/nerdy.nvim",
		event = "VeryLazy",
		dependencies = { "stevearc/dressing.nvim", "nvim-telescope/telescope.nvim" },
		cmd = "Nerdy",
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end,
	},
}
