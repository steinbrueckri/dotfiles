-- Define variables for keyboard layout and script path
local layoutUS = "com.apple.keylayout.USInternational-PC"
local layoutDE = "com.apple.keylayout.German"
local bluetoothScriptPath = hs.fs.pathToAbsolute("~") .. "/bin/check_bluetooth.sh"
local bluetoothKeyboardName = "NuPhy Air60 V2-1"
local timer = 5

-- Enable log.dng
local log = hs.logger.new("keyboardLayout", "info")

-- Function to change the keyboard layout
function setKeyboardLayout(layout)
	local currentLayout = hs.execute("/opt/homebrew/bin/InputSourceSelector current")
	log.d("Current layout: " .. currentLayout)
	local currentLayoutID = string.match(currentLayout, "^[^ ]+") -- Extract the layout ID from the output
	log.d("Current layout ID: " .. currentLayoutID)
	if currentLayoutID ~= layout then
		log.i("Changing layout to: " .. layout)
		hs.execute("/opt/homebrew/bin/InputSourceSelector select " .. layout)
		hs.alert.show("Keyboard layout set to " .. layout)
	else
		log.d("Layout already set to: " .. layout)
	end
end

-- Check if a specific Bluetooth keyboard is connected
function checkBluetoothKeyboard()
	log.d("Checking for specific Bluetooth keyboard...")
	local task = hs.task.new(bluetoothScriptPath, function(exitCode, stdOut, stdErr)
		log.d("Bluetooth script exit code: " .. exitCode)
		log.d("Bluetooth script stdOut: " .. stdOut)
		log.d("Bluetooth script stdErr: " .. stdErr)
		if stdOut:find("connected") and not stdOut:find("disconnected") then
			log.d("Bluetooth keyboard connected: " .. bluetoothKeyboardName)
			setKeyboardLayout(layoutUS)
		else
			log.d("Bluetooth keyboard not connected")
			setKeyboardLayout(layoutDE)
		end
	end, { bluetoothKeyboardName })
	log.d("Starting Bluetooth check task...")
	task:start()
end

-- Initial check at the start of Hammerspoon
checkBluetoothKeyboard()

-- Regular check of Bluetooth status
bluetoothTimer = hs.timer.doEvery(timer, checkBluetoothKeyboard) -- Checks every 10 seconds
