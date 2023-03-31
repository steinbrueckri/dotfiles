-- lsp-zero
local lsp = require("lsp-zero")
local cmp = require('cmp')
lsp.preset("recommended")

lsp.setup_nvim_cmp({
  completion = { completeopt = "menu,menuone,noinsert,noselect" },
  mapping = cmp.mapping.preset.insert({
      ['<C-e>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp_signature_help", max_item_count = 5 },
    { name = "cmp_tabnine", max_item_count = 5 },
    { name = "buffer"},
    { name = 'tmux', max_item_count = 5, option = { all_panes = true } },
    { name = "path", max_item_count = 5 },
    { name = "fish", max_item_count = 5 },
    { name = "luasnip", max_item_count = 5 },
    { name = "nvim_lua", max_item_count = 5 },
    { name = "emoji", max_item_count = 5 }
  },
})

-- add border to the completion menu
local cmp_config = lsp.defaults.cmp_config({
  window = {
    completion = cmp.config.window.bordered()
  }
})

cmp.setup(cmp_config)


lsp.ensure_installed({
  "ansiblels", "bashls", "efm", "marksman", "pyright", "dockerls", "cssls", "html", "yamlls", "jsonls", "terraformls",
  "taplo", "sqlls", "cmake"
})

require("mason-null-ls").setup({
  automatic_installation = true,
  automatic_setup = true,
})

require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.

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

-- make sure to call it after lsp-zero's setup function.
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
