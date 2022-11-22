-- load plugins without special configuration
require("todo-comments").setup()
require("neogit").setup()
require("Comment").setup()
require("colorizer").setup()
require("arachne").setup {notes_directory = "~/notes"}
require("symbols-outline").setup()
require"lspsaga".init_lsp_saga {error_sign = "", warn_sign = "", hint_sign = "", infor_sign = ""}
require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true}
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false -- add a border to hover docs and signature help
    },
    cmdline = {
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        format = {cmdline = {pattern = "^:", icon = "|>", lang = "vim", title = ""}}
    },
    routes = {
        -- skip displaying message that file was written to.
        {filter = {event = "msg_show", kind = "", find = "written"}, opts = {skip = true}}
    },
    views = {
        cmdline_popup = {
            size = {height = "auto", width = "90%"},
            position = {row = "50%", col = "50%"},
            border = {style = "single"}
        }
    }
})
