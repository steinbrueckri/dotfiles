-----------------------------------------------------------
-- Which-key configuration file
-----------------------------------------------------------

-- Plugin: which-key.nvim
-- https://github.com/folke/which-key.nvim
-----------------------------------------------------------

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
  ["<esc>"] = { ":noh<cr>", "clear search highlight"},
  ["<leader><Up>"] = { ":wincmd k<cr>", "goto split" },
  ["<leader><Down>"] = { ":wincmd j<cr>", "goto split" },
  ["<leader><Left>"] = { ":wincmd h<cr>", "goto split" },
  ["<leader><Right>"] = { ":wincmd l<cr>", "goto split" },
  ["<Tab>"] = { ":bn<cr>", "Next buffer" },
  ["<S-Tab>"] = { ":bp<cr>", "Previous buffer" },
  ["<leader>-"] = { ":e#<cr>", "jump to previous file" },
  ["<leader>w"] = { ":Bw<cr>", "Write buffer" },
  ["<leader>T"] = { ":terminal<cr>", "open terminal" },
  ["<leader>r"] = { ":call VisualSelection('replace', '')<cr>", "replace selected text" },
  ["<leader>;"] = { ":Telescope commands<cr>", "commands" },
  ["<leader>d"] = { ":bd<cr>", "delete buffer" },
  ["<leader>q"] = { ":bdelete<cr>", "close buffer" },
  ["<leader>Q"] = { ":bd!<cr>", "delete buffer" },
  ["<leader>e"] = { ":NvimTreeRefresh<cr>:NvimTreeToggle<cr>", "FileBrowser" },
  ["<leader>S"] = { ":Dashboard<cr>", "Open Dashboard" },
  ["<leader>v"] = { ":vsplit<cr>", "Split right" },
  ["<leader>n"] = { ":new<cr>", "New File" },
  ["<leader>w"] = { ":w<cr>", "Save"},
  ["<leader>W"] = { ":wq<cr>", "Save and close"},
  ["zz"]        = { ":Telescope spell_suggest<cr>", "spell suggest"}
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
      e = {':e! ~/.config/nvim/init.lua<cr>'       , 'edit config'},
      r = {':Reload<cr>'                           , 'reload config'},
    },
    f = {
      name = "+find",
      C = {':Telescope commands<cr>'               , 'commands'},
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
      B = {':Telescope git_branches<cr>'           , 'branches'},
      b = {':Gitsigns blame_line<cr>'              , 'blame_line'},
      d = {':DiffviewOpen<cr>'                     , 'diff'},
      D = {':Gdiffsplit<cr>'                       , 'diff split'},
      g = {':GHInteractive<cr>'                    , 'show line on github'},
      s = {':Telescope git_status<cr>'             , 'status'},
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
      s = {':SymbolsOutline<cr>'         , 'SymbolsOutline'},
      S = {':set spell!<cr>'             , 'toggle spell highlighting'},
      n = {':set relativenumber!<cr>'    , 'relative line-numbers'},
      m = {':MarkdownPreviewToggle<cr>'  , 'Show Markdown preview'},
			h = {':HardTimeToggle<cr>'				 , 'Toggle hjkl'},
      R = {':set norelativenumber!<cr>'  , 'relative line nums'},
      T = {':TodoTelescope'              , 'show tasks'},
      r = {':LspTroubleToggle<cr>'       , 'LSP Issue viewer'},
      q = {':FloatermToggle<cr>'         , 'open terminal'},
      i = {':IndentLinesToggle<cr>'      , 'Show indentLine'},
      t = {':TableModeToggle<cr>'        , 'TableModeToggle'},
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
