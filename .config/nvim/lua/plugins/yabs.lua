require('yabs'):setup({
  tasks = { -- Same values as `language.tasks`, but global
    build = {
      command = 'echo building project...',
      output = 'terminal',
    },
    run = {
      command = 'echo running project...',
      output = 'echo',
    },
  },
  opts = { -- Same values as `language.opts`
    output_types = {
      quickfix = {
        open_on_run = 'always',
      },
    },
  },
})

require('telescope').load_extension('yabs')
