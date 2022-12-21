local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"
    use {"nvim-lualine/lualine.nvim", requires = {"nvim-tree/nvim-web-devicons", opt = true}}
    use "rcarriga/nvim-notify"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "p00f/nvim-ts-rainbow"
    -- completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use {"tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp"}
    use "andersevenrud/cmp-tmux"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "b0o/schemastore.nvim"
    use "onsails/lspkind-nvim"
    use "tami5/lspsaga.nvim"
    use "folke/lsp-trouble.nvim"
    use "mhartington/formatter.nvim"
    -- use {"ms-jpq/coq_nvim", branch = "coq"}
    -- use {"ms-jpq/coq.artifacts", branch = "artifacts"}
    -- use {"ms-jpq/coq.thirdparty", branch = "3p"}
    use "arouene/vim-ansible-vault"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "cljoly/telescope-repo.nvim"
    use "nvim-telescope/telescope-packer.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"
    use "nvim-telescope/telescope-github.nvim"
    use "xiyaowong/telescope-emoji.nvim"
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    }
    use {"axkirillov/easypick.nvim", requires = "nvim-telescope/telescope.nvim"}
    use "ahmedkhalf/project.nvim"
    use "sheerun/vim-polyglot"
    use "TimUntersberger/neogit"
    use "kdheepak/lazygit.nvim"
    use "lewis6991/gitsigns.nvim"
    use "sindrets/diffview.nvim"
    use "oem/arachne.nvim"
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {"markdown"}
        end,
        ft = {"markdown"}
    })
    use "dhruvasagar/vim-table-mode"
    use "editorconfig/editorconfig-vim"
    use "lukas-reineke/indent-blankline.nvim"
    use "psliwka/vim-smoothie"
    use "folke/which-key.nvim"
    use "sotte/presenting.vim"
    use "tpope/vim-eunuch" -- remove, rename - Vim sugar for the UNIX shell commands that need it the most
    use "goolord/alpha-nvim"
    use "ethanholz/nvim-lastplace"
    use "numToStr/Comment.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "ruanyl/vim-gh-line"
    use {"catppuccin/nvim", as = "catppuccin", run = "CatppuccinCompile"}
    use "dstein64/vim-startuptime"
    use "christianrondeau/vim-base64"
    use "kyazdani42/nvim-web-devicons"
    use {"akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons"}
    use {"folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim"}
    use "nvim-tree/nvim-tree.lua"
    use "simrat39/symbols-outline.nvim"
    use "mzlogin/vim-markdown-toc"
    use "windwp/nvim-spectre"
    use {"echasnovski/mini.nvim", branch = "stable"}
    use "NTBBloodbath/rest.nvim"
    use "leafOfTree/vim-matchtag"
    use "lewis6991/impatient.nvim"
    use "gbprod/yanky.nvim"
    use "voldikss/vim-browser-search"
    use "narutoxy/silicon.lua"
    use "MunifTanjim/nui.nvim"
    use {
        "cuducos/yaml.nvim",
        ft = {"yaml"}, -- optional
        requires = {
            "nvim-treesitter/nvim-treesitter", "nvim-telescope/telescope.nvim" -- optional
        }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
