return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local highlights = require("rose-pine.plugins.bufferline")
		require("bufferline").setup({ highlights = highlights })
	end,
}
