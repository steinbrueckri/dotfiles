return {
	-- Schema Store for JSON & YAML schemas
	{ "b0o/schemastore.nvim" },

	-- Mason: package manager for LSP servers, formatters, linters
	{ "mason-org/mason.nvim", config = true },

	-- mason-tool-installer: manages formatters/linters (non-LSP tools)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
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
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
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
				"tofu_ls", -- OpenTofu / Terraform
				"helm_ls", -- Helm charts (runs yamlls with the Kubernetes schema on templates)
			},
			automatic_enable = true,
		},
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
					source = true,
					header = "",
					prefix = "",
				},
			})

			-- Diagnostic navigation: [d / ]d are Neovim defaults
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

			-- LSP keymaps on attach. Neovim already provides K (hover), grr (references),
			-- gri (implementation), grn (rename), gra (code action) and grt (type definition).
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
					end
					map("n", "gd", vim.lsp.buf.definition, "Goto definition")
					map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>D", vim.lsp.buf.type_definition, "Goto type definition")
				end,
			})

			-- Custom server configs (only servers that need non-default settings)
			vim.lsp.config("rumdl", {
				cmd = { "rumdl", "server", "--stdio" },
				filetypes = { "markdown" },
				root_markers = { ".rumdl.toml", "rumdl.toml", ".markdownlint.yaml", ".markdownlint.json", ".git" },
			})
			vim.lsp.enable("rumdl") -- installed via mason-tool-installer, not mason-lspconfig

			-- tflint comes from mise (same version as CI), so it is enabled here
			-- instead of being installed by mason-lspconfig. Projects without a
			-- tflint version get no client instead of a failing one.
			vim.lsp.config("tflint", {
				root_dir = function(bufnr, on_dir)
					local root = vim.fs.root(bufnr, { ".terraform", ".git", ".tflint.hcl" })
					if root and require("functions").tool_runs({ "tflint", "--version" }, root) then
						on_dir(root)
					end
				end,
			})
			vim.lsp.enable("tflint")

			-- Also attach to .tfvars files; tofu-ls expects its own language ids
			vim.lsp.config("tofu_ls", {
				filetypes = { "opentofu", "opentofu-vars", "terraform", "terraform-vars" },
				get_language_id = function(_, filetype)
					return ({ ["terraform-vars"] = "opentofu-vars" })[filetype] or filetype
				end,
			})

			-- Kubernetes manifests get their schema from the file content
			require("kubernetes").setup()

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
