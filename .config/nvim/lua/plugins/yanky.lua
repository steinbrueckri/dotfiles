return {
	"gbprod/yanky.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	keys = {
		{
			"y",
			"<Plug>(YankyYank)",
			mode = { "n", "x" },
			desc = "Yank text",
		},
		{
			"p",
			"<Plug>(YankyPutAfter)",
			mode = { "n", "x" },
			desc = "Put yanked text after cursor",
		},
		{
			"P",
			"<Plug>(YankyPutBefore)",
			mode = { "n", "x" },
			desc = "Put yanked text before cursor",
		},
		{ "<c-p>", "<Plug>(YankyCycleBackward)", desc = "Select previous entry through yank history" },
		{ "<c-n>", "<Plug>(YankyCycleForward)", desc = "Select next entry through yank history" },
	},
	config = function()
		require("yanky").setup({})

		require("telescope").load_extension("yank_history")
	end,
}
