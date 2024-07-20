return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		-----------------------------------------------------------
		-- Which-key Setup
		-----------------------------------------------------------

		local wk = require("which-key")

		wk.add({
			-- Global Mappings
			{
				"gW",
				":BrowserSearch<cr>",
				desc = "Search for word on cursor",
			},
			{
				"gF",
				":e <cfile><cr>",
				desc = "create and goto file",
			},
			{
				"<esc>",
				":noh<cr>",
				desc = "clear search highlight",
			},
			{
				"<leader><Up>",
				":wincmd k<cr>",
				desc = "goto split",
			},
			{
				"<leader><Down>",
				":wincmd j<cr>",
				desc = "goto split",
			},
			{
				"<leader><Left>",
				":wincmd h<cr>",
				desc = "goto split",
			},
			{
				"<leader><Right>",
				":wincmd l<cr>",
				desc = "goto split",
			},
			{
				"<Tab>",
				":bn<cr>",
				desc = "Next buffer",
			},
			{
				"<S-Tab>",
				":bp<cr>",
				desc = "Previous buffer",
			},
			{
				"Z",
				":Telescope spell_suggest<cr>",
				desc = "spell suggest",
			},
			{
				"U",
				":redo<cr>",
				desc = "Redo",
			},

			-- Leader Mappings
			{ "<leader>d", group = "+delete" },
			{
				"<leader>dd",
				":bd<cr>",
				desc = "delete buffer",
			},
			{
				"<leader>dm",
				":delmarks A-Z0-9<cr>:lua require('notify')('Delete all marks')<cr>",
				desc = "delete marker",
			},
			{
				"<leader>q",
				":bdelete<cr>",
				desc = "close buffer",
			},
			{
				"<leader>Q",
				":bd!<cr>",
				desc = "delete buffer",
			},
			{
				"<leader>e",
				":Neotree toggle<cr>",
				desc = "Show the file in the tree",
			},
			{
				"<leader>A",
				":Alpha<cr>",
				desc = "Open Dashboard",
			},
			{
				"<leader>v",
				":vsplit<cr>",
				desc = "Split right",
			},
			{
				"<leader>w",
				":w<cr>",
				desc = "Save",
			},
			{
				"<leader>N",
				":enew<cr>",
				desc = "Empty buffer",
			},
			{ "<leader>f", group = "+find" },
			{
				"<leader>fa",
				":Telescope live_grep<cr>",
				desc = "grep over all",
			},
			{
				"<leader>fc",
				":lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})<cr>",
				desc = "search config",
			},
			{
				"<leader>ff",
				":lua require'telescope.builtin'.find_files({ find_command = {'rg','--files','--hidden','-g','!.git'}})<cr>",
				desc = "search files",
			},
			{
				"<leader>fr",
				":lua require('spectre').open()<cr>",
				desc = "Search and Replace",
			},
			{
				"<leader>fp",
				":Telescope yank_history<cr>",
				desc = "Yank list",
			},
			{
				"<leader>fB",
				":Telescope git_branches<cr>",
				desc = "find git branches",
			},
			{
				"<leader>fo",
				":Telescope oldfiles<cr>",
				desc = "Show recent files",
			},
			{
				"<leader>fb",
				":Telescope buffers<cr>",
				desc = "Show buffer",
			},
			{
				"<leader>fu",
				":Telescope undo<cr>",
				desc = "Show Undo History",
			},
			{
				"<leader>fk",
				":Telescope keymaps<cr>",
				desc = "Show Keybindings",
			},
			{
				"<leader>fh",
				":Telescope harpoon marks<cr>",
				desc = "Show Harpoon marks",
			},
			{
				"<leader>ft",
				":TodoTelescope keywords=TODO,FIX,FIXME,BUG<cr>",
				desc = "Show tasks",
			},
			{ "<leader>g", group = "+git" },
			{
				"<leader>ga",
				":Git add %<cr>",
				desc = "add current",
			},
			{
				"<leader>gA",
				":Git add .<cr>",
				desc = "add all",
			},
			{
				"<leader>gb",
				":Gitsigns blame_line<cr>",
				desc = "blame_line",
			},
			{
				"<leader>gd",
				":DiffviewOpen<cr>",
				desc = "diff open",
			},
			{
				"<leader>gD",
				":DiffviewClose<cr>",
				desc = "diff close",
			},
			{
				"<leader>gg",
				":GHInteractive<cr>",
				desc = "show line on github",
			},
			{
				"<leader>gY",
				":Git yolo<cr>",
				desc = "yolo commit",
			},
			{
				"<leader>gn",
				":Neogit<cr>",
				desc = "Open Neogit",
			},
			{
				"<leader>gl",
				':!tmux split-window -Z -c "$PWD" lazygit<cr>',
				desc = "Open LazyGit",
			},
			{
				"<leader>gf",
				":!fork status $PWD<cr><cr>",
				desc = "Open Fork",
			},
			{ "<leader>n", group = "+Notes" },
			{
				"<leader>nn",
				":Telekasten goto_thisweek<cr>",
				desc = "Create new note",
			},
			{
				"<leader>nr",
				":Telekasten rename_note<cr>",
				desc = "Rename note",
			},
			{
				"<leader>nf",
				":Telekasten search_notes<cr>",
				desc = "Search for notes by content",
			},
			{ "<leader>t", group = "+toggle" },
			{
				"<leader>tc",
				":ColorizerToggle<cr>",
				desc = "colorizer",
			},
			{
				"<leader>to",
				":SymbolsOutline<cr>",
				desc = "SymbolsOutline",
			},
			{
				"<leader>tS",
				":set spell!<cr>",
				desc = "toggle spell highlighting",
			},
			{
				"<leader>tn",
				":set relativenumber!<cr>",
				desc = "relative line-numbers",
			},
			{
				"<leader>tm",
				":MarkdownPreviewToggle<cr>",
				desc = "Show Markdown preview",
			},
			{
				"<leader>tR",
				":set norelativenumber!<cr>",
				desc = "relative line nums",
			},
			{
				"<leader>tr",
				":TroubleToggle<cr>",
				desc = "LSP Issue viewer",
			},
			{
				"<leader>tt",
				":TableModeToggle<cr>",
				desc = "TableModeToggle",
			},
			{ "<leader>h", group = "+harpoon" },
			{
				"<leader>ha",
				":lua require('harpoon.mark').add_file()<cr>:lua vim.notify('Add file to list', 'info', {title = 'Harpoon'})<cr>",
				desc = "Add to harpoon list",
			},
			{
				"<leader>hh",
				":lua require('harpoon.ui').toggle_quick_menu()<cr>",
				desc = "Show harpoon list",
			},
			{
				"<leader>hn",
				":lua require('harpoon.ui').nav_next()<cr>",
				desc = "Jump to next harpoon item in the list",
			},
			{
				"<leader>hp",
				":lua require('harpoon.ui').nav_prev()<cr>",
				desc = "Jump to previous harpoon item in the list",
			},
		})
	end,
}
