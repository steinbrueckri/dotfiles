local coq = require "coq"
local common_opts = {autostart = true, capabilities = lsp_capabilities}
local function merge_common(tbl)
    for k, v in pairs(common_opts) do
        tbl[k] = v
    end
    return tbl
end

local json_schemas = require("schemastore").json.schemas {}
local yaml_schemas = {}

require("mason").setup()
require("mason-lspconfig").setup({
    -- See https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    -- for the server names
    ensure_installed = {
        "ansiblels", "bashls", "efm", "marksman", "pyright", "dockerls", "cssls", "html", "yamlls", "jsonls",
        "terraformls", "taplo", "sqlls", "cmake"
    },
    automatic_installation = true
})

require("mason-lspconfig").setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities(common_opts))
    end,

    ["jsonls"] = function()
        require("lspconfig")["jsonls"].setup(coq.lsp_ensure_capabilities(merge_common {
            settings = {json = {schemas = json_schemas, validate = {enable = true}}}
        }))
    end,

    ["yamlls"] = function()
        require("lspconfig")["yamlls"].setup(coq.lsp_ensure_capabilities(merge_common {
            settings = {yaml = {schemas = yaml_schemas, validate = true}}
        }))
    end
}
