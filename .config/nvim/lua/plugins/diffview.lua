return {
	"sindrets/diffview.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>" },
		{ "<leader>gd", "<cmd>DiffviewClose<cr>" },
	},
	dependencies = { "nvim-lua/plenary.nvim" },
}
