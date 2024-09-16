return {
	"ThePrimeagen/harpoon",
	lazy = true,
	keys = {
		{ "<leader>fh", "<cmd>Telescope harpoon marks<cr>" },
		{
			"<leader>ha",
			'<cmd>lua require("harpoon.mark").add_file()<CR>:lua vim.notify(" Add file to list ", " info ", {title = " Harpoon "})<cr>',
		},
		{ "<leader>hh", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>' },
		{ "<leader>hn", '<cmd>lua require("harpoon.ui").nav_next()<cr>' },
		{ "<leader>hp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>' },
	},

	dependencies = { "nvim-lua/plenary.nvim" },
}
