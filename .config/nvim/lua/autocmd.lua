vim.notify = require("notify")

-------------------------------------------------------------------------------
-- Helper functions
-------------------------------------------------------------------------------
-- Function to set FileType to yaml.ansible
local function set_ansible_filetype()
    vim.bo.filetype = "yaml.ansible"
    vim.notify("Set filetype to yaml.ansible", "info", {title = "Autocommnd"})
end

-- Function to check for the presence of "ansible.builtin" in the buffer
local function check_and_set_ansible_filetype()
    if vim.fn.search("ansible.builtin", "nw") > 0 then
        set_ansible_filetype()
    end
end

-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------
-- Autocommand that automatically format on save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"*.md", "*.yaml", "*.yml", "*.go", "*.py", "*.json", "*.tf"},
    command = "FormatWrite"
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd("BufWritePost", {pattern = "plugins.lua", command = "source <afile> | Lazy install"})

-- Autocommand that sets numbers to relative in normal mode, absolute in insert
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {
    pattern = "*",
    callback = function()
        if vim.wo.number and vim.fn.mode() ~= "i" then
            vim.wo.relativenumber = false
        end
    end
})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {
    pattern = "*",
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = true
        end
    end
})

-- Autocommand that highlights on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank {higroup = "IncSearch", timeout = 700}
    end
})

-- Autocommand set nowrap on adv360.keymap files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {pattern = "adv360.keymap", command = "set nowrap"})

-- Autocommand remove whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {pattern = "*", command = ":%s/\\s\\+$//e"})

-- Autocommand for setting FileType based on the filepath
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"},
                            {pattern = {"*/ansible/**/*.yml", "*/ansible/**/*.yaml"}, callback = set_ansible_filetype})

-- Autocommnd for setting FileType based on the buffer content
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"},
                            {pattern = {"*.yml", "*.yaml"}, callback = check_and_set_ansible_filetype})

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
