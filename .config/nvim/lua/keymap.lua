-----------------------------------------------------------
-- Keybindings
-----------------------------------------------------------

-- Leader Key Setup
-----------------------------------------------------------
vim.g.mapleader = " " -- Set leader key to space
vim.b.mapleader = " " -- Set local buffer leader key
vim.g.maplocalleader = "," -- Set localleader to ,

-- General Mappings
-----------------------------------------------------------
vim.api.nvim_set_keymap("i", "jk", "<esc>", { noremap = true, desc = "Exit insert mode" })
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", { noremap = true, silent = true, desc = "Redo last undone change" })

-- Indentation
-----------------------------------------------------------
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })

-- Deleting and Pasting
-----------------------------------------------------------
vim.keymap.set("x", "<leader>d", [["_d]], { desc = "[D]elete without losing register contents" })
vim.keymap.set(
	"x",
	"<leader>p",
	[["_dP]],
	{ desc = "[P]aste over visual selection without losing register contents", noremap = true, silent = true }
)

-- Buffer Management
-----------------------------------------------------------
vim.api.nvim_set_keymap("n", "<Tab>", ":bn<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bp<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>q",
	":bdelete<CR>",
	{ noremap = true, silent = true, desc = "Close current buffer" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>Q",
	":bd!<CR>",
	{ noremap = true, silent = true, desc = "Force close current buffer" }
)
vim.api.nvim_set_keymap("n", "<leader>dd", ":bd<CR>", { noremap = true, silent = true, desc = "Delete buffer" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>dm",
	':delmarks A-Z0-9<CR>:lua require("notify")("Delete all marks")<CR>',
	{ noremap = true, silent = true, desc = "Delete all marks" }
)

-- File Management
-----------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.api.nvim_set_keymap("n", "<leader>N", ":enew<CR>", { noremap = true, silent = true, desc = "Create new buffer" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>e",
	":Neotree toggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle file tree" }
)
vim.api.nvim_set_keymap("n", "gF", ":e <cfile><CR>", { noremap = true, silent = true, desc = "Create file and open" })

-- Search & Navigation
-----------------------------------------------------------
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Find next and center" })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Find previous and center" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>fm",
	":Telescope make<CR>",
	{ noremap = true, silent = true, desc = "Execute make target" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fa",
	":Telescope live_grep<CR>",
	{ noremap = true, silent = true, desc = "Search in files" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fc",
	':lua require("telescope.builtin").find_files({cwd = vim.fn.stdpath("config")})<CR>',
	{ noremap = true, silent = true, desc = "Search in config files" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ff",
	':lua require"telescope.builtin".find_files({ find_command = {"rg","--files","--hidden","-g","!.git"}})<CR>',
	{ noremap = true, silent = true, desc = "Search all files (ignoring .git)" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fe",
	":Telescope emoji<CR>",
	{ noremap = true, silent = true, desc = "Find emojis" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fp",
	":Telescope yank_history<CR>",
	{ noremap = true, silent = true, desc = "Show yank history" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fo",
	":Telescope oldfiles<CR>",
	{ noremap = true, silent = true, desc = "Show recent files" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fr",
	':lua require("spectre").open()<CR>',
	{ noremap = true, silent = true, desc = "Open search and replace" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ft",
	":TodoTelescope keywords=TODO,FIX,FIXME,BUG<CR>",
	{ noremap = true, silent = true, desc = "Find open TODOs" }
)

-- Git
-----------------------------------------------------------
vim.api.nvim_set_keymap(
	"n",
	"<leader>gf",
	":!fork status $PWD<CR><CR>",
	{ noremap = true, silent = true, desc = "Open Fork and show Git status" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gb",
	":Gitsigns blame_line<CR>",
	{ noremap = true, silent = true, desc = "Git blame line" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gg",
	":OpenInGHFileLines<CR>",
	{ noremap = true, silent = true, desc = "Open line in Github" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gl",
	':!tmux split-window -Z -c "$PWD" lazygit<CR>',
	{ noremap = true, silent = true, desc = "Open LazyGit" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	':Telescope git_branches<CR>',
	{ noremap = true, silent = true, desc = "Find git branches" }
)

-- Harpoon
-----------------------------------------------------------
vim.api.nvim_set_keymap(
	"n",
	"<leader>ha",
	':lua require("harpoon.mark").add_file()<CR>',
	{ noremap = true, silent = true, desc = "Add file to Harpoon" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hh",
	':lua require("harpoon.ui").toggle_quick_menu()<CR>',
	{ noremap = true, silent = true, desc = "Open Harpoon menu" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hn",
	':lua require("harpoon.ui").nav_next()<CR>',
	{ noremap = true, silent = true, desc = "Next Harpoon item" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hp",
	':lua require("harpoon.ui").nav_prev()<CR>',
	{ noremap = true, silent = true, desc = "Previous Harpoon item" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fh",
	":Telescope harpoon marks<CR>",
	{ noremap = true, silent = true, desc = "Search harpoon marks" }
)

-- Utilities
-----------------------------------------------------------
vim.api.nvim_set_keymap(
	"n",
	"<leader>tw",
	"<cmd>set wrap!<CR>",
	{ noremap = true, silent = true, desc = "Toggle word wrap" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>d",
	":DBUIToggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle database UI" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>tm",
	":MarkdownPreviewToggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle Markdown preview" }
)
vim.api.nvim_set_keymap(
	"n",
	"Z",
	":Telescope spell_suggest<CR>",
	{ noremap = true, silent = true, desc = "Show spell suggests" }
)
vim.api.nvim_set_keymap(
	"n",
	"yc",
	"yy<cmd>normal gcc<CR>p",
	{ noremap = true, silent = true, desc = "Duplicate a line and comment out the first line" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ts",
	":Screenkey toggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle Screenkey" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>tt",
	":ToggleTerm<CR>",
	{ noremap = true, silent = true, desc = "Toggle Terminal" }
)

-- LSP
-----------------------------------------------------------
vim.api.nvim_set_keymap(
	"n",
	"<leader>to",
	":Trouble symbols toggle focus=false<cr>",
	{ noremap = true, silent = true, desc = "Toggle Symbols" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>td",
	":Trouble diagnostics toggle<cr>",
	{ noremap = true, silent = true, desc = "Toggle Diagnostics" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>tl",
	":Trouble lsp toggle focus=false win.position=right<cr>",
	{ noremap = true, silent = true, desc = "Toggle LSP Definitions" }
)

-- Notes
-----------------------------------------------------------
vim.api.nvim_set_keymap(
	"n",
	"<leader>nn",
	":lua CreateQuickNote()<CR>",
	{ noremap = true, silent = true, desc = "Create quick note" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>nf",
	":lua require('telescope.builtin').live_grep({ cwd = vim.fn.expand('$HOME/notes') })<CR>",
	{ noremap = true, silent = true, desc = "Search notes" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>no",
	":lua OpenInSilverbullet()<CR>",
	{ noremap = true, silent = true, desc = "Open note in Silverbullet" }
)

-- Quickfix
-----------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader>tq", ":lua ToggleQf()<CR>", { desc = "Open quickfix list" })
vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { desc = "Next item quickfix list" })
vim.api.nvim_set_keymap("n", "[q", ":cprev<CR>", { desc = "Previous item quickfix list" })

-- Splits
-----------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader><Up>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Goto split up" })
vim.api.nvim_set_keymap(
	"n",
	"<leader><Down>",
	":wincmd j<CR>",
	{ noremap = true, silent = true, desc = "Goto split down" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader><Left>",
	":wincmd h<CR>",
	{ noremap = true, silent = true, desc = "Goto split left" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader><Right>",
	":wincmd l<CR>",
	{ noremap = true, silent = true, desc = "Goto split right" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>h",
	":split<CR>",
	{ noremap = true, silent = true, desc = "Create horizontal split" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>v",
	":vsplit<CR>",
	{ noremap = true, silent = true, desc = "Create vertical split" }
)
