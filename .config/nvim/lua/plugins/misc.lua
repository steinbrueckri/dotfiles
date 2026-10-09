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
		lazy = false,
		priority = 1000, -- load the colorscheme before all other plugins
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd.colorscheme("rose-pine-moon")
		end,
	},
	{
		"2kabhishek/nerdy.nvim",
		cmd = "Nerdy",
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional native fzf library, used by dropbar's fuzzy finder (no telescope needed)
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
			require("tiny-inline-diagnostic").setup() -- virtual_text is disabled in lsp-config.lua
		end,
	},
}
