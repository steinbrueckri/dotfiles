-----------------------------------------------------------
-- Keybindings
-----------------------------------------------------------
-- Note: Leader keys are defined in settings.lua

-- General Mappings
-----------------------------------------------------------
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { silent = true, desc = "Clear search highlight" })
vim.keymap.set("n", "U", "<cmd>redo<CR>", { silent = true, desc = "Redo last undone change" })

-- Indentation
-----------------------------------------------------------
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "Indent right and reselect" })

-- Deleting and Pasting
-----------------------------------------------------------
vim.keymap.set("x", "<leader>x", [["_d]], { desc = "Delete without losing register contents" })
vim.keymap.set("x", "<leader>p", [["_dP]], { silent = true, desc = "Paste over visual selection without losing register contents" })

-- Buffer Management
-----------------------------------------------------------
vim.keymap.set("n", "<Tab>", "<cmd>bn<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bp<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>q", function() Snacks.bufdelete() end, { silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "<leader>Q", function() Snacks.bufdelete({ force = true }) end, { silent = true, desc = "Force close current buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bm", function()
	vim.cmd("delmarks A-Z0-9")
	require("notify")("Deleted all marks")
end, { silent = true, desc = "Delete all marks" })

-- File Management
-----------------------------------------------------------
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<leader>N", "<cmd>enew<CR>", { silent = true, desc = "Create new buffer" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { silent = true, desc = "Toggle file tree" })
vim.keymap.set("n", "gF", "<cmd>e <cfile><CR>", { silent = true, desc = "Create file and open" })

-- Search & Navigation
-----------------------------------------------------------
vim.keymap.set("n", "n", "nzzzv", { silent = true, desc = "Find next and center" })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, desc = "Find previous and center" })
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope make<CR>", { silent = true, desc = "Execute make target" })
vim.keymap.set("n", "<leader>fa", function() Snacks.picker.grep() end, { silent = true, desc = "Search in files" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { silent = true, desc = "Search in config files" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { silent = true, desc = "Search all files (ignoring .git)" })
vim.keymap.set("n", "<leader>fe", function() Snacks.picker.icons() end, { silent = true, desc = "Find emojis" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.registers() end, { silent = true, desc = "Show yank history" })
vim.keymap.set("n", "<leader>fo", function() Snacks.picker.recent() end, { silent = true, desc = "Show recent files" })
vim.keymap.set("n", "<leader>fr", function() require("spectre").open() end, { silent = true, desc = "Open search and replace" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME,BUG<CR>", { silent = true, desc = "Find open TODOs" })

-- Git
-----------------------------------------------------------
vim.keymap.set("n", "<leader>gf", "<cmd>!fork status $PWD<CR><CR>", { silent = true, desc = "Open Fork and show Git status" })
vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end, { silent = true, desc = "Git blame line" })
vim.keymap.set("n", "<leader>gg", function() Snacks.gitbrowse.open() end, { silent = true, desc = "Open line in Github" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit() end, { silent = true, desc = "Open LazyGit" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<CR>", { silent = true, desc = "Find git branches" })

-- Utilities
-----------------------------------------------------------
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<CR>", { silent = true, desc = "Toggle word wrap" })
vim.keymap.set("n", "<leader>ud", "<cmd>DBUIToggle<CR>", { silent = true, desc = "Toggle database UI" })
vim.keymap.set("n", "<leader>tm", "<cmd>MarkdownPreviewToggle<CR>", { silent = true, desc = "Toggle Markdown preview" })
vim.keymap.set("n", "Z", "<cmd>Telescope spell_suggest<CR>", { silent = true, desc = "Show spell suggests" })
vim.keymap.set("n", "yc", "yy<cmd>normal gcc<CR>p", { silent = true, desc = "Duplicate a line and comment out the first line" })
vim.keymap.set("n", "<leader>ts", "<cmd>Screenkey toggle<CR>", { silent = true, desc = "Toggle Screenkey" })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { silent = true, desc = "Toggle Terminal" })

-- LSP / Trouble
-----------------------------------------------------------
vim.keymap.set("n", "<leader>to", "<cmd>Trouble symbols toggle focus=false<CR>", { silent = true, desc = "Toggle Symbols" })
vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<CR>", { silent = true, desc = "Toggle Diagnostics" })
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { silent = true, desc = "Toggle LSP Definitions" })

-- Notes
-----------------------------------------------------------
vim.keymap.set("n", "<leader>nn", CreateQuickNote, { silent = true, desc = "Create quick note" })
vim.keymap.set("n", "<leader>nf", function() require("telescope.builtin").live_grep({ cwd = vim.fn.expand("$HOME/notes") }) end, { silent = true, desc = "Search notes" })
vim.keymap.set("n", "<leader>no", OpenInSilverbullet, { silent = true, desc = "Open note in Silverbullet" })

-- Quickfix
-----------------------------------------------------------
vim.keymap.set("n", "<leader>tq", ToggleQf, { desc = "Toggle quickfix list" })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next item quickfix list" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous item quickfix list" })

-- Splits
-----------------------------------------------------------
vim.keymap.set("n", "<leader><Up>", "<cmd>wincmd k<CR>", { silent = true, desc = "Goto split up" })
vim.keymap.set("n", "<leader><Down>", "<cmd>wincmd j<CR>", { silent = true, desc = "Goto split down" })
vim.keymap.set("n", "<leader><Left>", "<cmd>wincmd h<CR>", { silent = true, desc = "Goto split left" })
vim.keymap.set("n", "<leader><Right>", "<cmd>wincmd l<CR>", { silent = true, desc = "Goto split right" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { silent = true, desc = "Create horizontal split" })
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { silent = true, desc = "Create vertical split" })
