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
let g:which_key_map[';'] = [ ':Commands'                  , 'commands' ]

" deleteplit d
let g:which_key_map['d'] = [ ':bd'                        , 'delete buffer']

" Open file browser
nnoremap <leader>e :NERDTreeToggle<CR>
let g:which_key_map['e'] = [ '<Plug>NERDTreeToggle'  , 'fileTree' ]

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
nnoremap <leader>f/ :History/<CR>
nnoremap <leader>f; :Commands<CR>
nnoremap <leader>fa :Ag<CR>
nnoremap <leader>fb :BLines<CR>
nnoremap <leader>fB :Buffers<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>fC :BCommits<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fG :GFiles?<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fH :History:<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>fp :Helptags<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fs :Snippets<CR>
nnoremap <leader>fS :Colors<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fT :BTags<CR>
nnoremap <leader>fw :Windows<CR>
nnoremap <leader>fy :Filetypes<CR>
nnoremap <leader>fz :FZF<CR>

let g:which_key_map.f = {
      \ 'name' : '+find' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'r' : [':Rg'           , 'text Rg'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Tags'         , 'project tags'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" g is for git ================================================================
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gA :Git add .<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Git commit -a<CR>
nnoremap <leader>gC :Git commit -a --amend<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gD :Gdiffsplit<CR>
nnoremap <leader>gs :Gstatus<CR>

nnoremap <leader>ghil :Octo issue list<CR>
nnoremap <leader>ghpl :Octo pr list<CR>
nnoremap <leader>ghpo :Octo pr open<CR>

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
      \ 'b' : [':Git blame'                        , 'blame'],
      \ 'c' : [':Git commit -a'                    , 'commit all'],
      \ 'C' : [':Git commit -a --amend'            , 'commit amend'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
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
      \ 'n' : [':set nonumber!'          , 'line-numbers'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ 't' : [':TODOToggle'             , 'show tasks'],
      \ 'T' : [':Tags'                   , 'tag viewer'],
      \ 'q' : [':FloatermToggle'         , 'open terminal'],
      \}  

nnoremap <leader>tc :ColorizerToggle<CR>
nnoremap <leader>tn :set nonumber!<CR>
nnoremap <leader>tr :set norelativenumber!<CR>
nnoremap <leader>tg :GitGutterToggle<CR>
nnoremap <leader>tt :TODOToggle<CR>
nnoremap <leader>tT :Tags<CR>
nnoremap <leader>tq :FloatermToggle<CR>

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
