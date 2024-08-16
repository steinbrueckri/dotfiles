-- Load necessary extensions
hs.logger.defaultLogLevel = "info"
local log = hs.logger.new("init", "info")

-- Load individual modules
local function loadModule(moduleName)
	local ok, err = pcall(require, moduleName)
	if not ok then
		log.e("Error loading module " .. moduleName .. ": " .. err)
	else
		log.i("Loaded module " .. moduleName)
	end
end

-- Modules to load
local modules = {
	"modules.keyboard",
	"modules.libre",
}

-- Load all modules
for _, moduleName in ipairs(modules) do
	loadModule(moduleName)
end

-- Watch for changes in the configuration directory and reload
hs.pathwatcher
	.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
		local doReload = false
		for _, file in pairs(files) do
			if file:sub(-4) == ".lua" then
				doReload = true
			end
		end
		if doReload then
			hs.reload()
		end
	end)
	:start()
log.i("Config loaded")
hs.alert.show("Config loaded")
