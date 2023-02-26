require('mini.pairs').setup({
  -- -- In which modes mappings from this `config` should be created
  modes = { insert = true, command = false, terminal = false },
})

require('mini.surround').setup({
  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'sa', -- Add surrounding
    delete = 'sd', -- Delete surrounding
    replace = 'sr', -- Replace surrounding
  },
})

require('mini.trailspace').setup({
  -- Highlight only in normal buffers (ones with empty 'buftype'). This is
  -- useful to not show trailing whitespace where it usually doesn't matter.
  only_in_normal_buffers = true,
})

