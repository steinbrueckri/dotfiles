return {
	-- Schema Store for JSON & YAML schemas
	{ "b0o/schemastore.nvim" },

	-- Mason: package manager for LSP servers, formatters, linters
	{ "williamboman/mason.nvim", config = true },

	-- mason-tool-installer: manages formatters/linters (non-LSP tools)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"jq",
				"yamlfmt",
				"djlint",
				"rumdl",
			},
		},
	},

	-- mason-lspconfig: installs LSP servers and auto-enables them
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
				"gopls",
				"texlab",
			},
			automatic_enable = true,
		},
	},

	-- null-ls (for additional sources not covered by conform.nvim)
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.completion.spell,
				},
			})
		end,
	},

	-- nvim-lspconfig: provides server defaults; only custom overrides needed here
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Global diagnostic configuration
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

			-- Diagnostic navigation
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
			vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Diagnostics in loclist" })

			-- LSP keymaps and native completion on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local opts = { buffer = bufnr }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)

					-- Neovim 0.12: native LSP completion
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client:supports_method("textDocument/completion") then
						vim.lsp.completion.enable(true, args.data.client_id, bufnr, {
							autotrigger = true,
						})
					end
				end,
			})

			-- Custom server configs (only servers that need non-default settings)
			vim.lsp.config("rumdl", {
				cmd = { "rumdl", "server", "--stdio" },
				filetypes = { "markdown" },
				root_markers = { ".rumdl.toml", "rumdl.toml", ".markdownlint.yaml", ".markdownlint.json", ".git" },
			})
			vim.lsp.enable("rumdl") -- installed via mason-tool-installer, not mason-lspconfig

			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						keyOrdering = false,
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			vim.lsp.config("texlab", {
				settings = {
					texlab = { build = { args = { "-interaction=nonstopmode", "%f" } } },
				},
			})
		end,
	},
}
