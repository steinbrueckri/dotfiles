#!/usr/bin/env bash
###############################################################################
# Global Config                                                               #
###############################################################################

# Create cronjob
if [ $(crontab -l | grep brew | wc -l) -eq 0 ]; then
  (
    crontab -l
    echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    echo "0 */3 * * * brew bundle dump --force --file ~/.Brewfile"
  ) | crontab -
fi

# Ask for the administrator password upfront
sudo -v

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# General Settings                                                            #
###############################################################################
echo "Apply General Settings"
# Set Avatar Image
sudo dscl . -delete /Users/$USER JPEGPhoto
sudo dscl . -delete /Users/$USER Picture
sudo dscl . -create /Users/$USER Picture "$HOME/.dotfileassets/me.jpg"

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show battery as percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Set misson controlle on the upper right corner
defaults write com.apple.dock wvous-tr-corner -int 2

# Trackpad/Mouse: Fix the scrolling or disable natural scrolling ;)
defaults write com.apple.swipescrolldirection -int 1

## set hostname
sudo scutil --set ComputerName "Anubis"
sudo scutil --set HostName "anubis"
sudo scutil --set LocalHostName "Anubis"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Anubis"

# Save screen shots to other location
mkdir -p "${HOME}/tmp/screenshots"
defaults write com.apple.screencapture location -string "${HOME}/tmp/screenshots"

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Show date on the menu bar
## Ref: https://www.tech-otaku.com/mac/setting-the-date-and-time-format-for-the-macos-menu-bar-clock-using-terminal/
## Thu 18 Aug 23:46:18 	-> EEE d MMM HH:mm:ss
## Thu 18 Aug 11:46:18 pm	-> EEE d MMM h:mm:ss a
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"

## make the keys faster
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

###############################################################################
# ShortCut Settings                                                           #
###############################################################################
echo "OSX ShortCut Settings"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen

# Top left screen corner
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# Bottom left screen corner
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

# Top right screen corner
defaults write com.apple.dock wvous-tr-corner -int 3
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom right screen corner
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

############################################################################
# Alfred                                                                   #
############################################################################
echo "Alfred Settings"
# Disable spotlight shortcuts for Alfred
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"

# Set spotline shortcut for alfred
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add key 49
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add mod 1048576
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add string "Space"

############################################################################
# Magnet                                                                   #
############################################################################
echo "Magnet Settings"
# Set keyboard mappings for Magnet
defaults write com.crowdcafe.windowmagnet expandWindowEastComboKey -dict keyCode 124 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet expandWindowWestComboKey -dict keyCode 123 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet maximizeWindowComboKey -dict keyCode 126 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet restoreWindowComboKey -dict keyCode 125 modifierFlags 1572864

###############################################################################
# Finder Settings                                                             #
###############################################################################
echo "Finder Settings"
# disable siri icon
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool false

# dont show any icon on the desktop
defaults write com.apple.finder CreateDesktop false

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# disable user switcher
defaults write com.apple.menuextra.appleuser -int 0

###############################################################################
# Audio                                                                       #
###############################################################################
# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" -int 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" -int 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" -int 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" -int 80

###############################################################################
# Kill affected applications                                                  #
###############################################################################
for app in "Activity Monitor" \
  "Address Book" \
  "Calendar" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Magnet" \
  "Alfred" \
  "Finder" \
  "Google Chrome Canary" \
  "Google Chrome" \
  "SystemUIServer" \
  "iCal"; do
  killall "${app}" &>/dev/null
done
