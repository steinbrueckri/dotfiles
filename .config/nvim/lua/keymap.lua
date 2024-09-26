-----------------------------------------------------------
-- Native Vim Keybindings Setup
-----------------------------------------------------------

-- Global Mappings
-- Create and goto file
vim.api.nvim_set_keymap("n", "gF", ":e <cfile><CR>", { noremap = true, silent = true })
-- Clear search highlight
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true })
-- Goto split
vim.api.nvim_set_keymap("n", "<leader><Up>", ":wincmd k<CR>", { noremap = true, silent = true })
-- Goto split
vim.api.nvim_set_keymap("n", "<leader><Down>", ":wincmd j<CR>", { noremap = true, silent = true })
-- Goto split
vim.api.nvim_set_keymap("n", "<leader><Left>", ":wincmd h<CR>", { noremap = true, silent = true })
-- Goto split
vim.api.nvim_set_keymap("n", "<leader><Right>", ":wincmd l<CR>", { noremap = true, silent = true })
-- Next buffer
vim.api.nvim_set_keymap("n", "<Tab>", ":bn<CR>", { noremap = true, silent = true })
-- Previous buffer
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bp<CR>", { noremap = true, silent = true })
-- Spell suggest
vim.api.nvim_set_keymap("n", "Z", ":Telescope spell_suggest<CR>", { noremap = true, silent = true })
-- Redo
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", { noremap = true, silent = true })

-- Leader Mappings
-- Delete buffer
vim.api.nvim_set_keymap("n", "<leader>dd", ":bd<CR>", { noremap = true, silent = true })
-- Delete marker
vim.api.nvim_set_keymap(
  "n",
  "<leader>dm",
  ':delmarks A-Z0-9<CR>:lua require("notify")("Delete all marks")<CR>',
  { noremap = true, silent = true }
)
-- Find and center
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })
-- Keep last yanked when pasting
vim.api.nvim_set_keymap("v", "p", '"_dP', { noremap = true, silent = true })
-- Close buffer
vim.api.nvim_set_keymap("n", "<leader>q", ":bdelete<CR>", { noremap = true, silent = true })
-- Delete buffer
vim.api.nvim_set_keymap("n", "<leader>Q", ":bd!<CR>", { noremap = true, silent = true })
-- Show the file in the tree
vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
-- Open Dashboard
vim.api.nvim_set_keymap("n", "<leader>A", ":Alpha<CR>", { noremap = true, silent = true })
-- Split horizontal
vim.api.nvim_set_keymap("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
-- Split right
vim.api.nvim_set_keymap("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true })
-- Save
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
-- Empty buffer
vim.api.nvim_set_keymap("n", "<leader>N", ":enew<CR>", { noremap = true, silent = true })
-- Grep over all
vim.api.nvim_set_keymap("n", "<leader>fa", ":Telescope live_grep<CR>", { noremap = true, silent = true })
-- Search config
vim.api.nvim_set_keymap(
  "n",
  "<leader>fc",
  ':lua require("telescope.builtin").find_files({cwd = vim.fn.stdpath("config")})<CR>',
  { noremap = true, silent = true }
)
-- Search files
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  ':lua require"telescope.builtin".find_files({ find_command = {"rg","--files","--hidden","-g","!.git"}})<CR>',
  { noremap = true, silent = true }
)
-- Search and replace
vim.api.nvim_set_keymap("n", "<leader>fr", ':lua require("spectre").open()<CR>', { noremap = true, silent = true })
-- Yank list
vim.api.nvim_set_keymap("n", "<leader>fp", ":Telescope yank_history<CR>", { noremap = true, silent = true })
-- Find git branches
vim.api.nvim_set_keymap("n", "<leader>fB", ":Telescope git_branches<CR>", { noremap = true, silent = true })
-- Show recent files
vim.api.nvim_set_keymap("n", "<leader>fo", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
-- Show buffer
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })
-- Show undo history
vim.api.nvim_set_keymap("n", "<leader>fu", ":Telescope undo<CR>", { noremap = true, silent = true })
-- Show keybindings
vim.api.nvim_set_keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { noremap = true, silent = true })
-- Show harpoon marks
vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope harpoon marks<CR>", { noremap = true, silent = true })
-- Show tasks
vim.api.nvim_set_keymap(
  "n",
  "<leader>ft",
  ":TodoTelescope keywords=TODO,FIX,FIXME,BUG<CR>",
  { noremap = true, silent = true }
)
-- Add current
vim.api.nvim_set_keymap("n", "<leader>ga", ":Git add %<CR>", { noremap = true, silent = true })
-- Add all
vim.api.nvim_set_keymap("n", "<leader>gA", ":Git add .<CR>", { noremap = true, silent = true })
-- Blame line
vim.api.nvim_set_keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })
-- Diff open
vim.api.nvim_set_keymap("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, silent = true })
-- Diff close
vim.api.nvim_set_keymap("n", "<leader>gD", ":DiffviewClose<CR>", { noremap = true, silent = true })
-- Show line on GitHub
vim.api.nvim_set_keymap("n", "<leader>gg", ":GHInteractive<CR>", { noremap = true, silent = true })
-- Yolo commit
vim.api.nvim_set_keymap("n", "<leader>gY", ":Git yolo<CR>", { noremap = true, silent = true })
-- Open Neogit
vim.api.nvim_set_keymap("n", "<leader>gn", ":Neogit<CR>", { noremap = true, silent = true })
-- Open LazyGit
vim.api.nvim_set_keymap(
  "n",
  "<leader>gl",
  ':!tmux split-window -Z -c "$PWD" lazygit<CR>',
  { noremap = true, silent = true }
)
-- Open Fork
vim.api.nvim_set_keymap("n", "<leader>gf", ":!fork status $PWD<CR><CR>", { noremap = true, silent = true })
-- Create new note
vim.api.nvim_set_keymap("n", "<leader>nn", ":ObsidianToday<CR>", { noremap = true, silent = true })
-- Rename note
vim.api.nvim_set_keymap("n", "<leader>nr", ":ObsidianRename<CR>", { noremap = true, silent = true })
-- Search for notes by content
vim.api.nvim_set_keymap("n", "<leader>nf", ":ObsidianSearch<CR>", { noremap = true, silent = true })
-- Colorizer
vim.api.nvim_set_keymap("n", "<leader>tc", ":ColorizerToggle<CR>", { noremap = true, silent = true })
-- Toggle DB browser
vim.api.nvim_set_keymap("n", "<leader>td", ":DBUIToggle<CR>", { noremap = true, silent = true })
-- SymbolsOutline
vim.api.nvim_set_keymap("n", "<leader>to", ":SymbolsOutline<CR>", { noremap = true, silent = true })
-- Toggle Screenkey
vim.api.nvim_set_keymap("n", "<leader>ts", ":Screenkey toggle<CR>", { noremap = true, silent = true })
-- Toggle spell highlighting
vim.api.nvim_set_keymap("n", "<leader>tS", ":set spell!<CR>", { noremap = true, silent = true })
-- Toggle line wrapping
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>set wrap!<CR>", { noremap = true, silent = true })
-- Relative line-numbers
vim.api.nvim_set_keymap("n", "<leader>tn", ":set relativenumber!<CR>", { noremap = true, silent = true })
-- Show Markdown preview
vim.api.nvim_set_keymap("n", "<leader>tm", ":MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
-- Relative line nums
vim.api.nvim_set_keymap("n", "<leader>tR", ":set norelativenumber!<CR>", { noremap = true, silent = true })
-- LSP issue viewer
vim.api.nvim_set_keymap("n", "<leader>tr", ":TroubleToggle<CR>", { noremap = true, silent = true })
-- Add to harpoon list
vim.api.nvim_set_keymap(
  "n",
  "<leader>ha",
  ':lua require("harpoon.mark").add_file()<CR>:lua vim.notify("Add file to list", "info", {title = "Harpoon"})<CR>',
  { noremap = true, silent = true }
)
-- Show harpoon list
vim.api.nvim_set_keymap(
  "n",
  "<leader>hh",
  ':lua require("harpoon.ui").toggle_quick_menu()<CR>',
  { noremap = true, silent = true }
)
-- Jump to next harpoon item in the list
vim.api.nvim_set_keymap(
  "n",
  "<leader>hn",
  ':lua require("harpoon.ui").nav_next()<CR>',
  { noremap = true, silent = true }
)
-- Jump to previous harpoon item in the list
vim.api.nvim_set_keymap(
  "n",
  "<leader>hp",
  ':lua require("harpoon.ui").nav_prev()<CR>',
  { noremap = true, silent = true }
)
