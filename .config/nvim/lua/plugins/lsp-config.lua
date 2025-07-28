return {
	-- Schema Store for JSON & YAML schemas
	{ "b0o/schemastore.nvim" },

	-- Mason & related plugins
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"jq",
				"yamlfmt",
				"ansiblelint",
				"markdownlint",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"html",
				"jsonls",
				"yamlls",
				"marksman",
				"pyright",
				"ansiblels",
				"ruff",
			},
			automatic_installation = true,
		},
	},

	-- null-ls (only for non-Python tools)
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.completion.spell,
				},
			})
		end,
	},

	-- Main LSP config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp" },
		config = function()
			-- Capabilities & on_attach
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				if client.supports_method("textDocument/formatting") then
					local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end

			-- Sign icons for diagnostics
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "󰌵",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
			})

			local lspconfig = require("lspconfig")
			local defaults = { on_attach = on_attach, capabilities = capabilities }

			-- Core LSP servers
			lspconfig.lua_ls.setup(defaults)
			lspconfig.bashls.setup(defaults)
			lspconfig.dockerls.setup(defaults)
			lspconfig.html.setup(defaults)
			lspconfig.marksman.setup(defaults)
			lspconfig.ansiblels.setup(defaults)

			-- Python: Pyright (types only) + Ruff-LSP (lint & format)
			lspconfig.pyright.setup(vim.tbl_deep_extend("force", defaults, {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- keep minimal type checks
							diagnosticMode = "openFilesOnly", -- performance optimization
						},
					},
				},
			}))
			lspconfig.ruff.setup(defaults)

			-- JSON & YAML with SchemaStore
			lspconfig.jsonls.setup(vim.tbl_deep_extend("force", defaults, {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			}))
			lspconfig.yamlls.setup(vim.tbl_deep_extend("force", defaults, {
				settings = {
					yaml = {
						keyOrdering = false,
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			}))

			-- Optional: Go & LaTeX
			lspconfig.gopls.setup(defaults)
			lspconfig.texlab.setup(vim.tbl_deep_extend("force", defaults, {
				settings = {
					texlab = { build = { args = { "-interaction=nonstopmode", "%f" } } },
				},
			}))
		end,
	},
}
