local lspkind = require('lspkind')
local cmp = require('cmp')
local lsp = require('lsp-zero').preset({
  name = 'minimal',
  manage_nvim_cmp = {
    set_sources = false,
    set_basic_mappings = true,
    set_extra_mappings = true,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup_nvim_cmp({
  completion = { completeopt = "menu,menuone,noinsert,noselect" },
  sources = {
    { name = "nvim_lua"},
    { name = "cmp_tabnine"},
    { name = "buffer"},
    { name = 'tmux', option = { all_panes = true } },
    { name = "path"},
    { name = "fish"},
    { name = "luasnip"},
    { name = "emoji"}
  }
})

-- add border to the completion menu
local cmp_config = lsp.defaults.cmp_config({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    })
  },
  window = {
    completion = cmp.config.window.bordered()
  }
})

lsp.setup()
cmp.setup(cmp_config)

-- make sure to call it after lsp-zero's setup function.
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
