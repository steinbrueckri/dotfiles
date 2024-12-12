return {
  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        mappings = {},
      })
      local keymap = {
        ["<S-up>"] = function()
          neoscroll.ctrl_u({ duration = 150 })
        end,
        ["<S-down>"] = function()
          neoscroll.ctrl_d({ duration = 150 })
        end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  }
}
