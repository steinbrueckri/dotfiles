-----------------------------------------------------------
-- lspconfig configuration file
-----------------------------------------------------------

-- Plugin: lspconfig
-- https://github.com/neovim/lspconfig
-----------------------------------------------------------

require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.solargraph.setup{}

require('lspconfig').efm.setup({
 cmd = {"efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "1" },
 filetypes = {"sh","yaml","markdown"},
 settings = {
   languages = {
     sh = {
         {
             LintCommand = 'shellcheck -f gcc -x',
             lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
         },
         {
           formatCommand = 'shfmt -ci -s -bn',
           formatStdin = true
         }
     },
     yaml = {
         {
            lintCommand = "yamllint -f parsable -",
            lintStdin = true,
        }
     },
     markdown = {
         {
            lintCommand = "mdl -",
            lintStdin = true,
        }
     },
   }
 }
})

require'lspconfig'.yamlls.setup{
    settings = {
      yaml = {
        -- Schemas https://www.schemastore.org
        schemas = {
          ["https://json.schemastore.org/taskfile.json"] = {"Taskfile.{yml,yaml}"},
          ["http://json.schemastore.org/gitlab-ci.json"] = {".gitlab-ci.yml"},
          ["https://json.schemastore.org/bamboo-spec.json"] = {
            "bamboo-specs/*.{yml,yaml}"
          },
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

require'lspconfig'.jsonls.setup{
  settings = {
    json = {
      schemas = {
        {
          description = 'TypeScript compiler configuration file',
          fileMatch = {'tsconfig.json', 'tsconfig.*.json'},
          url = 'http://json.schemastore.org/tsconfig'
        },
        {
          description = 'Lerna config',
          fileMatch = {'lerna.json'},
          url = 'http://json.schemastore.org/lerna'
        },
        {
          description = 'Babel configuration',
          fileMatch = {'.babelrc.json', '.babelrc', 'babel.config.json'},
          url = 'http://json.schemastore.org/lerna'
        },
        {
          description = 'ESLint config',
          fileMatch = {'.eslintrc.json', '.eslintrc'},
          url = 'http://json.schemastore.org/eslintrc'
        },
        {
          description = 'Bucklescript config',
          fileMatch = {'bsconfig.json'},
          url = 'https://bucklescript.github.io/bucklescript/docson/build-schema.json'
        },
        {
          description = 'Prettier config',
          fileMatch = {'.prettierrc', '.prettierrc.json', 'prettier.config.json'},
          url = 'http://json.schemastore.org/prettierrc'
        },
        {
          description = 'Vercel Now config',
          fileMatch = {'now.json'},
          url = 'http://json.schemastore.org/now'
        },
        {
          description = 'Stylelint config',
          fileMatch = {'.stylelintrc', '.stylelintrc.json', 'stylelint.config.json'},
          url = 'http://json.schemastore.org/stylelintrc'
        },
      }
    },
  }
}
