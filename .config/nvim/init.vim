""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   TODOs                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" - Terraform format key binding?
" - Git Checkout binding is missing as key binding
" - Fix scratchys - can not save, GitHub issue is open
" - Make use of vimwiki

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   source                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/keybindings.vim
source $HOME/.config/nvim/functions.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  settings                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://stackoverflow.com/questions/9701366/vim-backspace-leaves
noremap! <C-?> <C-h>

set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:true
let g:compe.source.treesitter = v:true

let g:compe.source.tabnine = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" == Floting term
let g:floaterm_autoclose = 1

" == Whishkey
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" == General settings
syntax on
set relativenumber
set number
set encoding=UTF-8
set cursorline
set smartindent
set autoindent
set wildmenu
set spelllang=en_us
set spell
set autoread
set hls is "Making sure search highlights works as we type them"
set clipboard+=unnamedplus " make the clipboard work again!
set mouse=a
set timeoutlen=500
" === luochen1990/rainbow
let g:rainbow_active = 1
" === Git blamer settings
let g:gitblame_enabled = 1
" === NEARDTree settings
let NERDTreeQuitOnOpen = 1 " automatically close NerdTree when you open a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1

" === Git gutter settings
set updatetime=100

" === Vim buffer settings
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_use_devicons = 1

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme spaceduck
let g:auto_save = 1  " enable AutoSave on Vim startup

" ACK
let g:ackprg = 'ag --vimgrep --smart-case'
let g:ack_apply_lmappings = 1
let g:ack_autoclose = 1

" Gutentages
let g:gutentags_ctags_tagfile = ".tags"
let g:gutentags_cache_dir = "~/tmp"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/tmp/.undodir
    set undofile
catch
endtry

let delimitMate_expand_cr = 1

" mtth/scratch.vim
let g:scratch_persistence_file = "~/.scratchys/new.txt"

let g:deoplete#enable_at_startup = 1

let g:UltiSnipsExpandTrigger="<c-c>"

" LSP
lua << EOF

require('lspconfig').efm.setup({
 cmd = {"efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "1" },
 filetypes = {"sh","yaml","markdown"},
 settings = {
   languages = {
     sh = {
         {
             LintCommand = 'shellcheck -f gcc -x',
             lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
         },
         {
           formatCommand = 'shfmt -ci -s -bn',
           formatStdin = true
         }
     },
     yaml = {
         {
            lintCommand = "yamllint -f parsable -",
            lintStdin = true,
        }
     },
     markdown = {
         {
            lintCommand = "mdl -",
            lintStdin = true,
        }
     },
   }
 }
})

require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.kotlin_language_server.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.solargraph.setup{}
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF

let s:startify_ascii_header = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \]
let g:startify_custom_header = map(s:startify_ascii_header +
        \ startify#fortune#quote(), '"   ".v:val')

let g:notes_directories = ['~/OneDrive\ -\ MediaMarktSaturn/VimNotes']

" autoformat on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

"
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 1

let g:spaceline_seperate_style = 'arrow'
