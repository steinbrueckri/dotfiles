------------------------------------------------------------------------
--                              settings                              --
------------------------------------------------------------------------

-- load helper
af = require('autofunc')
bo = require('bufopt')

-- undofile
local undodir = os.getenv('HOME') .. '/tmp/undodir/'
os.execute('test -d ' .. undodir .. ' || mkdir -p ' .. undodir)
vim.o.undodir = undodir
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.undoreload = 10000

-- enable syntax highlighting
vim.cmd('syntax on')

-- set language to english
vim.cmd('language en_US.utf-8')

-- enable mouse support
vim.api.nvim_command('set mouse=a')

-- set colorschema
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme nord]])

-- split a new buffer to the right
vim.o.splitright = true

-- split new buffer to the bottom
vim.o.splitbelow = true

-- briefly jump to matching seperator
vim.o.showmatch = true

-- case insensitive search
vim.o.ignorecase = true

-- highlight searches
vim.o.hlsearch = true

-- copy-paste with system clipboard
vim.o.clipboard = 'unnamedplus'

-- we support termguicolors
vim.o.termguicolors = true

-- abandon buffer when unloading
vim.o.hidden = true

-- some language servers dont like backup files
vim.o.backup = false
vim.o.writebackup = false

-- more space for coc messages
vim.o.cmdheight = 2

-- more responsiveness
vim.o.updatetime = 300

-- avoid some prompts?
vim.o.shortmess = vim.o.shortmess .. 'c'

-- scrolling "bounding"
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5

-- buffer options
bo.tabstop = 2

-- implicit tab size
bo.softtabstop = 2

-- another kind of stabstop
bo.shiftwidth = 2

-- convert tabs to spaces
bo.expandtab = true
bo.autoindent = true

-- show file numbers
vim.wo.number = true

-- relative file numbers
vim.wo.relativenumber = true
vim.wo.nu = true
vim.wo.rnu = true

-- relative in normal mode, absolute in insert
af('BufEnter,FocusGained,InsertLeave', '*', function() vim.wo.relativenumber = true end)
af('BufLeave,FocusLost,InsertEnter',   '*', function() vim.wo.relativenumber = false end)

-- put numbers and signs in the same column
vim.wo.signcolumn = 'number'

------------------------------------------------------------------------
--                             Completion                             --
------------------------------------------------------------------------

--- hrsh7th/nvim-compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
    tabnine = true;
    ultisnips = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

------------------------------------------------------------------------
--                                Misc                                --
------------------------------------------------------------------------
--- folke/todo-comments.nvim
require("todo-comments").setup()

--- windwp/nvim-autopairs
require('nvim-autopairs').setup()

--- takac/vim-hardtime
vim.g.hardtime_default_on = 0
vim.g.hardtime_showmsg = 0

--- aquach/vim-http-client
vim.g.http_client_verify_ssl = 1
vim.g.http_client_preserve_responses = 0

--- christianrondeau/vim-base64
vim.g.vim_base64_disable_default_key_mappings = 1

--- norcalli/nvim-colorizer
require("colorizer").setup()

--- kyazdani42/nvim-tree.lua
vim.g.nvim_tree_side = 'left'
vim.g.nvim_tree_width = '240' -- bigger than 100 plz
vim.g.nvim_tree_ignore = { '.git','node_modules','.cache' }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_root_folder_modifier = ':~'
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_auto_resize = 0
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 1
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_hijack_cursor = 1
vim.g.nvim_tree_icon_padding = ' '
vim.g.nvim_tree_update_cwd = 0
vim.g.nvim_tree_window_picker_exclude = {
  'filetype', { 'packer','qf' },
  'buftype', { 'terminal' },
}

--- ahmedkhalf/lsp-rooter.nvim
require("lsp-rooter").setup()

--- simrat39/symbols-outline.nvim
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
}

------------------------------------------------------------------------
--                             LSP things                             --
------------------------------------------------------------------------

require("trouble").setup {
    height = 7, -- height of the trouble list
    icons = true, -- use devicons for filenames
    mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = { -- key mappings for actions in the trouble list
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small poup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = true, -- automatically open the list when you have diagnostics
    auto_close = true, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = true, -- automatically fold a file trouble list at creation
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.solargraph.setup{}

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

require'lspconfig'.yamlls.setup{
    settings = {
      yaml = {
        -- Schemas https://www.schemastore.org
        schemas = {
          ["https://json.schemastore.org/taskfile.json"] = {"Taskfile.{yml,yaml}"},
          ["http://json.schemastore.org/gitlab-ci.json"] = {".gitlab-ci.yml"},
          ["https://json.schemastore.org/bamboo-spec.json"] = {
            "bamboo-specs/*.{yml,yaml}"
          },
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
            "docker-compose*.{yml,yaml}"
          },
          ["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
          ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
          ["http://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
          ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}"
        }
      }
  }
}

require'lspconfig'.jsonls.setup{
  settings = {
    json = {
      schemas = {
        {
          description = 'TypeScript compiler configuration file',
          fileMatch = {'tsconfig.json', 'tsconfig.*.json'},
          url = 'http://json.schemastore.org/tsconfig'
        },
        {
          description = 'Lerna config',
          fileMatch = {'lerna.json'},
          url = 'http://json.schemastore.org/lerna'
        },
        {
          description = 'Babel configuration',
          fileMatch = {'.babelrc.json', '.babelrc', 'babel.config.json'},
          url = 'http://json.schemastore.org/lerna'
        },
        {
          description = 'ESLint config',
          fileMatch = {'.eslintrc.json', '.eslintrc'},
          url = 'http://json.schemastore.org/eslintrc'
        },
        {
          description = 'Bucklescript config',
          fileMatch = {'bsconfig.json'},
          url = 'https://bucklescript.github.io/bucklescript/docson/build-schema.json'
        },
        {
          description = 'Prettier config',
          fileMatch = {'.prettierrc', '.prettierrc.json', 'prettier.config.json'},
          url = 'http://json.schemastore.org/prettierrc'
        },
        {
          description = 'Vercel Now config',
          fileMatch = {'now.json'},
          url = 'http://json.schemastore.org/now'
        },
        {
          description = 'Stylelint config',
          fileMatch = {'.stylelintrc', '.stylelintrc.json', 'stylelint.config.json'},
          url = 'http://json.schemastore.org/stylelintrc'
        },
      }
    },
  }
}

require'lspsaga'.init_lsp_saga{
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = ""
}

--- onsails/lspkind-nvim
require('lspkind').init({
    -- with_text = true,
    -- symbol_map = {
    --   Text = '',
    --   Method = 'ƒ',
    --   Function = '',
    --   Constructor = '',
    --   Variable = '',
    --   Class = '',
    --   Interface = 'ﰮ',
    --   Module = '',
    --   Property = '',
    --   Unit = '',
    --   Value = '',
    --   Enum = '了',
    --   Keyword = '',
    --   Snippet = '﬌',
    --   Color = '',
    --   File = '',
    --   Folder = '',
    --   EnumMember = '',
    --   Constant = '',
    --   Struct = ''
    -- },
})

------------------------------------------------------------------------
--                             GUI things                             --
------------------------------------------------------------------------

--- lukas-reineke/indent-blankline.nvim
vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = "|"
vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
vim.g.indent_blankline_buftype_exclude = {"terminal"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indentline_setColors = 0

--- luochen1990/rainbow
vim.g.rainbow_active = 1

--- hoob3rt/lualine.nvim
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'nord',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

--- glepnir/dashboard-nvim 
vim.g.dashboard_default_executive ='telescope'

vim.g.dashboard_custom_section = {
    a = {description = {'  New Buffer         '}, command = 'ene'},
    b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
    c = {description = {'  Projects           '}, command = 'Telescope project'},
    x = {description = {'  Settings           '}, command = ':e ~/.config/nvim/init.lua'}
}

------------------------------------------------------------------------
--                             GIT things                             --
------------------------------------------------------------------------

--- TimUntersberger/neogit
require('neogit').setup()

--- lewis6991/gitsigns.nvim
require("gitsigns").setup {
    signs = {
        add = {hl = "DiffAdd", text = "▌", numhl = "GitSignsAddNr"},
        change = {hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr"},
        delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
        topdelete = {hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr"},
        changedelete = {hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr"}
    },
    numhl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''},
        ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''},
        ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
    },
    watch_index = {
        interval = 100
    },
    sign_priority = 5,
    status_formatter = nil -- Use default
}

------------------------------------------------------------------------
--                             Telescope                              --
------------------------------------------------------------------------

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { '.git/', 'node_modules/' },
    color_devicons = true,
  }
}

require('telescope').load_extension('ultisnips')
require('telescope').load_extension('project')

------------------------------------------------------------------------
--                            Keybindings                             --
------------------------------------------------------------------------

-- set leader key to space
vim.g.mapleader = ' '
-- and also for the local buffer
-- because thats what `let` does...
vim.b.mapleader = ' '

--- Set localleader to ,
vim.g.maplocalleader = ','

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
  ["<leader>q"] = { ":BufferClose<cr>", "close buffer" },
  ["<leader>Q"] = { ":bd!<cr>", "delete buffer" },
  ["<leader>e"] = { ":NvimTreeRefresh<cr>:NvimTreeToggle<cr>", "FileBrowser" },
  ["<leader>S"] = { ":Dashboard<cr>", "Open Dashboard" },
  ["<leader>v"] = { ":vsplit<cr>", "Split right" },
  ["<leader>n"] = { ":new<cr>", "New File" },
  ["<leader>w"] = { ":w<cr>", "Save"},
  ["<leader>W"] = { ":wq<cr>", "Save and close"}
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

------------------------------------------------------------------------
--                              Plugins                               --
------------------------------------------------------------------------

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
  ------ snippet support
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'norcalli/snippets.nvim'
  ------ AI auto completion
  use 'hrsh7th/nvim-compe'
  use {'tzachar/compe-tabnine', run = './install.sh' }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  ------ language server support
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  ------ A light-weight lsp usein based on neovim built-in lsp with highly a performant UI.  
  use 'glepnir/lspsaga.nvim'
  ------ A pretty list for showing diagnostics, references, telescope results
  use 'folke/lsp-trouble.nvim'
  ------ change surrounding
  use 'blackCauldron7/surround.nvim'
  ------ build systems
  use 'AlxHnr/build.vim'
  ------ code formatter
  use 'sbdchd/neoformat'
  ------ provides automatic closing of quotes, parenthesis, brackets
  use 'windwp/nvim-autopairs'
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
  use 'nvim-telescope/telescope-project.nvim'
  --- git things
  use 'sheerun/vim-polyglot'
  use 'TimUntersberger/neogit'
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'
  --- misc
  -- vim-table-mode
  use 'dhruvasagar/vim-table-mode'
  --- editorconfig
  use 'editorconfig/editorconfig-vim'
  ------ show spaces and indentlines
  use {'lukas-reineke/indent-blankline.nvim'}
  ------ smooth scrolling
  use 'psliwka/vim-smoothie'
  ------ change root to file directory
  use 'ahmedkhalf/lsp-rooter.nvim' 
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
  ------ comment stuff out
  use 'tpope/vim-commentary'
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
  use {'romgrk/barbar.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  ------ better todos
  use {'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim'}
  use 'gennaro-tedesco/nvim-peekup'
  ------ filetree
  use 'kyazdani42/nvim-tree.lua'
  ------ reload config
  use 'famiu/nvim-reload'
  ------ symbols-outline
  use 'simrat39/symbols-outline.nvim'
end)
