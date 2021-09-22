-----------------------------------------------------------
-- bufferline configuration file
-----------------------------------------------------------

-- Plugin: bufferline
-- https://github.com/akinsho/bufferline.nvim
-----------------------------------------------------------
require('bufferline').setup{
    options = {
        buffer_close_icon = 'x',
        close_icon = 'X',
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_close_icon = false,
        show_buffer_close_icons = false,
        left_trunk_marker = '<',
        right_trunk_marker = '>',
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        sorty_by = 'directory',
        show_tab_indicators = true,
        always_show_bufferline = true,
    },
}

vim.api.nvim_set_keymap('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<Cr>', { noremap = true })
