-- source: https://stackoverflow.com/questions/68694479/how-do-i-open-a-link-in-google-chrome-in-lua-for-neovim
M = {}
M.HandleURL = function()
  local url = string.match(vim.fn.getline("."), "[a-z]*://[^ >,;]*")
  if url ~= "" then
    vim.cmd('exec "!open \'' .. url .. '\'"')
  else
    vim.cmd('echo "No URI found in line."')
  end
end

vim.api.nvim_set_keymap("n", "gf", [[ <Cmd>lua M.HandleURL()<CR> ]], {})
