-----------------------------------------------------------
-- dashboard configuration file
-----------------------------------------------------------

-- Plugin: dashboard
-- https://github.com/glepnir/dashboard-nvim
-----------------------------------------------------------

vim.g.dashboard_default_executive ='telescope'

vim.g.dashboard_custom_section = {
    a = {description = {'  New Buffer         '}, command = 'ene'},
    b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
    c = {description = {'  Projects           '}, command = 'Telescope project'},
    x = {description = {'  Settings           '}, command = ':e ~/.config/nvim/init.lua'}
}

