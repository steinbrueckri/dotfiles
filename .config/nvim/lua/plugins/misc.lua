return {
	{
		"emmanueltouzery/apidocs.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		cmd = { "ApidocsSearch", "ApidocsInstall", "ApidocsOpen", "ApidocsSelect", "ApidocsUninstall" },
		config = function()
			require("apidocs").setup()
			require("apidocs").setup({ picker = "snacks" })
		end,
		keys = {
			{ "<leader>fd", "<cmd>ApidocsOpen<cr>", desc = "Search Api Doc" },
		},
	},
	{
		"lervag/vimtex",
		lazy = true,
		ft = { "tex", "bib" },
		keys = {
			{ "<leader>lc", ":w<CR>:VimtexCompile<CR>",          desc = "Compile Latex Files" },
			{ "<leader>lC", ":w<CR>:VimtexClean<CR>",            desc = "Clean complie Files" },
			{ "<leader>lv", ":VimtexView<CR>:!open -a Skim<CR>", desc = "View Latex PDF File" },
			{ "<leader>lt", ":VimtexTocToggle<CR>",              desc = "Show Toc Latex Files" },
		},
		init = function()
			local g = vim.g
			g.vimtex_mappings_enabled = false
			g.vimtex_view_method = "skim"
			g.vimtex_compiler_latexmk_engines = { ["_"] = "-lualatex" }
			g.vimtex_compiler_latexmk = {
				aux_dir = ".build",
				options = {
					"-shell-escape",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}
			g.vimtex_quickfix_mode = 0
			g.vimtex_log_ignore = {
				"Underfull",
				"Overfull",
				"specifier changed to",
				"Token not allowed in PDF string",
			}
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			direction = "float",
			close_on_exit = true,
			shell = "/opt/homebrew/bin/fish",
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
			leader_key = ";",     -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
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
		opts = {},
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
}
