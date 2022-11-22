require("silicon").setup({
    theme = "Monokai Extended",
    output = string.format("~/tmp/screenshots/silicon_%s-%s-%s_%s-%s.png", os.date("%Y"), os.date("%m"), os.date("%d"),
                           os.date("%H"), os.date("%M")), -- auto generate file name based on time (absolute or relative to cwd)
    bgColor = "#fff0", -- vim.g.terminal_color_5,
    bgImage = "", -- path to image, must be png
    roundCorner = true,
    windowControls = true,
    lineNumber = true,
    font = "Hack Nerd Font",
    lineOffset = 1, -- from where to start line number
    linePad = 2, -- padding between lines
    padHoriz = 20, -- Horizontal padding
    padVert = 20, -- vertical padding
    shadowBlurRadius = 10,
    shadowColor = "#555555",
    shadowOffsetX = 8,
    shadowOffsetY = 8
})

vim.api.nvim_create_user_command("Silicon", "lua require('silicon').visualise_cmdline({})", {nargs = 0, range = true})
vim.api.nvim_create_user_command("SiliconPb", "lua require('silicon').visualise_cmdline({to_clip = true})",
                                 {nargs = 0, range = true})
