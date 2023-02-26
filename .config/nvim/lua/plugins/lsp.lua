-- lsp-zero
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.setup_nvim_cmp({preselect = "none", completion = {completeopt = "menu,menuone,noinsert,noselect"}})

lsp.ensure_installed({
    "ansiblels", "bashls", "efm", "marksman", "pyright", "dockerls", "cssls", "html", "yamlls", "jsonls", "terraformls",
    "taplo", "sqlls", "cmake"
})

require("mason-null-ls").setup({
    automatic_installation = true,
    automatic_setup = true,
})

require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.

lsp.setup_nvim_cmp({
    sources = {
        {name = "buffer"},
        {name = "tmux"},
        {name = "path"},
        {name = "fish"},
        {name = "cmp_tabnine"},
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "nvim_lua"},
        {name = "emoji"}
    }
})

-- schemastore
local schemastore = require("schemastore")
local schemas = schemastore.json.schemas()

lsp.configure("jsonls", {
	settings = {
		json = {
			schemas = schemas,
		},
	},
})

lsp.configure("yamlls", {
	settings = {
		yaml = {
			schemas = schemas,
		},
	},
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
