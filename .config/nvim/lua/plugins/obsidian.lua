return {
  "epwalsh/obsidian.nvim",
  version = "v3.9.0", -- recommended, use latest release instead of latest commit
  -- lazy = true,
  -- event = {
  -- 	"BufReadPre " .. vim.fn.expand("~") .. "/notes/*.md",
  -- 	"BufNewFile " .. vim.fn.expand("~") .. "/notes/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/notes/",
      },
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    }, -- see below for full list of options 👇
  },
}
