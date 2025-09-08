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
				"markdownlint",
				"djlint",
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
			-- Global diagnostic settings
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Show diagnostics in floating window on CursorHold
			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
				end,
			})

			-- Diagnostic navigation keymaps
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
			vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Diagnostics in loclist" })

			-- LSP on_attach
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

			-- Setup LSP servers
			local lspconfig = require("lspconfig")
			local defaults = { on_attach = on_attach, capabilities = capabilities }

			lspconfig.lua_ls.setup(defaults)
			lspconfig.bashls.setup(defaults)
			lspconfig.dockerls.setup(defaults)
			lspconfig.html.setup(defaults)
			lspconfig.marksman.setup(defaults)

			lspconfig.pyright.setup(vim.tbl_deep_extend("force", defaults, {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			}))
			lspconfig.ruff.setup(defaults)

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

			lspconfig.gopls.setup(defaults)
			lspconfig.texlab.setup(vim.tbl_deep_extend("force", defaults, {
				settings = {
					texlab = { build = { args = { "-interaction=nonstopmode", "%f" } } },
				},
			}))
		end,
	},
}
