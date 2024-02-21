-----------------------------------------------------------
-- Custom Keybindings
-----------------------------------------------------------
-- set leader key to space
vim.g.mapleader = " "
-- and also for the local buffer
-- because thats what `let` does...
vim.b.mapleader = " "

--- Set localleader to ,
vim.g.maplocalleader = ","

-- jk to exit insert mode, very handy on my iPad :)
vim.api.nvim_set_keymap("i", "jk", "<esc>", {noremap = true})

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true, silent = true})

-- base64
vim.api.nvim_set_keymap("v", "<leader>bu", ":<c-u>call base64#v_atob()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>bc", ":<c-u>call base64#v_btoa()<cr>", {noremap = true, silent = true})

-----------------------------------------------------------
-- Which-key Setup
-----------------------------------------------------------

local wk = require("which-key")

wk.register({
    ["gW"] = {":BrowserSearch<cr>", "Search for word on cursor"},
    ["gF"] = {":e <cfile><cr>", "create and goto file"},
    ["<esc>"] = {":noh<cr>", "clear search highlight"},
    ["<leader><Up>"] = {":wincmd k<cr>", "goto split"},
    ["<leader><Down>"] = {":wincmd j<cr>", "goto split"},
    ["<leader><Left>"] = {":wincmd h<cr>", "goto split"},
    ["<leader><Right>"] = {":wincmd l<cr>", "goto split"},
    ["<Tab>"] = {":bn<cr>", "Next buffer"},
    ["<S-Tab>"] = {":bp<cr>", "Previous buffer"},
    ["Z"] = {":Telescope spell_suggest<cr>", "spell suggest"},
    ["U"] = {":redo<cr>", "Redo"},
    -- LEADER Mappings
    ["<leader>"] = {
        d = {name = "+delete",
            d = {":bd<cr>", "delete buffer"},
            m = {":delmarks A-Z0-9<cr>:lua require('notify')('Delete all marks')<cr>", "delete marker"}
        },
        q = {":bdelete<cr>", "close buffer"},
        Q = {":bd!<cr>", "delete buffer"},
        e = {":NvimTreeToggle<cr>", "Show the file in the tree"},
        A = {":Alpha<cr>", "Open Dashboard"},
        v = {":vsplit<cr>", "Split right"},
        w = {":w<cr>", "Save"},
        N = {":enew<cr>", "Empty buffer"},
        a = {
            name = "+ansible",
            v = {":AnsibleVault<cr>", "ansible vault"},
            u = {":AnsibleUnvault<cr>", "ansible unvault"}
        },
        f = {
            name = "+find",
            a = {":Telescope live_grep<cr>", "grep over all"},
            c = {":lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})<cr>", "search config"},
            f = {
                ":lua require'telescope.builtin'.find_files({ find_command = {'rg','--files','--hidden','-g','!.git'}})<cr>",
                "search files"
            },
            r = {":lua require('spectre').open()<cr>", "Search and Replace"},
            p = {":Telescope projects<cr>", "Project list"},
            I = {":Telescope gh issues<cr>", "github issues"},
            P = {":Telescope gh pull_request<cr>", "github PRs"},
            y = {":Telescope yank_history<cr>", "find yank history"},
            B = {":Telescope git_branches<cr>", "find git branches"},
            o = {":Telescope oldfiles<cr>", "Show recent files"},
            b = {":Telescope buffers<cr>", "Show buffer"},
            u = {":Telescope undo<cr>", "Show Undo History"},
            k = {":Telescope keymaps<cr>", "Show Keybindings"},
            d = {":DevdocsOpenCurrent<cr>", "Show Docs"},
            h = {":Telescope harpoon marks<cr>", "Show Harpoon marks"},
            t = {":TodoTelescope keywords=TODO,FIX,FIXME,BUG<cr>", "Show tasks"}
        },
        r = {
            name = "+http",
            r = {"<Plug>RestNvim<cr>", "run the request under the cursor"},
            p = {"<Plug>RestNvimPreview<cr>", "preview the request cURL command"}
        },
        g = {
            name = "+git",
            a = {":Git add %<cr>", "add current"},
            A = {":Git add .<cr>", "add all"},
            b = {":Gitsigns blame_line<cr>", "blame_line"},
            d = {":DiffviewOpen<cr>", "diff open"},
            D = {":DiffviewClose<cr>", "diff close"},
            g = {":GHInteractive<cr>", "show line on github"},
            Y = {":Git yolo<cr>", "yolo commit"},
            n = {":Neogit<cr>", "Open Neogit"},
            l = {':!tmux split-window -Z -c "$PWD" lazygit<cr>', "Open LazyGit"},
            f = {":!fork status $PWD<cr><cr>", "Open Fork"}
        },
        n = {
            name = "+Notes",
            n = {":Telekasten goto_thisweek<cr>", "Create new note"},
            r = {":Telekasten rename_note<cr>", "Rename note"},
            f = {":Telekasten search_notes<cr>", "Search for notes by content"}
        },
        t = {
            name = "+toggle",
            c = {":ColorizerToggle<cr>", "colorizer"},
            o = {":SymbolsOutline<cr>", "SymbolsOutline"},
            S = {":set spell!<cr>", "toggle spell highlighting"},
            n = {":set relativenumber!<cr>", "relative line-numbers"},
            m = {":MarkdownPreviewToggle<cr>", "Show Markdown preview"},
            R = {":set norelativenumber!<cr>", "relative line nums"},
            r = {":TroubleToggle<cr>", "LSP Issue viewer"},
            t = {":TableModeToggle<cr>", "TableModeToggle"}
        },
        p = {
            name = "+presentation",
            s = {":PresentingStart<cr>", "PresentingStart"},
            b = {":.!toilet -w 20::wq0 -f term -F border<cr>", "Ascii border"},
            f = {":.!figlet<cr>", "Ascii font - figlet"},
            t = {":.!toilet -w 200<cr>", "Ascii font - toilet"}
        },
        h = {name = "+harpoon",
            a = {":lua require('harpoon.mark').add_file()<cr>:lua vim.notify('Add file to list', 'info', {title = 'Harpoon'})<cr>", "Add to harpoon list"},
            h = {":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Show harpoon list"},
            n = {":lua require('harpoon.ui').nav_next()<cr>", "Jump to next harpoon item in the list"},
            p = {":lua require('harpoon.ui').nav_prev()<cr>", "Jump to previous harpoon item in the list"}
        }
    }
})
