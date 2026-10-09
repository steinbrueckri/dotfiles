local slidev = require("slidev")

return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- Must be `ft`, not an event: the plugin's own plugin/ directory is sourced
		-- before lazy applies these opts, and on any other trigger it attaches to the
		-- already open buffer right then -- with the default `ignore`, before ours exists.
		ft = { "markdown" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			latex = { enabled = false },
			-- Slidev decks are laid out for the browser, not for a rendered buffer view:
			-- the inline HTML and `---` separators only make sense as plain source.
			ignore = function(bufnr)
				return slidev.is_deck(bufnr)
			end,
		},
	},
}
