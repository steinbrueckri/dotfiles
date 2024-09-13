-- Add "3rd/image.nvim" for image support
return {
	{ "iamcco/markdown-preview.nvim", build = "cd app && npm install" },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
}
