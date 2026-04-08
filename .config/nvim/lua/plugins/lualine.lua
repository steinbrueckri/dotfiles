return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					{ "fileformat", "filetype" },
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "quickfix", "lazy", "mason", "trouble", "neo-tree" },
		})
	end,
}
