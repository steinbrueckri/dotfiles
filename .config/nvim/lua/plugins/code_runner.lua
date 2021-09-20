-----------------------------------------------------------
-- code_runner configuration file
-----------------------------------------------------------

-- Plugin: code_runner
-- https://github.com/CRAG666/code_runner.nvim
-----------------------------------------------------------

require('code_runner').setup {
  term = {
    position = "vert",
    size = 8
  },
  filetype = {
    map = "<leader>r",
  },
  project_context = {
    map = "<leader>r",
  }
}

