return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	opts = {
		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					--auto close
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
		close_if_last_window = false,
		buffers = { follow_current_file = { enabled = true } },
		filesystem = {
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
			},
			filtered_items = {
				visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
				hide_dotfiles = false,
				hide_gitignored = true,
				never_show_by_pattern = { -- uses glob style patterns
					".null-ls_*",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					".DS_Store",
					"thumbs.db",
					"node_modules",
					".mypy_cache",
					".pytest_cache",
					".venv",
					"__pycache__",
				},
			},
		},
	},
}
