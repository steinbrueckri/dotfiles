return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "Telekasten" },
    -- stylua: ignore
    keys = {
      { '<leader>nn', function() require('telekasten').goto_thisweek() end },
      { '<leader>nN', function() require('telekasten').new_note() end },
      { '<leader>nf', function() require('telekasten').find_notes() end },
      { '<leader>na', function() require('telekasten').search_notes() end },
      { '<leader>N',  function() require('telekasten').panel() end },
    },
    opts = {
      home = vim.fn.expand("~/notes/"),
      dailies = vim.fn.expand("~/notes/daily"),
      weeklies = vim.fn.expand("~/notes/weekly"),
      templates = vim.fn.expand("~/notes/templates"),
      extension = ".md",

      follow_creates_nonexisting = true,
      dailies_create_nonexisting = true,
      weeklies_create_nonexisting = true,

      template_new_note = vim.fn.expand("~/notes/templates/new_note.md"),
      template_new_daily = vim.fn.expand("~/notes/templates/daily.md"),
      template_new_weekly = vim.fn.expand("~/notes/templates/weekly.md"),
    },
  },
}
