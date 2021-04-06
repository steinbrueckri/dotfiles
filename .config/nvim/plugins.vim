" === Plugins =================================================================

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
" file tree - replace later with kyazdani42/nvim-tree.lua
Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
" statusbar
Plug 'ryanoasis/vim-devicons'
Plug 'glepnir/spaceline.vim'
Plug 'luochen1990/rainbow'
" better tag handling
Plug 'ludovicchabant/vim-gutentags'
" code complition
"" snippet support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'norcalli/snippets.nvim'
"" AI auto completion
Plug 'hrsh7th/nvim-compe'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
"" language server support
Plug 'neovim/nvim-lspconfig'
"" A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.  
Plug 'glepnir/lspsaga.nvim'
"" change surrounding
Plug 'tpope/vim-surround'
"" build systems
Plug 'AlxHnr/build.vim'
"" code formatter
Plug 'sbdchd/neoformat'
"" provides automatic closing of quotes, parenthesis, brackets
Plug 'Raimondi/delimitMate'
" language specific plugins
Plug 'pearofducks/ansible-vim'
Plug 'hashivim/vim-terraform'
Plug 'towolf/vim-helm'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'bagrat/vim-buffet'
Plug 'editorconfig/editorconfig-vim'
" fuzzy search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'mileszs/ack.vim'
" git things
Plug 'f-person/git-blame.nvim'
Plug 'vim-scripts/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }
" misc
"" show spaces and indentlines
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
"" themes
Plug 'joshdick/onedark.vim'
"" terminal
Plug 'voldikss/vim-floaterm'
"" smooth scrolling
Plug 'psliwka/vim-smoothie'
"" change root to file directory
Plug 'airblade/vim-rooter'
"" better writing
Plug 'junegunn/goyo.vim'
"" highlight paragraph
Plug 'junegunn/limelight.vim'
"" keymapping helper
Plug 'liuchengxu/vim-which-key'
"" powerpoint in vim ;)
Plug 'sotte/presenting.vim'
"" better tabs in neovim (required nightly build of neovim)
Plug 'romgrk/barbar.nvim'
"" remove, rename - Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-eunuch'
"" better default start screen
Plug 'mhinz/vim-startify'
"" most Recently Used 
Plug 'yegappan/mru'
"" comment stuff out
Plug 'tpope/vim-commentary'
"" multi line courser like in sublime
Plug 'mg979/vim-visual-multi'
"" auto save files
Plug '907th/vim-auto-save'
"" show colors from HTML and CSS
Plug 'norcalli/nvim-colorizer.lua'
"" better buffer and tab managment
Plug 'markcornick/vim-bats'
"" make scratch files like in intelij
Plug 'mtth/scratch.vim'
"" markdown preview
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
"" github things
Plug 'pwntester/octo.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"" Notes
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
"" slides for vim
Plug 'sotte/presenting.vim'
"" todos in project
Plug 'Dimercel/todo-vim'
"" open line on github
Plug 'ruanyl/vim-gh-line'
"" colorschema
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
"" glow preview
Plug 'npxbr/glow.nvim'
call plug#end()
