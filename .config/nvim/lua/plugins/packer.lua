local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
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
  use 'nvim-telescope/telescope-packer.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-github.nvim'
  use 'sheerun/vim-polyglot'
  use 'TimUntersberger/neogit'
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use 'dhruvasagar/vim-table-mode'
  use 'editorconfig/editorconfig-vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'psliwka/vim-smoothie'
  use 'folke/which-key.nvim'
  use 'sotte/presenting.vim'
  use 'tpope/vim-eunuch' -- remove, rename - Vim sugar for the UNIX shell commands that need it the most
  use 'goolord/alpha-nvim'
  use 'ahmedkhalf/project.nvim'
  use 'ethanholz/nvim-lastplace'
  use 'numToStr/Comment.nvim'
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
  use 'lewis6991/impatient.nvim'
  use 'gbprod/yanky.nvim'
  use 'pianocomposer321/yabs.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
