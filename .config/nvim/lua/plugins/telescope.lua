return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-github.nvim",
		"xiyaowong/telescope-emoji.nvim",
		"DrKJeff16/project.nvim",
		"ThePrimeagen/harpoon",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		-- function to allow multi-selection in the telescope picker
		local select_one_or_multi = function(prompt_bufnr)
			local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
			local multi = picker:get_multi_selection()
			if not vim.tbl_isempty(multi) then
				require("telescope.actions").close(prompt_bufnr)
				for _, j in pairs(multi) do
					if j.path ~= nil then
						vim.cmd(string.format("%s %s", "edit", j.path))
					end
				end
			else
				require("telescope.actions").select_default(prompt_bufnr)
			end
		end

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<CR>"] = select_one_or_multi,
					},
				},
				color_devicons = true,
				preview = {
					filesize_hook = function(filepath, bufnr, opts)
						local max_bytes = 10000
						local cmd = { "head", "-c", max_bytes, filepath }
						require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
					end,
				},
				extensions = {
					undo = {
						side_by_side = true,
						layout_strategy = "vertical",
						layout_config = { preview_height = 0.8 },
					},
					["ui-select"] = { require("telescope.themes").get_dropdown({}) },
				},
				prompt_prefix = "   ",
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
					vertical = { mirror = false },
					width = 0.90,
					height = 0.90,
					preview_cutoff = 120,
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { "node_modules" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			},
		})
		--- ####################################################################
		--- Load telescope extensions
		--- ####################################################################
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("emoji")
		require("telescope").load_extension("gh")
		require("telescope").load_extension("projects")
		require("telescope").load_extension("undo")
		require("telescope").load_extension("harpoon")
	end,
}
