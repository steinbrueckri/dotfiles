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
  }
}

require('telescope').load_extension('ultisnips')
require('telescope').load_extension('projects')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('frecency')
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
