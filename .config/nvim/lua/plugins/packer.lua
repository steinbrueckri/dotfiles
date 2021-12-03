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

  use 'kyazdani42/nvim-web-devicons'
  --- statusbar
  use 'ryanoasis/vim-devicons'
  use 'hoob3rt/lualine.nvim'
  use 'luochen1990/rainbow'
  --- toggle numbers for pair programming
  use 'jeffkreeftmeijer/vim-numbertoggle'
  --- code complition
  ------ AI auto completion
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  ------ language server support
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  ------ A light-weight lsp usein based on neovim built-in lsp with highly a performant UI.
  use 'glepnir/lspsaga.nvim'
  ------ A pretty list for showing diagnostics, references, telescope results
  use 'folke/lsp-trouble.nvim'
  ------ change surrounding
  use 'blackCauldron7/surround.nvim'
  ------ code formatter
  use 'sbdchd/neoformat'
  ------ provides automatic closing of quotes, parenthesis, brackets
  use 'windwp/nvim-autopairs'

  use {'ms-jpq/coq_nvim', branch = 'dev'}

  --- 9000+ Snippets
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
  use 'nvim-telescope/telescope-frecency.nvim'
  --- clipboard manager
  use {
    "AckslD/nvim-neoclip.lua",
    requires = {'tami5/sqlite.lua', module = 'sqlite'},
    config = function()
      require('neoclip').setup()
    end,
  }
  --- git things
  use 'sheerun/vim-polyglot'
  use 'TimUntersberger/neogit'
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'
  --- note taking
  use "oberblastmeister/neuron.nvim"
  --- misc
  -- vim-table-mode
  use 'dhruvasagar/vim-table-mode'
  --- editorconfig
  use 'editorconfig/editorconfig-vim'
  ------ show spaces and indentlines
  use {'lukas-reineke/indent-blankline.nvim'}
  ------ smooth scrolling
  use 'psliwka/vim-smoothie'
  ------ alignment usein
  use 'junegunn/vim-easy-align'
  ------ better writing
  use 'junegunn/goyo.vim'
  ------ highlight paragraph
  use 'junegunn/limelight.vim'
  ------ keymapping helper
  use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
  }
  ------ powerpoint in vim ;)
  use 'sotte/presenting.vim'
  ------ remove, rename - Vim sugar for the UNIX shell commands that need it the most
  use 'tpope/vim-eunuch'
  ------ better default start screen
  use 'glepnir/dashboard-nvim'
  ------ project manager
  use 'ahmedkhalf/project.nvim'
  ------ comment stuff out
  use 'b3nj5m1n/kommentary'
  ------ multi line courser like in sublime
  use 'mg979/vim-visual-multi'
  ------ auto save files
  use '907th/vim-auto-save'
  ------ show colors from HTML and CSS
  use 'norcalli/nvim-colorizer.lua'
  ------ markdown preview
  use 'iamcco/markdown-preview.nvim'
  ------ github things
  use 'pwntester/octo.nvim'
  ------ todos in project
  use 'Dimercel/todo-vim'
  ------ open line on github
  use 'ruanyl/vim-gh-line'
  ------ colorschema
  use 'arcticicestudio/nord-vim'
  use {'pineapplegiant/spaceduck', branch = 'main' }
  use 'srcery-colors/srcery-vim'
  ------ performance check
  use 'dstein64/vim-startuptime'
  ------ base64 support
  use 'christianrondeau/vim-base64'
  ------ k8s stuff
  use 'andrewstuart/vim-kubernetes'
  ------ HTTP client
  use 'aquach/vim-http-client'
  ------ USE HJKL
  use 'takac/vim-hardtime'
  ------ better bufferline
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  ------ better todos
  use {'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim'}
  use 'gennaro-tedesco/nvim-peekup'
  ------ filetree
  use 'kyazdani42/nvim-tree.lua'
  use 'ms-jpq/chadtree'
  ------ reload config
  use 'famiu/nvim-reload'
  ------ symbols-outline
  use 'simrat39/symbols-outline.nvim'
  ------ exec builds
  use 'CRAG666/code_runner.nvim'
  ------ md toc
  use 'mzlogin/vim-markdown-toc'
  ------ search panel
  use 'windwp/nvim-spectre'
  ------ wiki
  use 'fmoralesc/vim-pad'
  use 'ekickx/clipboard-image.nvim'
  ------ emojis
  use 'xiyaowong/telescope-emoji.nvim'
end)
