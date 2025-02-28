return {
	{ "b0o/schemastore.nvim" },
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"jq",
					"black",
					"isort",
					"yamlfmt",
					"ansiblelint",
					"markdownlint",
					"pylint",
				},
			})

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")
			null_ls.setup({
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
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
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.completion.spell,
					null_ls.builtins.diagnostics.markdownlint,
					null_ls.builtins.formatting.markdownlint,
				},
			})
		end,
	},
	{ "williamboman/mason.nvim", config = true },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = true,
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
			},
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.dockerls.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({ capabilities = capabilities })
			lspconfig.texlab.setup({
				capabilities = capabilities,
				settings = {
					texlab = { build = { args = { "-interaction=nonstopmode", "%f" } } },
				},
			})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
				settings = {
					settings = {
						json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
					},
				},
			})
			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						keyOrdering = false,
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})

			lspconfig.marksman.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.ansiblels.setup({ capabilities = capabilities })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- diagnostics config
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "", -- index:0
						[vim.diagnostic.severity.WARN] = "", -- index:1
						[vim.diagnostic.severity.INFO] = "", -- index:2
						[vim.diagnostic.severity.HINT] = "󰌵", -- index:3
					},
				},
				severity_sort = true,
				float = {
					show_header = true,
					source = "if_many",
					border = "rounded",
				},
			})

			-- diagnostics hover popup
			local diagnosticHoverAutocmdId = false
			vim.o.updatetime = 250
			vim.api.nvim_create_user_command("ToggleDiagnosticHover", function(args)
				if diagnosticHoverAutocmdId then
					-- If it already exists, delete the specific autocmd
					vim.api.nvim_del_autocmd(diagnosticHoverAutocmdId)
					diagnosticHoverAutocmdId = nil
				else
					-- Create a new autocmd and save its ID
					diagnosticHoverAutocmdId = vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						callback = function()
							vim.diagnostic.open_float(nil, { focus = false })
						end,
					})
				end

				if #args.fargs == 0 then
					vim.notify(
						"DiagnosticHoverEnable: " .. tostring(diagnosticHoverAutocmdId ~= nil),
						vim.log.levels.INFO
					)
				end
			end, {
				nargs = "?",
				desc = "Toggle diagnostic hover display",
			})
			vim.cmd("ToggleDiagnosticHover --quite") -- Since my default value is set to false, this is equivalent to enabling it by default
		end,
	},
}
