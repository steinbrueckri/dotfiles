return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	opts = {
		buffers = { follow_current_file = { enabled = true } },
		filesystem = {
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
			},
		},
	},
}
