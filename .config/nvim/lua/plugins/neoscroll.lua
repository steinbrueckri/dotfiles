local function post_hook(info)
	local neoscroll = require("neoscroll")

	if info == nil then
		return
	end

	if info.move_view ~= nil then
		vim.defer_fn(function()
			neoscroll.scroll(info.move_view.lines, {
				move_cursor = false,
				duration = info.move_view.duration,
			})
		end, 10)
	end

	if info.move_cursor ~= nil then
		vim.defer_fn(function()
			vim.api.nvim_win_set_cursor(0, {
				math.max(1 - vim.fn.line("."), math.min(vim.fn.line("$"), vim.fn.line(".") + info.move_cursor.lines)),
				vim.api.nvim_win_get_cursor(0)[2],
			})
		end, 10 + info.move_cursor.duration)
	end
end

local function scroll_and_center(scroll, half_win_duration)
	local window_height = vim.api.nvim_win_get_height(0)
	local topmost_line = vim.fn.line("w0")
	local current_middle_line = topmost_line + math.ceil(window_height / 2)
	local current_line = vim.fn.line(".")

	local off_target = math.max(-current_line + 1, math.min(scroll, vim.fn.line("$") - current_line))
	local off_center = current_line - current_middle_line

	local both_scroll = 0
	local view_scroll = 0
	local cursor_scroll = 0
	-- both scrolls work together in one direction
	if off_center * off_target >= 0 then
		both_scroll = off_target
		view_scroll = off_center
		cursor_scroll = 0
	else
		both_scroll = off_target + off_center -- off_center is opposite to off target here, so actually its substracting
		view_scroll = 0
		cursor_scroll = -off_center
	end

	local both_scroll_duration = math.floor(half_win_duration * (math.abs(both_scroll) / (window_height / 2)) + 0.5)
	local view_scroll_duration = math.floor(half_win_duration * (math.abs(view_scroll) / (window_height / 2)) + 0.5)
	local cursor_scroll_duration = math.floor(half_win_duration * (math.abs(cursor_scroll) / (window_height / 2)) + 0.5)

	if both_scroll == 0 then
		post_hook({
			move_view = {
				duration = view_scroll_duration,
				lines = view_scroll,
			},
			move_cursor = {
				duration = cursor_scroll_duration,
				lines = cursor_scroll,
			},
		})
	else
		require("neoscroll").scroll(both_scroll, {
			move_cursor = true,
			duration = both_scroll_duration,
			info = {
				move_view = {
					duration = view_scroll_duration,
					lines = view_scroll,
				},
				move_cursor = {
					duration = cursor_scroll_duration,
					lines = cursor_scroll,
				},
			},
		})
	end
end

return {
  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        mappings = {},
        -- pre_hook = function(info) end,
        post_hook = post_hook,
      })
      local keymap = {
        ["<S-up>"] = function()
          scroll_and_center(-vim.wo.scroll, 100)
          -- neoscroll.ctrl_u({ duration = 150 })
        end,
        ["<S-down>"] = function()
          scroll_and_center(vim.wo.scroll, 100)
          -- neoscroll.ctrl_d({ duration = 150 })
        end,
        ["G"] = function()
        	neoscroll.G({ half_win_duration = 100 })
        end,
        ["gg"] = function()
        	neoscroll.gg({ half_win_duration = 100 })
        end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  }
}
