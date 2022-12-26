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
        {name = "buffer"},
        {name = "tmux"},
        {name = "path"},
        {name = "cmp_tabnine"},
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "nvim_lua"},
        {name = "emoji"}
    }
})

-- TODO: if i turn this on some cmp sources don't work anymore
-- lsp.setup_nvim_cmp({
--     formatting = {
--         -- changing the order of fields so the icon is the first
--         fields = {"menu", "abbr", "kind"},
--
--         -- here is where the change happens
--         format = function(entry, item)
--             local menu_icon = {
--                 buffer = "Ω",
--                 tmux = "Ω",
--                 path = "🖫",
--                 cmp_tabnine = "",
--                 nvim_lsp = "λ",
--                 luasnip = "⋗",
--                 nvim_lua = "Π"
--             }
--
--             item.menu = menu_icon[entry.source.name]
--             return item
--         end
--     }
-- })

lsp.setup()
