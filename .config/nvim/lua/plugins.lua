-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--single-branch", "https://github.com/folke/lazy.nvim.git", lazypath
    })
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {
    {"nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"}},
    {"rcarriga/nvim-notify"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"p00f/nvim-ts-rainbow"},
    {'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'jay-babu/mason-null-ls.nvim'},
        {'jose-elias-alvarez/null-ls.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'mtoohey31/cmp-fish'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        {'andersevenrud/cmp-tmux'},
        {'hrsh7th/cmp-emoji'},
        {'tzachar/cmp-tabnine',
         build = './install.sh',
         dependencies = 'hrsh7th/nvim-cmp',},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
     }
    },
    "b0o/schemastore.nvim",
    "onsails/lspkind-nvim",
    "simrat39/symbols-outline.nvim",
    "mhartington/formatter.nvim",
    "arouene/vim-ansible-vault",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-github.nvim",
        "xiyaowong/telescope-emoji.nvim",
        "ahmedkhalf/project.nvim",
      },
    },
    {"axkirillov/easypick.nvim", dependencies = "nvim-telescope/telescope.nvim"},
    "sheerun/vim-polyglot",
    {"NeogitOrg/neogit", config = function ()
        require("neogit").setup()
    end},
    "kdheepak/lazygit.nvim",
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",
    "oem/arachne.nvim",
    {"iamcco/markdown-preview.nvim", build = "cd app && npm install"},
    "dhruvasagar/vim-table-mode",
    "lukas-reineke/indent-blankline.nvim",
    "psliwka/vim-smoothie",
    "folke/which-key.nvim",
    "sotte/presenting.vim",
    { "chrisgrieser/nvim-genghis", -- remove, rename - Vim sugar for the UNIX shell commands that need it the most
        dependencies = {
        "stevearc/dressing.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-omni",
      },
      config = function ()
        require("genghis")
      end
    },
    "goolord/alpha-nvim",
    "ethanholz/nvim-lastplace",
    {"numToStr/Comment.nvim", config = function ()
        require("Comment").setup()
    end},
    {"norcalli/nvim-colorizer.lua", config = function ()
        vim.opt.termguicolors = true
        require("colorizer").setup()
    end},
    "ruanyl/vim-gh-line",
    "dstein64/vim-startuptime",
    {"akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons"},
    {"folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = function ()
        require("todo-comments").setup()
    end},
    "nvim-tree/nvim-tree.lua",
    "mzlogin/vim-markdown-toc",
    "windwp/nvim-spectre",
    {"echasnovski/mini.nvim", branch = "stable"},
    "NTBBloodbath/rest.nvim",
    "leafOfTree/vim-matchtag",
    "gbprod/yanky.nvim",
    "voldikss/vim-browser-search",
    "MunifTanjim/nui.nvim", -- UI Component Library for Neovim.
    "folke/noice.nvim",
    "aserowy/tmux.nvim",
    "shaunsingh/nord.nvim",
    "codethread/qmk.nvim",
    {"steinbrueckri/nvim-devdocs",
        dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
        },
    }
}

local options = {}

require("lazy").setup(plugins, options)
