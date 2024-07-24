-- Define variables for keyboard layout and script path
local layoutUS = "com.apple.keylayout.USInternational-PC"
local layoutDE = "com.apple.keylayout.German"
local bluetoothScriptPath = hs.fs.pathToAbsolute("~") .. "/bin/check_bluetooth.sh"
local bluetoothKeyboardName = "NuPhy Air60 V2-1"
local timer = 5

-- Enable logging
local log = hs.logger.new("keyboardLayout", "info")

-- Function to change the keyboard layout
function setKeyboardLayout(layout)
	local currentLayout = hs.execute("/usr/local/bin/InputSourceSelector current")
	log.i("Current layout: " .. currentLayout)
	local currentLayoutID = string.match(currentLayout, "^[^ ]+") -- Extract the layout ID from the output
	log.i("Current layout ID: " .. currentLayoutID)
	if currentLayoutID ~= layout then
		log.i("Changing layout to: " .. layout)
		hs.execute("/usr/local/bin/InputSourceSelector select " .. layout)
		hs.alert.show("Keyboard layout set to " .. layout)
	else
		log.i("Layout already set to: " .. layout)
	end
end

-- Check if a specific Bluetooth keyboard is connected
function checkBluetoothKeyboard()
	log.i("Checking for specific Bluetooth keyboard...")
	local task = hs.task.new(bluetoothScriptPath, function(exitCode, stdOut, stdErr)
		log.i("Bluetooth script exit code: " .. exitCode)
		log.i("Bluetooth script stdOut: " .. stdOut)
		log.i("Bluetooth script stdErr: " .. stdErr)
		if stdOut:find("connected") and not stdOut:find("disconnected") then
			log.i("Bluetooth keyboard connected: " .. bluetoothKeyboardName)
			setKeyboardLayout(layoutUS)
		else
			log.i("Bluetooth keyboard not connected")
			setKeyboardLayout(layoutDE)
		end
	end, { bluetoothKeyboardName })
	log.i("Starting Bluetooth check task...")
	task:start()
end

-- Initial check at the start of Hammerspoon
checkBluetoothKeyboard()

-- Regular check of Bluetooth status
bluetoothTimer = hs.timer.doEvery(timer, checkBluetoothKeyboard) -- Checks every 10 seconds
