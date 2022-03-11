-----------------------------------------------------------
-- Packer configuration file
-----------------------------------------------------------

-- Plugin: which-key.nvim
-- https://github.com/folke/which-key.nvim
-----------------------------------------------------------

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

--- Plugins - install
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  --- statusbar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'luochen1990/rainbow'
  --- fancy status page
  use 'rcarriga/nvim-notify'
  --- code complition
  ------ AI auto completion
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  ------ language server support
  use 'neovim/nvim-lspconfig'
  use 'b0o/schemastore.nvim'
  use 'onsails/lspkind-nvim'
  ------ A light-weight lsp usein based on neovim built-in lsp with highly a performant UI.
  use 'tami5/lspsaga.nvim'
  ------ A pretty list for showing diagnostics, references, telescope results
  use 'folke/lsp-trouble.nvim'
  ------ code formatter
  use 'mhartington/formatter.nvim'
  ------ code completion
  use {'ms-jpq/coq_nvim', branch = 'dev'}
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {'ms-jpq/coq.thirdparty', branch = '3p'}
  --- language specific useins
  use 'towolf/vim-helm'
  use 'bagrat/vim-buffet'
  use 'arouene/vim-ansible-vault'
  --- fuzzy search
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'fhill2/telescope-ultisnips.nvim'
  use 'nvim-telescope/telescope-github.nvim'
  --- git things
  use 'sheerun/vim-polyglot'
  use 'TimUntersberger/neogit'
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'
  --- misc
  --- markdown
  use 'iamcco/markdown-preview.nvim'
  use 'dhruvasagar/vim-table-mode'
  --- editorconfig
  use 'editorconfig/editorconfig-vim'
  ---- show spaces and indentlines
  use 'lukas-reineke/indent-blankline.nvim'
  ---- smooth scrolling
  use 'psliwka/vim-smoothie'
  ---- alignment usein
  use 'junegunn/vim-easy-align'
  ---- highlight paragraph
  use 'junegunn/limelight.vim'
  ---- keymapping helper
  use 'folke/which-key.nvim'
  ---- powerpoint in vim ;)
  use 'sotte/presenting.vim'
  ---- remove, rename - Vim sugar for the UNIX shell commands that need it the most
  use 'tpope/vim-eunuch'
  ---- better default start screen
  use 'glepnir/dashboard-nvim'
  ---- project manager
  use 'ahmedkhalf/project.nvim'
  ---- save curser on the place
  use 'ethanholz/nvim-lastplace'
  ---- comment stuff out
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  ------ show colors from HTML and CSS
  use 'norcalli/nvim-colorizer.lua'
  ------ github things
  use 'pwntester/octo.nvim'
  ------ open line on github
  use 'ruanyl/vim-gh-line'
  ------ colorschema
  use {'catppuccin/nvim', as = 'catppuccin'}
  ------ performance check
  use 'dstein64/vim-startuptime'
  ------ base64 support
  use 'christianrondeau/vim-base64'
  ------ better bufferline
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  ------ better todos
  use {'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim'}
  use 'gennaro-tedesco/nvim-peekup'
  ------ filetree
  use 'kyazdani42/nvim-tree.lua'
  use 'ms-jpq/chadtree'
  ------ symbols-outline
  use 'simrat39/symbols-outline.nvim'
  ------ md toc
  use 'mzlogin/vim-markdown-toc'
  ------ search panel
  use 'windwp/nvim-spectre'
  ------ wiki
  use 'fmoralesc/vim-pad'
  use 'ekickx/clipboard-image.nvim'
  ------ emojis
  use 'xiyaowong/telescope-emoji.nvim'
  ------ cheatsheet
  use 'sudormrfbin/cheatsheet.nvim'
  ------ zettelkasten
  use 'renerocksai/telekasten.nvim'
  ---- Collection of minimal, independent, and fast Lua modules dedicated to improve Neovim
  use {'echasnovski/mini.nvim', branch = 'stable'}
end)
