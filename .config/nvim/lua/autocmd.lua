-- Autocommand that automatically format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.md,*.yaml,*.yml,*.go,*.py,*.json,*.tf FormatWrite
augroup END
]], true)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | Lazy sync
  augroup end
]]

-- Autocommand that set numbers to relative in normal mode, absolute in insert
vim.cmd [[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set nornu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set rnu | endif
augroup END
]]

-- Autocommand that highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]]

-- Autocommand set file type to ansible based on path
vim.cmd [[
  augroup AnsiFileType
    autocmd!
    autocmd BufRead,BufNewFile */ansible/**.yml set filetype=yaml.ansible
  augroup end
]]
