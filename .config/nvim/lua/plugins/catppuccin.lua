vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = false,
    term_colors = false,
    dim_inactive = {enabled = false, shade = "dark", percentage = 0.15},
    styles = {
        comments = {"italic"},
        conditionals = {"italic"},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {}
    },
    integrations = {
        bufferline = true,
        cmp = true,
        gitsigns = true,
        lsp_saga = true,
        markdown = true,
        mini = true,
        native_lsp = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        lsp_trouble = true,
        ts_rainbow = true,
        which_key = true
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
    color_overrides = {},
    custom_highlights = {}
})

vim.api.nvim_command "colorscheme catppuccin"
