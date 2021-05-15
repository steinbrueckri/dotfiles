" === Key-Bindings ============================================================
" === general settings ========================================================
" Set leader on SPACE
let mapleader=" "
nnoremap <SPACE> <Nop>

" Set localleader to ,
let maplocalleader = ','

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>

lua << EOF

--- visual mappings

local wkv = require("which-key")

opts = {
  	mode = "v", -- VISUAL mode
	}
mappings = {
	["<leader>bu"] = { ":<c-u>call base64#v_atob()<cr>", "base64 crypt"},
	["<leader>bc"] = { ":<c-u>call base64#v_btoa()<cr>", "base64 decrypt"},
}
wkv.register(mappings, opts)

--- single mappings

local wk = require("which-key")

wk.register({
  ["gF"] = { ":e <cfile><cr>", "create and goto file" },
  ["<leader><Up>"] = { ":wincmd k<cr>", "goto split" },
  ["<leader><Down>"] = { ":wincmd j<cr>", "goto split" },
  ["<leader><Left>"] = { ":wincmd h<cr>", "goto split" },
  ["<leader><Right>"] = { ":wincmd l<cr>", "goto split" },
  ["<Tab>"] = { ":bn<cr>", "Next buffer" },
  ["<leader>-"] = { ":e#<cr>", "jump to previous file" },
  ["<S-Tab>"] = { ":bp<cr>", "Previous buffer" },
  ["<leader>w"] = { ":Bw<cr>", "Write buffer" },
  ["<leader>T"] = { ":terminal<cr>", "open terminal" },
  ["<leader>r"] = { ":call VisualSelection('replace', '')<cr>", "replace selected text" },
  ["<leader>;"] = { ":Telescope commands<cr>", "commands" },
  ["<leader>d"] = { ":bd<cr>", "delete buffer" },
  ["<leader>q"] = { ":bd<cr>", "delete buffer" },
  ["<leader>Q"] = { ":bd!<cr>", "delete buffer" },
  ["<leader>e"] = { ":Telescope file_browser<cr>", "FileBrowser" },
  ["<leader>q"] = { ":bd<cr>", "buffer delete" },
  ["<leader>S"] = { ":Startify<cr>", "Open Startscreen" },
  ["<leader>v"] = { ":vsplit<cr>", "Split right" },
  ["<leader>h"] = { ":split<cr>", "Split below" },
  ["<leader>n"] = { ":new<cr>", "New File" },
  ["<leader>N"] = { ":tabnew new.txt<cr>", "New File" },
  ["<leader>z"] = { ":Goyo<cr>", "ZenMode" }
})

--- group mappings

wk.register({
  ["<leader>"] = {
		a = {
			name = "+ansible",
			v = {':AnsibleVault<cr>', 'ansible vault'},
			u = {':AnsibleUnvault<cr>', 'ansible unvault'},
		},
    c = {
      name = "+config",
      e = {':e! ~/.config/nvim/init.vim<cr>'       , 'edit config'},
      r = {':source $MYVIMRC<cr>'                  , 'reload config'},
    },
    f = {
      name = "+find",
      C = {':Telescope commands<cr>'             , 'commands'},
      a = {':Telescope live_grep<cr>'              , 'grep over all'},
      B = {':Telescope buffers<cr>'                , 'open buffers'},
      c = {':Telescope commits<cr>'                , 'commits'},
      d = {':Telescope lsp_workspace_symbols<cr>'  , 'lsp_workspace_symbols'},
      f = {':Telescope find_files find_command=rg,--files,--hidden,--no-ignore<cr>', 'files'},
      g = {':Telescope git_files<cr>'              , 'git files'},
      G = {':Telescope git_status<cr>'             , 'modified git files'},
      h = {':Telescope command_history<cr>'        , 'command history'},
      m = {':Telescope marks<cr>'                  , 'marks'},
      s = {':Telescope ultisnips<cr>'              , 'snippets'},
      S = {':Telescope colorschema<cr>'            , 'color schemes'},
      t = {':Telescope tags<cr>'                   , 'project tags'},
      I = {':Telescope gh issues<cr>'              , 'github issues'},
      P = {':Telescope gh pull_requests<cr>'       , 'github PRs'},
			p = {":lua require'telescope'.extensions.project.project{}<cr>", 'find projects'},
    },
    g = {
      name = "+git",
      a = {':Git add %<cr>'                        , 'add current'},
      A = {':Git add .<cr>'                        , 'add all'},
      b = {':Telescope git_branches<cr>'           , 'branches'},
      c = {':Git commit -a<cr>'                    , 'commit all'},
      C = {':Git commit -a --amend<cr>'            , 'commit amend'},
      d = {':DiffviewOpen<cr>'                     , 'diff'},
      D = {':Gdiffsplit<cr>'                       , 'diff split'},
      g = {':GHInteractive<cr>'                    , 'show line on github'},
      s = {':Gstatus<cr>'                          , 'status'},
      l = {':Git log<cr>'                          , 'log'},
      p = {':Git push<cr>'                         , 'push'},
      P = {':Git pull<cr>'                         , 'pull'},
      f = {':Git fetch<cr>'                        , 'fetch'},
      Y = {':Git yolo<cr>'                         , 'yolo commit'},
			n = {':Neogit<cr>'                           , 'Open Neogit'},
      L = {':LazyGit<cr>'                          , 'LazyGit'},
    },
    gh = {
      name = "+GitHub",
      il = {':Octo issue list<cr>'                , 'GitHub issue list'},
      pl = {':Octo pr list<cr>'                   , 'GitHub Pull request list'},
      po = {':Octo pr open<cr>'                   , 'GitHub Pull request open'},
    },
    l = {
      name = "+LSP",
    },
    t = {
      name = "+toggle",
      c = {':ColorizerToggle<cr>'        , 'colorizer'},
      n = {':set relativenumber!<cr>'    , 'relative line-numbers'},
      m = {':Glow<cr>'                   , 'Show Glow preview'},
      g = {':GitGutterToggle<cr>'        , 'GitGutterToggle'},
			h = {':HardTimeToggle<cr>'				 , 'Toggle hjkl'},
      r = {':set norelativenumber!<cr>'  , 'relative line nums'},
      T = {':Telescope quickfix'         , 'show tasks'},
      t = {':LspTroubleToggle<cr>'       , 'LSP Issue viewer'},
      q = {':FloatermToggle<cr>'         , 'open terminal'},
      i = {':IndentLinesToggle<cr>'      , 'Show indentLine'},
    },
    p = {
      name = "+presentation",
      s = {":PresentingStart<cr>", "PresentingStart"},
      b = {":.!toilet -w 20::wq0 -f term -F border<cr>", "Ascii border"},
      f = {':.!figlet<cr>', 'Ascii font - figlet'},
      t = {':.!toilet -w 200<cr>', 'Ascii font - toilet'}
    }
  }
})
EOF
