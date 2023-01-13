local has_ls, ls = pcall(require, 'luasnip')

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
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
-- https://github.com/L3MON4D3/LuaSnip/blob/1dbafec2379bd836bd09c4659d4c6e1a70eb380e/Examples/snippets.lua#L356=
local types = require 'luasnip.util.types'

ls.config.set_config {
	history = true,
	enable_autosnippets = true,
	store_selection_keys = '<Tab>', -- needed for TM_SELECTED_TEXT
	updateevents = 'TextChanged,TextChangedI', -- default is InsertLeave
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { '← Choice', 'Todo' } },
			},
		},
	},
}

local function replace_each(replacer)
	return function(args)
		local len = #args[1][1]
		return { replacer:rep(len) }
	end
end

local twig = { 'html', 'twig' }

ls.filetype_extend('jinja', twig)
ls.filetype_extend('jinja2', twig)
ls.filetype_extend('html.twig', twig)

ls.add_snippets(nil, {
	all = {
		s({ trig = 'box', wordTrig = true },{
			t({"################################################################################"}),
			t({"","# "}), i(1),
			t({"","################################################################################"}),
		}),
		s({ trig = 'hbox', wordTrig = true }, {
			t { '#' },
			f(replace_each '#', { 1 }),
			t { '###', '# ' },
			i(1, { 'content' }),
			t { ' #', '###' },
			f(replace_each '#', { 1 }),
			t { '#' },
			i(0),
		}),
		s({ trig = 'bbox', wordTrig = true }, {
			t { '╔' },
			f(replace_each '═', { 1 }),
			t { '╗', '║' },
			i(1, { 'content' }),
			t { '║', '╚' },
			f(replace_each '═', { 1 }),
			t { '╝' },
			i(0),
		}),
		s({ trig = 'sbox', wordTrig = true }, {
			t { '*' },
			f(replace_each '-', { 1 }),
			t { '*', '|' },
			i(1, { 'content' }),
			t { '|', '*' },
			f(replace_each '-', { 1 }),
			t { '*' },
			i(0),
		}),
  }
})
