return {
	"NeogitOrg/neogit",
	lazy = true,
  cmd = "Neogit",
	keys = {
		{ "<leader>gn", "<cmd>Neogit<cr>" },
	},
	opts = {
		kind = "split", -- opens neogit in a split
		signs = {
			-- { CLOSED, OPENED }
			section = { "", "" },
			item = { "", "" },
			hunk = { "", "" },
		},
		integrations = { diffview = true }, -- adds integration with diffview.nvim
	},
}
