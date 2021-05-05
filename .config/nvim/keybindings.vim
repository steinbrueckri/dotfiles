" === Key-Bindings ============================================================
" === general settings ========================================================
" Set leader on SPACE
let mapleader=" "
nnoremap <SPACE> <Nop>

" Set localleader to ,
let maplocalleader = ','

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>

" === bindings without leader =================================================
" Next buffer
noremap <Tab> :bn<CR>
" Previous buffer
noremap <S-Tab> :bp<CR>

" === lsp Key-Bindings ========================================================
noremap gd :lua vim.lsp.buf.declaration()<CR>
noremap gD :lua vim.lsp.buf.definition()<CR>
noremap x :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" <cmd>lua vim.lsp.buf.signature_help()<CR>
" <cmd>lua vim.lsp.buf.rename()<CR>

" === whichkey settings =======================================================
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" markdown preview
nmap <silent> <Leader>mp :Glow %<CR>
let g:which_key_map['mp'] = [ ':Glow %', 'MarkdownPreview' ]

" Split navigation
nmap <silent> <Leader><Up> :wincmd k<CR>
let g:which_key_map['<Up>'] = [ ':wincmd k', 'goto split' ]

nmap <silent> <Leader><Down> :wincmd j<CR>
let g:which_key_map['<Down>'] = [ ':wincmd j', 'goto split' ]

nmap <silent> <Leader><Left> :wincmd h<CR>
let g:which_key_map['<Left>'] = [ ':wincmd h', 'goto split' ]

nmap <silent> <Leader><Right> :wincmd l<CR>
let g:which_key_map['<Right>'] = [ ':wincmd l', 'goto split' ]

" Start build
noremap <Leader>b :Build<CR>
let g:which_key_map['b'] = [ ':Build', 'start build' ]

" Quick close and save
noremap <Leader><Tab> :Bw<CR>
let g:which_key_map['<Tab>'] = [ ':Bw', 'write buffer' ]

" Quick close and save force! 
noremap <Leader><S-Tab> :Bw!<CR>
let g:which_key_map['<S-Tab>'] = [ ':Bw!', 'write buffer!' ]

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" make new scratch file, like in intelij
let g:which_key_map['_'] = [ ':Scratch'                 , 'new scratchy' ]

let g:which_key_map['-'] = [ '<c-^>'                    , 'go back' ]
nnoremap <leader>- <c-^><cr>

" show all command
let g:which_key_map[';'] = [ ':Telescope commands'                  , 'commands' ]

" deleteplit d
let g:which_key_map['d'] = [ ':bd', 'delete buffer']

" Open file browser
nnoremap <leader>e :Telescope file_browser<CR>
let g:which_key_map['e'] = [ ':Telescope file_browser', 'Explorer' ]

" Q = quit
nnoremap <leader>q :bd<CR>
let g:which_key_map['q'] = [ ':bd', 'buffer delete' ]

" open startscreen
noremap <Leader>S :Startify<CR>
let g:which_key_map['S'] = [ ':Startify', 'start screen' ]

" work with splits
let g:which_key_map['v'] = [ '<C-W>vsplit', 'split right']
let g:which_key_map['h'] = [ '<C-W>split', 'split below']

" start zen mode, open Goyo
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen' ]
nnoremap <leader>z :Goyo<CR>

" New file
let g:which_key_map['n'] = [ ':tabnew new.txt', 'new file' ]
noremap <leader>n :tabnew new.txt<CR>

" New notebook file
let g:which_key_map['N'] = [ ':Notes', 'new notebook' ]
noremap <leader>N :Note<CR>

" c is for config =============================================================
" open nvim config
map <leader>ce :e! ~/.config/nvim/init.vim<cr>
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
" Reload vim config
nnoremap <leader>cr :source $MYVIMRC<CR>

let g:which_key_map.c = {
      \ 'name' : '+config' ,
      \ 'e' : [':History/'       , 'edit config'],
      \ 'r' : [':source $MYVIMRC', 'reload config'],
      \ }

" f is for find ===============================================================
nnoremap <leader>f; :Telescope commands<CR>
nnoremap <leader>fa :Telescope live_grep<CR>
nnoremap <leader>fB :Telescope buffers<CR>
nnoremap <leader>fc :Telescope commits<CR>
nnoremap <leader>fd :Telescope lsp_workspace_symbols<CR>  
nnoremap <leader>ff :Telescope files find_command=rg,--files,--hidden,--no-ignore<CR>
nnoremap <leader>fg :Telescope git_files<CR>
nnoremap <leader>fG :Telescope git_status<CR>
nnoremap <leader>fh :Telescope command_history<CR>
nnoremap <leader>fm :Telescope marks<CR>
nnoremap <leader>fs :Telescope ultisnips<CR>
nnoremap <leader>fS :Telescope colorschema<CR>
nnoremap <leader>fi :Telescope gh issues<CR>
nnoremap <leader>fp :Telescope gh pull_requests<CR>
nnoremap <leader>ft :Telescope tags<CR>
nnoremap <leader>fz :FZF<CR>

let g:which_key_map.f = {
      \ 'name' : '+find' ,
      \ ';' : [':Telescope commands'             , 'commands'],
      \ 'a' : [':Telescope live_grep'            , 'grep over all'],
      \ 'B' : [':Telescope buffers'              , 'open buffers'],
      \ 'c' : [':Telescope commits'              , 'commits'],
      \ 'd' : [':Telescope lsp_workspace_symbols' , 'lsp_workspace_symbols'],
      \ 'f' : [':Telescope find_files find_command=rg,--files,--hidden,--no-ignore', 'files'],
      \ 'g' : [':Telescope git_files'            , 'git files'],
      \ 'G' : [':Telescope git_status'           , 'modified git files'],
      \ 'h' : [':Telescope command_history'      , 'command history'],
      \ 'm' : [':Telescope marks'                , 'marks'] ,
      \ 's' : [':Telescope ultisnips'            , 'snippets'],
      \ 'S' : [':Telescope colorschema'          , 'color schemes'],
      \ 't' : [':Telescope tags'                 , 'project tags'],
      \ 'i' : [':Telescope gh issues'            , 'github issues'],
      \ 'p' : [':Telescope gh pull_requests'     , 'github PRs'],
      \ 'z' : [':Telescope'                      , 'Telescope commands'],
      \ }

" g is for git ================================================================
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gA :Git add .<CR>
nnoremap <leader>gb :Telescope git_branches<CR>
nnoremap <leader>gc :Git commit -a<CR>
nnoremap <leader>gC :Git commit -a --amend<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gD :Gdiffsplit<CR>
nnoremap <leader>gs :Gstatus<CR>

nnoremap <leader>ghil :Octo issue list<CR>
nnoremap <leader>ghpl :Octo pr list<CR>
nnoremap <leader>ghpo :Octo pr open<CR>

nnoremap <leader>gg :GHInteractive<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gP :Git pull<CR>
nnoremap <leader>gf :Git fetch<CR>
nnoremap <leader>gY :Git yolo<CR>
nnoremap <leader>g# :LazyGit<CR>

let g:which_key_map.gh = {
      \ 'name' : '+hub' ,
      \ 'il' : [':Octo issue list'                , 'GitHub issue list'],
      \ 'pl' : [':Octo pr list'                   , 'GitHub Pull request list'],
      \ 'po' : [':Octo pr open'                   , 'GitHub Pull request open'],
      \ }

let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add %'                        , 'add current'],
      \ 'A' : [':Git add .'                        , 'add all'],
      \ 'b' : [':Telescope git_branches'             , 'branches'],
      \ 'c' : [':Git commit -a'                    , 'commit all'],
      \ 'C' : [':Git commit -a --amend'            , 'commit amend'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'g' : [':GHInteractive'                    , 'show line on github'],
      \ 's' : [':Gstatus'                          , 'status'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'f' : [':Git fetch'                        , 'fetch'],
      \ 'Y' : [':Git yolo'                         , 'yolo commit'],
      \ '#' : [':LazyGit'                          , 'LazyGit'],
      \ }

" l is for language server protocol ===========================================

let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ }

" t is for toggle
" =============================================================================
let g:which_key_map.t = {
      \ 'name' : '+toggle' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'n' : [':set relativenumber!'    , 'relative line-numbers'],
      \ 'm' : [':Glow'                   , 'Show Glow preview'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ 't' : [':TODOToggle'             , 'show tasks'],
      \ 'T' : [':Tags'                   , 'tag viewer'],
      \ 'q' : [':FloatermToggle'         , 'open terminal'],
      \ 'i' : [':IndentLinesToggle'      , 'Show indentLine'],
      \}  

nnoremap <leader>tc :ColorizerToggle<CR>
nnoremap <leader>tn :set nonumber!<CR>
nnoremap <leader>tm :Glow<CR>
nnoremap <leader>tr :set relativenumber!<CR>
nnoremap <leader>tg :GitGutterToggle<CR>
nnoremap <leader>tt :TODOToggle<CR>
nnoremap <leader>tT :Tags<CR>
nnoremap <leader>tq :FloatermToggle<CR>
nnoremap <leader>ti :IndentLinesToggle<CR>

" p is for presentation
" =============================================================================
let g:which_key_map.p = {
      \ 'name' : '+presentation' ,
      \ 's' : [':PresentingStart'          , 'PresentingStart'],
      \ 'b' : [':set nonumber!'            , 'Ascii border'],
      \ 'f' : [':.!figlet'                 , 'Ascii font - figlet'],
      \ 't' : [':.!toilet -w 200'          , 'Ascii font - toilet'],
      \ }

" start presenting
nmap <leader>ps :PresentingStart<CR>
" makes Ascii art font
nmap <leader>pt :.!toilet -w 200<CR>
nmap <leader>pf :.!figlet<CR>
" makes Ascii border
nmap <leader>pb :.!toilet -w 20::wq0 -f term -F border<CR>

call which_key#register('<Space>', "g:which_key_map")
