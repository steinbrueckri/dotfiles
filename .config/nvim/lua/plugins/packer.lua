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
  use 'wbthomason/packer.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'rcarriga/nvim-notify'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  use 'neovim/nvim-lspconfig'
  use 'b0o/schemastore.nvim'
  use 'onsails/lspkind-nvim'
  use 'tami5/lspsaga.nvim'
  use 'folke/lsp-trouble.nvim'
  use 'mhartington/formatter.nvim'
  use {'ms-jpq/coq_nvim', branch = 'dev'}
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {'ms-jpq/coq.thirdparty', branch = '3p'}
  use 'arouene/vim-ansible-vault'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'fhill2/telescope-ultisnips.nvim'
  use 'nvim-telescope/telescope-github.nvim'
  use 'sheerun/vim-polyglot'
  use 'TimUntersberger/neogit'
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'
  use 'iamcco/markdown-preview.nvim'
  use 'dhruvasagar/vim-table-mode'
  use 'editorconfig/editorconfig-vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'psliwka/vim-smoothie'
  use 'folke/which-key.nvim'
  use 'sotte/presenting.vim'
  use 'tpope/vim-eunuch' -- remove, rename - Vim sugar for the UNIX shell commands that need it the most
  use 'glepnir/dashboard-nvim'
  use 'ahmedkhalf/project.nvim'
  use 'ethanholz/nvim-lastplace'
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use 'norcalli/nvim-colorizer.lua'
  use 'pwntester/octo.nvim'
  use 'ruanyl/vim-gh-line'
  use {'catppuccin/nvim', as = 'catppuccin'}
  use 'dstein64/vim-startuptime'
  use 'christianrondeau/vim-base64'
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use {'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim'}
  use 'gennaro-tedesco/nvim-peekup'
  use 'kyazdani42/nvim-tree.lua'
  use 'ms-jpq/chadtree'
  use 'simrat39/symbols-outline.nvim'
  use 'mzlogin/vim-markdown-toc'
  use 'windwp/nvim-spectre'
  use 'xiyaowong/telescope-emoji.nvim'
  use 'renerocksai/telekasten.nvim'
  use {'echasnovski/mini.nvim', branch = 'stable'}
  use 'NTBBloodbath/rest.nvim'
  use 'leafOfTree/vim-matchtag'
end)
