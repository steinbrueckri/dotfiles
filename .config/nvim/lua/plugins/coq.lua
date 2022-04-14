-----------------------------------------------------------
-- coq configuration file
-----------------------------------------------------------

-- Plugin: coq
-- https://github.com/ms-jpq/coq_nvim
-----------------------------------------------------------

vim.g.coq_settings = {
  auto_start = 'shut-up',
  clients = {
    tabnine = {
        enabled = true,
    }
  }
}

require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
  { src = "vimtex", short_name = "vTEX" },
  { src = "figlet", short_name = "BIG" },
}
