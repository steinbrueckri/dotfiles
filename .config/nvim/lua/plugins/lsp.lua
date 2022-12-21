-- tabnine
local tabnine = require("cmp_tabnine.config")
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    ignored_file_types = {
        -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
    },
    show_prediction_strength = false
})

-- schemastore
local json_schemas = require("schemastore").json.schemas {}
local yaml_schemas = {}

-- lsp-zero
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.setup_nvim_cmp({preselect = "none", completion = {completeopt = "menu,menuone,noinsert,noselect"}})

lsp.ensure_installed({
    "ansiblels", "bashls", "efm", "marksman", "pyright", "dockerls", "cssls", "html", "yamlls", "jsonls", "terraformls",
    "taplo", "sqlls", "cmake"
})

lsp.setup_nvim_cmp({
    sources = {
        {name = "path"}, {name = "cmp_tabnine"}, {name = "tmux"}, {name = "nvim_lua", keyword_length = 3},
        {name = "nvim_lsp", keyword_length = 3}, {name = "buffer", keyword_length = 3},
        {name = "luasnip", keyword_length = 2}
    }
})

lsp.setup_nvim_cmp({
    formatting = {
        -- changing the order of fields so the icon is the first
        fields = {"menu", "abbr", "kind"},

        -- here is where the change happens
        format = function(entry, item)
            local menu_icon = {
                cmp_tabnine = "",
                nvim_lsp = "λ",
                luasnip = "⋗",
                buffer = "Ω",
                tmux = "Ω",
                path = "🖫",
                nvim_lua = "Π"
            }

            item.menu = menu_icon[entry.source.name]
            return item
        end
    }
})

lsp.setup()
