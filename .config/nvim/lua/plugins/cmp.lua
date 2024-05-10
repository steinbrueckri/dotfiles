return {
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
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
	{ "Gelio/cmp-natdat", config = true },
	{ "hrsh7th/cmp-nvim-lsp", config = true },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { { "saadparwaiz1/cmp_luasnip" }, { "rafamadriz/friendly-snippets" } },
		build = "make install_jsregexp",
		config = function()
			local has_ls, ls = pcall(require, "luasnip")

			if not has_ls then
				return
			end

			local s = ls.snippet
			local sn = ls.snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local c = ls.choice_node
			local d = ls.dynamic_node
			local fmt = require("luasnip.extras.fmt").fmt
			local rep = require("luasnip.extras").rep
			-- https://github.com/L3MON4D3/LuaSnip/blob/1dbafec2379bd836bd09c4659d4c6e1a70eb380e/Examples/snippets.lua#L356=
			local types = require("luasnip.util.types")

			ls.config.set_config({
				history = true,
				enable_autosnippets = true,
				store_selection_keys = "<Tab>", -- needed for TM_SELECTED_TEXT
				updateevents = "TextChanged,TextChangedI", -- default is InsertLeave
				ext_opts = { [types.choiceNode] = { active = { virt_text = { { "← Choice", "Todo" } } } } },
			})

			local twig = { "html", "twig" }

			ls.filetype_extend("jinja", twig)
			ls.filetype_extend("jinja2", twig)
			ls.filetype_extend("html.twig", twig)

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
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", max_item_count = 5 },
					{ name = "cmp_tabnine", max_item_count = 5 },
					{ name = "rg", max_item_count = 5 },
					{ name = "buffer", max_item_count = 5 },
					{ name = "tmux", max_item_count = 5, option = { all_panes = true } },
					{ name = "path", max_item_count = 5 },
					{ name = "fish", max_item_count = 5 },
					{ name = "luasnip", max_item_count = 5 },
					{ name = "natdat", max_item_count = 5 },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					}),
				},
			})
		end,
	},
}
