return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	branch = "stable",
	config = function()
		-- -- Visualize and work with indent scope
		-- require("mini.indentscope").setup()
		--
		-- Align text interactively
		require("mini.align").setup()

		-- Extend and create a/i textobjects
		require("mini.ai").setup()

		-- Autopairs
		require("mini.pairs").setup({
			modes = { insert = true, command = false, terminal = false },
		})

		-- Surround actions
		require("mini.surround").setup({
			highlight_duration = 500,

			mappings = {
				add = "sa", -- Add surrounding
				delete = "sd", -- Delete surrounding
				replace = "sr", -- Replace surrounding
			},
		})

		-- Trailspace (highlight and remove)
		require("mini.trailspace").setup({
			only_in_normal_buffers = true,
		})

		-- Move any selection in any direction
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<C-Left>",
				right = "<C-Right>",
				down = "<C-Down>",
				up = "<C-Up>",
			},
		})
	end,
}
