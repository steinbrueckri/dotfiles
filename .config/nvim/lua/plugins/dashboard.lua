-- TODO: Add also quick note

local version = vim.version()
local prerelease = ""
if version.prerelease then
	prerelease = "-DEV"
end
local nvim_version_info = "Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch .. prerelease

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			quickfile = {},
			dashboard = {
				sections = {
					{ section = "header", padding = 1 },
					{ icon = " ", section = "keys", indent = 2, padding = 1 },
					{ section = "startup" },
					{ text = nvim_version_info, align = "center", },
				},
				preset = {
					keys = {
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "l",
							desc = "Lazy",
							action = ":Lazy sync",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = " ",
							key = "m",
							desc = "Mason",
							action = ":Mason",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
	},
}
