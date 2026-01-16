return {
	-- Schema Store for JSON & YAML schemas
	{ "b0o/schemastore.nvim" },

	-- Mason & related plugins (unchanged)
	{ "williamboman/mason.nvim", config = true },
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

	-- null-ls (for additional sources not covered by conform.nvim)
	-- Note: Formatting is handled by conform.nvim, not here
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

	-- Main LSP config: native Neovim 0.11+ API
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp" },
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

			-- Show diagnostics in a floating window when holding cursor
			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
				end,
			})

			-- Diagnostic navigation key mappings
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
			vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Diagnostics in loclist" })

			-- LSP key mappings via LspAttach event
			-- Note: Formatting is handled by conform.nvim, not here
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
				end,
			})

			-- Completion capabilities for language servers
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Language server configurations
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})
			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})
			vim.lsp.config("dockerls", {
				capabilities = capabilities,
			})
			vim.lsp.config("html", {
				capabilities = capabilities,
			})
			vim.lsp.config("marksman", {
				capabilities = capabilities,
			})
			vim.lsp.config("pyright", {
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})
			vim.lsp.config("ruff", {
				capabilities = capabilities,
			})
			vim.lsp.config("jsonls", {
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			vim.lsp.config("yamlls", {
				capabilities = capabilities,
				settings = {
					yaml = {
						keyOrdering = false,
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			vim.lsp.config("gopls", { capabilities = capabilities })
			vim.lsp.config("texlab", {
				capabilities = capabilities,
				settings = {
					texlab = { build = { args = { "-interaction=nonstopmode", "%f" } } },
				},
			})

			-- Enable all configured language servers at once
			vim.lsp.enable({
				"lua_ls",
				"bashls",
				"dockerls",
				"html",
				"marksman",
				"pyright",
				"ruff",
				"jsonls",
				"yamlls",
				"gopls",
				"texlab",
			})
		end,
	},
}
