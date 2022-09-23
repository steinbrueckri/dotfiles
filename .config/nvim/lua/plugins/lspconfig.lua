local coq = require "coq"

require("mason").setup()
require("mason-lspconfig").setup()

require"lspconfig".pyright.setup {coq.lsp_ensure_capabilities {}}

require"lspconfig".bashls.setup {coq.lsp_ensure_capabilities {}}

require"lspconfig".tsserver.setup {}

require"lspconfig".terraformls.setup {coq.lsp_ensure_capabilities {}}

require"lspconfig".html.setup {coq.lsp_ensure_capabilities {}}

require"lspconfig".dockerls.setup {coq.lsp_ensure_capabilities {}}

require"lspconfig".cssls.setup {coq.lsp_ensure_capabilities {}}

require"lspconfig".solargraph.setup {coq.lsp_ensure_capabilities {}}

require("lspconfig").efm.setup({
    cmd = {"efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "1"},
    filetypes = {"sh", "yaml", "markdown"},
    settings = {
        languages = {
            sh = {
                {
                    LintCommand = "shellcheck -f gcc -x",
                    lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}
                }, {formatCommand = "shfmt -ci -s -bn", formatStdin = true}
            },
            yaml = {{lintCommand = "yamllint -f parsable -", lintStdin = true}},
            markdown = {{lintCommand = "mdl -", lintStdin = true}}
        }
    }
})

require"lspconfig".yamlls.setup {
    settings = {
        yaml = {
            -- Schemas https://www.schemastore.org
            schemas = {
                ["https://json.schemastore.org/taskfile.json"] = {"Taskfile.{yml,yaml}"},
                ["http://json.schemastore.org/gitlab-ci.json"] = {".gitlab-ci.yml"},
                ["https://json.schemastore.org/bamboo-spec.json"] = {"bamboo-specs/*.{yml,yaml}"},
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                    "docker-compose*.{yml,yaml}"
                },
                ["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
                ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
                ["http://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
                ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}"
            }
        }
    }
}

require("lspconfig").jsonls.setup {
    settings = {json = {schemas = require("schemastore").json.schemas()}},
    coq.lsp_ensure_capabilities {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
                end
            }
        }
    }
}
