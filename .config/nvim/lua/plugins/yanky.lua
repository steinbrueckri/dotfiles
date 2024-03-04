return {
	"gbprod/yanky.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		ring = { history_length = 15, storage = "shada", sync_with_numbered_registers = true },
		picker = {
			select = {
				action = nil, -- nil to use default put action
			},
			telescope = {
				mappings = nil, -- nil to use default mappings
			},
		},
		system_clipboard = { sync_with_ring = true },
		highlight = { on_put = true, on_yank = true, timer = 500 },
		preserve_cursor_position = { enabled = true },
	},
	config = function()
		vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleForward)", {})
		vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)", {})

		require("telescope").load_extension("yank_history")
	end,
}
