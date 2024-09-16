return {
	"renerocksai/telekasten.nvim",
	lazy = true,
	keys = {
		{ "<leader>nn", "<cmd>Telekasten goto_thisweek<CR>" },
		{ "<leader>nr", ":cmd>Telekasten rename_note<CR>" },
		{ "<leader>nf", ":cmd>Telekasten search_notes<CR>" },
	},
	opts = { home = vim.fn.expand("~/notes") },
}
