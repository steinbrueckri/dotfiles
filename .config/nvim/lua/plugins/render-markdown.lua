-- Add "3rd/image.nvim" for image support
return {
	{
		"3rd/image.nvim",
		opts = {},
		dependencies = {
			"leafo/magick",
		},
	},
	{ "iamcco/markdown-preview.nvim", build = "cd app && npm install" },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", "3rd/image.nvim" },
	},
}
