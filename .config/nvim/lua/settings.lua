-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-----------------------------------------------------------
-- Custom Keybindings
-----------------------------------------------------------
vim.api.nvim_set_keymap("i", "jk", "<esc>", {noremap = true})

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd     				-- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       				-- call Vim functions
local g = vim.g         				-- global variables
local opt = vim.opt         		-- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = ' '             -- change leader to a space
g.maplocalleader = ','        -- change localleader to a comma
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile

cmd('language en_US.utf-8')   -- set language to english
cmd('syntax on')              -- enable syntax highlighting

-- undofile
local undodir = os.getenv('HOME') .. '/tmp/undodir/'
os.execute('test -d ' .. undodir .. ' || mkdir -p ' .. undodir)
opt.undodir = undodir
opt.undofile = true
opt.undolevels = 10000
opt.undoreload = 10000

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true             -- show line number
opt.relativenumber = true     -- relative file numbers
opt.nu = true                 -- relative file numbers
opt.rnu = true                -- relative file numbers
opt.showmatch = true          -- highlight matching parenthesis
opt.foldmethod = 'marker'     -- enable folding (default 'foldmarker')
opt.colorcolumn = '80'        -- line lenght marker at 80 columns
opt.splitright = true         -- vertical split to the right
opt.splitbelow = true         -- orizontal split to the bottom
opt.ignorecase = true         -- ignore case letters when search
opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.hlsearch = true           -- highlight searches
opt.termguicolors = true      -- we support termguicolors
opt.cmdheight = 2             -- more space for coc messages
opt.updatetime = 300          -- more responsiveness
opt.scrolloff = 5             -- scrolling "bounding"
opt.sidescrolloff = 5         -- scrolling "bounding"

-- remove whitespace on save
cmd[[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-- relative in normal mode, absolute in insert
--af('BufEnter,FocusGained,InsertLeave', '*', function() vim.wo.relativenumber = true end)
--af('BufLeave,FocusLost,InsertEnter',   '*', function() vim.wo.relativenumber = false end)

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.background = "dark"       -- set colorschema
cmd([[colorscheme nord]])     -- set colorschema

----------------------------------------------------------------------------------------------------------------------
-- _ | _|
--(_)|(_|
----------------------------------------------------------------------------------------------------------------------



opt.hidden = true -- abandon buffer when unloading

opt.backup = false      -- some language servers dont like backup files
opt.writebackup = false -- some language servers dont like backup files

opt.shortmess = vim.o.shortmess .. 'c' -- avoid some prompts?


-- buffer options
opt.tabstop = 2

-- implicit tab size
opt.softtabstop = 2

-- another kind of stabstop
opt.shiftwidth = 2

-- convert tabs to spaces
opt.expandtab = true
opt.autoindent = true

-- put numbers and signs in the same column
opt.signcolumn = 'number'
