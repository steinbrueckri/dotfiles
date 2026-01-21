return {
	"DrKJeff16/project.nvim",
	main = "project",
	opts = {
		manual_mode = false,
		patterns = { ".git", "Makefile", "package.json", "init.lua" },
		show_hidden = false,
		silent_chdir = true,
		datapath = vim.fn.stdpath("data"),
	},
}
