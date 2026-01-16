-- return {
-- 	"akinsho/bufferline.nvim",
-- 	dependencies = "nvim-tree/nvim-web-devicons",
-- 	opts = {
-- 		options = {
-- 			show_buffer_icons = true,
-- 			show_close_icon = false,
-- 			show_buffer_close_icons = false,
-- 			left_trunk_marker = "<",
-- 			right_trunk_marker = ">",
-- 			diagnostics = "nvim_lsp",
-- 			sorty_by = "directory",
-- 			show_tab_indicators = true,
-- 			always_show_bufferline = true,
-- 			indicator = { icon = "▎", style = "icon" },
-- 			offsets = {
-- 				{
-- 					filetype = "NvimTree",
-- 					text = "NvimTree",
-- 					highlight = "Directory",
-- 					separator = true, -- use a "true" to enable the default, or set your own character
-- 				},
-- 			},
-- 		},
-- 	},
-- }

return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local highlights = require("rose-pine.plugins.bufferline")
		require("bufferline").setup({ highlights = highlights })
	end,
}
