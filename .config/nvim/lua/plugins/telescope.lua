-----------------------------------------------------------
-- telescope configuration file
-----------------------------------------------------------

-- Plugin: telescope
-- https://github.com/nvim-telescope/telescope.nvim
-----------------------------------------------------------

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { '.git/', 'node_modules/' },
    color_devicons = true,
    vimgrep_arguments = {
       "rg",
       "--color=never",
       "--no-heading",
       "--with-filename",
       "--line-number",
       "--column",
       "--smart-case",
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

require('telescope').load_extension('ultisnips')
require('telescope').load_extension('projects')
require("telescope").load_extension("emoji")

--- vim.api.nvim_set_keymap('n','<Leader>trc',":lua require('arpangreat.telescope').search_dotfiles()<CR>",{ noremap = true , silent = false })

search_notes_grep = function()
    require("telescope.builtin").live_grep({
        prompt_title = "< Notes >",
        cwd = "$HOME/notes/",
    })
end

search_notes = function()
    require("telescope.builtin").live_grep({
        prompt_title = "< Notes >",
        cwd = "$HOME/notes/",
    })
end
