return {
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		event = "InsertEnter",
		config = function()
			local tabnine = require("cmp_tabnine.config")
			tabnine:setup({
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
				show_prediction_strength = true,
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = { { "saadparwaiz1/cmp_luasnip" }, { "rafamadriz/friendly-snippets" } },
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")
			local types = require("luasnip.util.types")

			ls.config.set_config({
				history = true,
				enable_autosnippets = true,
				store_selection_keys = "<Tab>",
				updateevents = "TextChanged,TextChangedI",
				ext_opts = { [types.choiceNode] = { active = { virt_text = { { "← Choice", "Todo" } } } } },
			})

			-- Lazy load VSCode snippets
			vim.schedule(function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end)

			local twig = { "html", "twig" }
			ls.filetype_extend("jinja", twig)
			ls.filetype_extend("jinja2", twig)
			ls.filetype_extend("html.twig", twig)

			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node

			local function replace_each(replacer)
				return function(args)
					local len = #args[1][1]
					return { replacer:rep(len) }
				end
			end

			ls.add_snippets(nil, {
				all = {
					s({ trig = "box", wordTrig = true }, {
						t({ "################################################################################" }),
						t({ "", "# " }),
						i(1),
						t({ "", "################################################################################" }),
					}),
					s({ trig = "hbox", wordTrig = true }, {
						t({ "#" }),
						f(replace_each("#"), { 1 }),
						t({ "###", "# " }),
						i(1, { "content" }),
						t({ " #", "###" }),
						f(replace_each("#"), { 1 }),
						t({ "#" }),
						i(0),
					}),
					s({ trig = "bbox", wordTrig = true }, {
						t({ "╔" }),
						f(replace_each("═"), { 1 }),
						t({ "╗", "║" }),
						i(1, { "content" }),
						t({ "║", "╚" }),
						f(replace_each("═"), { 1 }),
						t({ "╝" }),
						i(0),
					}),
					s({ trig = "sbox", wordTrig = true }, {
						t({ "*" }),
						f(replace_each("-"), { 1 }),
						t({ "*", "|" }),
						i(1, { "content" }),
						t({ "|", "*" }),
						f(replace_each("-"), { 1 }),
						t({ "*" }),
						i(0),
					}),
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "mtoohey31/cmp-fish" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "andersevenrud/cmp-tmux" },
			{ "hrsh7th/cmp-emoji" },
			{ "lukas-reineke/cmp-rg" },
			{ "onsails/lspkind-nvim" },
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
						scrollbar = true,
						col_offset = -3,
						side_padding = 1,
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
						max_width = 80,
						max_height = 20,
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000, max_item_count = 5 },
					{ name = "luasnip", priority = 750, max_item_count = 5 },
					{ name = "cmp_tabnine", priority = 500, max_item_count = 5 },
					{ name = "buffer", priority = 250, max_item_count = 5 },
					{ name = "rg", priority = 200, max_item_count = 5 },
					{ name = "tmux", priority = 150, max_item_count = 5, option = { all_panes = true } },
					{ name = "path", priority = 100, max_item_count = 5 },
					{ name = "fish", priority = 50, max_item_count = 5 },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},
}
