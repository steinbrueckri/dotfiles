-- Add "3rd/image.nvim" for image support
return {
	{
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
		build = "cd app && npm install",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
}
