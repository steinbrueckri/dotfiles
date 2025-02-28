return {
	"windwp/nvim-spectre",
	keys = {
		{ "<leader>fr", '<cmd>lua require("spectre").open()<cr>"' },
	},
	opts = {
		color_devicons = true,
		open_cmd = "vnew",
		live_update = false, -- auto excute search again when you write any file in vim
		line_sep_start = "┌-----------------------------------------",
		result_padding = "¦  ",
		line_sep = "└-----------------------------------------",
		highlight = { ui = "String", search = "DiffChange", replace = "DiffDelete" },
		find_engine = {
			-- rg is map with finder_cmd
			["rg"] = {
				cmd = "rg",
				-- default args
				args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
				options = {
					["ignore-case"] = { value = "--ignore-case", icon = "[I]", desc = "ignore case" },
					["hidden"] = { value = "--hidden", desc = "hidden file", icon = "[H]" },
					-- you can put any rg search option you want here it can toggle with
					-- show_option function
				},
			},
			["ag"] = {
				cmd = "ag",
				args = { "--vimgrep", "-s" },
				options = {
					["ignore-case"] = { value = "-i", icon = "[I]", desc = "ignore case" },
					["hidden"] = { value = "--hidden", desc = "hidden file", icon = "[H]" },
				},
			},
		},
		replace_engine = {
			["sed"] = { cmd = "sed", args = nil },
			options = { ["ignore-case"] = { value = "--ignore-case", icon = "[I]", desc = "ignore case" } },
		},
		default = {
			find = {
				-- pick one of item in find_engine
				cmd = "rg",
				options = { "ignore-case" },
			},
			replace = {
				-- pick one of item in replace_engine
				cmd = "sed",
			},
		},
		replace_vim_cmd = "cdo",
		is_open_target_win = true, -- open file on opener window
		is_insert_mode = false, -- start open panel on is_insert_mode
	},
}
