return {
    "aserowy/tmux.nvim",
    opts = {
        copy_sync = {
            enable = true,
            ignore_buffers = {empty = false},
            redirect_to_clipboard = true,
            sync_clipboard = false,
            sync_registers = true,
            sync_deletes = true,
            sync_unnamed = true
        },
        navigation = {cycle_navigation = false, enable_default_keybindings = false, persist_zoom = false},
        resize = {enable_default_keybindings = false}

    }
}
