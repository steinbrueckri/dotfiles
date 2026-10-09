return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true, -- loaded by blink.cmp
		dependencies = { "rafamadriz/friendly-snippets" },
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
		"saghen/blink.cmp",
		version = "1.*", -- release tags ship prebuilt fuzzy matcher binaries
		-- No lazy loading: blink handles that itself and must register its LSP
		-- capabilities before the first language server starts.
		lazy = false,
		dependencies = {
			"L3MON4D3/LuaSnip",
			"mikavilpas/blink-ripgrep.nvim",
			"mgalliou/blink-cmp-tmux",
			-- cmp-fish has no native blink port, so it runs through the nvim-cmp compat layer
			{ "saghen/blink.compat", version = "2.*", lazy = true, opts = {} },
			{ "mtoohey31/cmp-fish", lazy = true },
		},
		opts = {
			-- enter: <CR> accepts, <C-Space> shows, <C-e> hides, <C-b>/<C-f> scroll docs
			keymap = { preset = "enter" },
			snippets = { preset = "luasnip" },
			completion = {
				menu = { border = "rounded" },
				documentation = {
					auto_show = true,
					window = { border = "rounded", max_width = 80, max_height = 20 },
				},
			},
			-- Command-line completion stays native (ui2 / tiny-cmdline)
			cmdline = { enabled = false },
			sources = {
				default = { "lsp", "snippets", "buffer", "ripgrep", "tmux", "path" },
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
					fish = { inherit_defaults = true, "fish" },
					sql = { inherit_defaults = true, "dadbod" },
					mysql = { inherit_defaults = true, "dadbod" },
					plsql = { inherit_defaults = true, "dadbod" },
				},
				providers = {
					lsp = { max_items = 10 },
					snippets = { max_items = 5 },
					buffer = { max_items = 5 },
					path = { max_items = 5 },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
					ripgrep = { name = "Ripgrep", module = "blink-ripgrep", max_items = 5, score_offset = -5 },
					tmux = {
						name = "tmux",
						module = "blink-cmp-tmux",
						max_items = 5,
						score_offset = -6,
						opts = { panes = "all" },
					},
					fish = { name = "fish", module = "blink.compat.source", max_items = 5 },
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
		},
	},
}
