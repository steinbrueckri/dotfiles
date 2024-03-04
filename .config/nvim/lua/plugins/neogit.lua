return {
    "NeogitOrg/neogit",
    lazy = true,
    opts = {
        kind = "split", -- opens neogit in a split
        signs = {
            -- { CLOSED, OPENED }
            section = {"", ""},
            item = {"", ""},
            hunk = {"", ""}
        },
        integrations = {diffview = true} -- adds integration with diffview.nvim
    }
}
