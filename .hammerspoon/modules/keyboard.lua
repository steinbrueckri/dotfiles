-- Define variables for keyboard layout and script path
local layoutUS = "com.apple.keylayout.USInternational-PC"
local layoutDE = "com.apple.keylayout.German"
local bluetoothScriptPath = hs.fs.pathToAbsolute("~") .. "/bin/check_bluetooth.sh"
local keyboards = { "NuPhy Air60 V2-1", "Adv360 Pro" } -- List of keyboards (USB or Bluetooth)

local log = hs.logger.new("keyboard", "info")

-- Dynamically find the InputSourceSelector path
local inputSourceSelector = hs.execute("command -v InputSourceSelector")
inputSourceSelector = inputSourceSelector and inputSourceSelector:gsub("\n", "")

-- Use a fallback path if not found
if not inputSourceSelector or inputSourceSelector == "" then
    inputSourceSelector = "/opt/homebrew/bin/InputSourceSelector" -- Default for macOS ARM
end

-- Ensure the file actually exists
if not hs.fs.attributes(inputSourceSelector) then
    log.e("InputSourceSelector not found at " .. inputSourceSelector .. ". Keyboard layout switching disabled.")
    inputSourceSelector = nil -- Disable layout switching if not found
end

-- Function to change the keyboard layout
function setKeyboardLayout(layout)
    if not inputSourceSelector or inputSourceSelector == "" then
        log.e("Cannot change layout, InputSourceSelector not found.")
        return
    end

    local currentLayout = hs.execute(inputSourceSelector .. " current")

    -- Ensure currentLayout is not nil or empty
    if not currentLayout or currentLayout == "" then
        log.e("Failed to get current keyboard layout. Skipping layout change.")
        return
    end

    local currentLayoutID = string.match(currentLayout, "^[^ ]+") or "" -- Prevent nil values
    if currentLayoutID == "" then
        log.e("Failed to extract layout ID from: " .. currentLayout)
        return
    end

    log.i("Current layout ID: " .. currentLayoutID)

    if currentLayoutID ~= layout then
        log.i("Changing layout to: " .. layout)
        hs.execute(inputSourceSelector .. " select " .. layout)
        hs.alert.show("Keyboard layout set to " .. layout)
    else
        log.i("Layout already set to: " .. layout)
    end
end

-- Check if any of the keyboards are connected via USB
function checkUSBKeyboard()
    log.i("Checking for USB keyboards...")
    for _, device in ipairs(hs.usb.attachedDevices()) do
        log.i("Found USB device: " .. device.productName)
        for _, keyboard in ipairs(keyboards) do
            if device.productName == keyboard then
                log.i("USB keyboard connected: " .. keyboard)
                setKeyboardLayout(layoutUS)
                return true -- USB keyboard found, no need to check Bluetooth
            end
        end
    end
    log.i("No USB keyboards detected.")
    return false
end

-- Check if any of the keyboards are connected via Bluetooth
function checkBluetoothKeyboard()
    log.i("Checking for Bluetooth keyboards...")
    local foundBluetooth = false

    for _, keyboard in ipairs(keyboards) do
        local task = hs.task.new(bluetoothScriptPath, function(exitCode, stdOut, stdErr)
            log.i("Bluetooth script output for " .. keyboard .. ": " .. stdOut)
            if stdOut:find("connected") and not stdOut:find("disconnected") then
                log.i("Bluetooth keyboard connected: " .. keyboard)
                setKeyboardLayout(layoutUS)
                foundBluetooth = true
            end
        end, { keyboard })
        task:start()
    end

    -- If no Bluetooth keyboard is found after 2 seconds, switch to German layout
    hs.timer.doAfter(2, function()
        if not foundBluetooth then
            log.i("No Bluetooth keyboards detected. Setting layout to German.")
            setKeyboardLayout(layoutDE)
        end
    end)
end

-- Combined check: USB first, then Bluetooth
function checkKeyboards()
    if not checkUSBKeyboard() then
        checkBluetoothKeyboard()
    end
end

-- Watch for USB changes
usbWatcher = hs.usb.watcher.new(checkKeyboards)
usbWatcher:start()

-- Initial check
checkKeyboards()

-- Regular Bluetooth check
bluetoothTimer = hs.timer.doEvery(10, checkKeyboards)