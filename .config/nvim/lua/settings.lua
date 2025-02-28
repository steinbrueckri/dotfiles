-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd -- execute Vim commands
local g = vim.g     -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local wo = vim.wo   -- windows-local options

----------------------------------------------------------
-- General
-----------------------------------------------------------
wo.cursorline = true                                            -- cursor in line
-- wo.cursorcolumn = true -- cursor in column
opt.shell = "/bin/bash"                                         -- I use fish but it slow for running internal commands
g.mapleader = " "                                               -- change leader to a space
g.maplocalleader = ","                                          -- change localleader to a comma
opt.mouse = "a"                                                 -- enable mouse support
opt.clipboard = "unnamedplus"                                   -- copy/paste to system clipboard
opt.swapfile = false                                            -- don't use swapfile
local undodir = os.getenv("HOME") .. "/tmp/undodir/"            -- undofile related
os.execute("test -d " .. undodir .. " || mkdir -p " .. undodir) -- undofile related
opt.undodir = undodir                                           -- undofile related
opt.undofile = true                                             -- undofile related
opt.undolevels = 10000                                          -- undofile related
opt.undoreload = 10000                                          -- undofile related
opt.number = true                                               -- show line number
opt.relativenumber = true                                       -- relative file numbers
opt.nu = true                                                   -- relative file numbers
opt.rnu = true                                                  -- relative file numbers
opt.showmatch = true                                            -- highlight matching parenthesis
opt.foldmethod = "marker"                                       -- enable folding (default 'foldmarker')
opt.colorcolumn = "80"                                          -- line lenght marker at 80 columns
opt.splitright = true                                           -- vertical split to the right
opt.splitbelow = true                                           -- orizontal split to the bottom
opt.ignorecase = true                                           -- ignore case letters when search
opt.smartcase = true                                            -- ignore lowercase for the whole pattern
opt.hlsearch = true                                             -- highlight searches
opt.termguicolors = true                                        -- we support termguicolors
opt.updatetime = 300                                            -- more responsiveness
opt.scrolloff = 5                                               -- scrolling "bounding"
opt.sidescrolloff = 5                                           -- scrolling "bounding"
opt.laststatus = 3                                              -- global statusline enable
opt.hidden = true                                               -- abandon buffer when unloading
opt.backup = false                                              -- some language servers dont like backup files
opt.writebackup = false                                         -- some language servers dont like backup files
opt.shortmess = vim.o.shortmess .. "c"                          -- avoid some prompts?
opt.tabstop = 2                                                 -- buffer options
opt.softtabstop = 2                                             -- implicit tab size
opt.shiftwidth = 2                                              -- another kind of stabstop
opt.expandtab = true                                            -- convert tabs to spaces
opt.autoindent = true                                           -- convert tabs to spaces
opt.signcolumn = "yes"                                          -- put numbers and signs in the same column

-----------------------------------------------------------
-- Other stuff
-----------------------------------------------------------
g.loaded_node_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
-- needed for obsidian, move to the plugin files?
opt.conceallevel = 1
