-----------------------------------------------------------
-- telescope configuration file
-----------------------------------------------------------

-- Plugin: telescope
-- https://github.com/nvim-telescope/telescope.nvim
-----------------------------------------------------------

require('telescope').setup{
  defaults = {
    color_devicons = true,
    preview = {
        filesize_hook = function(filepath, bufnr, opts)
            local max_bytes = 10000
            local cmd = {"head", "-c", max_bytes, filepath}
            require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
        end
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
       horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
       },
       vertical = {
          mirror = false,
       },
       width = 0.87,
       height = 0.80,
       preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
}

require('telescope').load_extension('projects')
require("telescope").load_extension("emoji")
require("telescope").load_extension("packer")
require("telescope").load_extension("file_browser")
