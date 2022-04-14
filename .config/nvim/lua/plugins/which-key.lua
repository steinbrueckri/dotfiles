-----------------------------------------------------------
-- Which-key configuration file
-----------------------------------------------------------

-- Plugin: which-key.nvim
-- https://github.com/folke/which-key.nvim
-----------------------------------------------------------

require("which-key").setup {}

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
  ["gW"]              = { ":!open https://www.google.com/search?q=<cWORD><cr>" ,"Search for word on cursor"},
  ["gF"]              = { ":e <cfile><cr>", "create and goto file" },
  ["<esc>"]           = { ":noh<cr>", "clear search highlight"},
  ["<leader><Up>"]    = { ":wincmd k<cr>", "goto split" },
  ["<leader><Down>"]  = { ":wincmd j<cr>", "goto split" },
  ["<leader><Left>"]  = { ":wincmd h<cr>", "goto split" },
  ["<leader><Right>"] = { ":wincmd l<cr>", "goto split" },
  ["<Tab>"]           = { ":bn<cr>", "Next buffer" },
  ["<S-Tab>"]         = { ":bp<cr>", "Previous buffer" },
  ["<leader>-"]       = { ":e#<cr>", "jump to previous file" },
  ["<leader>T"]       = { ":ToggleTerm<cr>", "open terminal" },
  ["<leader>;"]       = { ":Telescope commands<cr>", "commands" },
  ["<leader>d"]       = { ":bd<cr>", "delete buffer" },
  ["<leader>q"]       = { ":bdelete<cr>", "close buffer" },
  ["<leader>Q"]       = { ":bd!<cr>", "delete buffer" },
  ["<leader>e"]       = { ":CHADopen<cr>", "Show the file in the tree" },
  ["<leader>S"]       = { ":Alpha<cr>", "Open Dashboard" },
  ["<leader>v"]       = { ":vsplit<cr>", "Split right" },
  ["<leader>w"]       = { ":w<cr>", "Save"},
  ["Z"]               = { ":Telescope spell_suggest<cr>", "spell suggest"},
  ["<c-k>"]           = { ":lua vim.lsp.buf.hover()<cr>", "Show LSP Help"},
  ["U"]               = { ":redo<cr>", "Redo"}
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
      e = {':cd ~/.config/nvim/ | edit init.lua<cr>' , 'edit config'},
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
      r = {':Telescope frecency<cr>'               , 'any recent files'},
      R = {':lua require("spectre").open()<cr>'    , 'Search and Replace'},
      g = {':Telescope git_files<cr>'              , 'git files'},
      G = {':Telescope git_status<cr>'             , 'modified git files'},
      h = {':Telescope command_history<cr>'        , 'command history'},
      m = {':Telescope marks<cr>'                  , 'marks'},
      S = {':Telescope colorschema<cr>'            , 'color schemes'},
      t = {':Telescope tags<cr>'                   , 'project tags'},
      I = {':Telescope gh issues<cr>'              , 'github issues'},
      P = {':Telescope gh pull_requests<cr>'       , 'github PRs'},
			p = {':Telescope projects<cr>'               , 'find projects'},
    },
    h = {
      name = "+http",
      r  = {'<Plug>RestNvim<cr>'                   , 'run the request under the cursor'},
      p = {'<Plug>RestNvimPreview<cr>'            , 'preview the request cURL command'},
    },
    g = {
      name = "+git",
      a = {':Git add %<cr>'                        , 'add current'},
      A = {':Git add .<cr>'                        , 'add all'},
      B = {':Telescope git_branches<cr>'           , 'branches'},
      b = {':Gitsigns blame_line<cr>'              , 'blame_line'},
      d = {':DiffviewOpen<cr>'                     , 'diff open'},
      D = {':DiffviewClose<cr>'                    , 'diff close'},
      g = {':GHInteractive<cr>'                    , 'show line on github'},
      s = {':Telescope git_status<cr>'             , 'status'},
      Y = {':Git yolo<cr>'                         , 'yolo commit'},
			n = {':Neogit<cr>'                           , 'Open Neogit'},
      l = {':LazyGit<cr>'                          , 'LazyGit'},
    },
    gh = {
      name = "+GitHub",
      il = {':Octo issue list<cr>'                , 'GitHub issue list'},
      pl = {':Octo pr list<cr>'                   , 'GitHub Pull request list'},
      po = {':Octo pr open<cr>'                   , 'GitHub Pull request open'},
    },
    n = {
      name = "+Notes",
      f = {':lua require("telekasten").search_notes()<cr>'            , 'Search for Notes by name'},
      n = {':lua require("telekasten").new_note()<cr>'                , 'Create new Note'},
      t = {':lua require("telekasten").goto_today()<cr>'              , 'Create / edit todays Notes'},
      w = {':lua require("telekasten").goto_thisweek()<cr>'           , 'Create / edit week Notes'},
      N = {':lua require("telekasten").new_templated_note()<cr>'      , 'Create new Template Note'}
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
      R = {':set norelativenumber!<cr>'  , 'relative line nums'},
      T = {':TodoTelescope<cr>'          , 'show tasks'},
      r = {':LspTroubleToggle<cr>'       , 'LSP Issue viewer'},
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
