#!/usr/bin/env bash

# Start
echo "Starting $(basename "$0")"

# Ask for the administrator password upfront
sudo -v

echo "Closing any open System Preferences panes, to prevent them from overriding settings we’re about to change"
osascript -e 'tell application "System Preferences" to quit'

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General System
###############################################################################
# echo "Set computer name (as done via System Preferences → Sharing)"
# read -r -p "Please enter new hostname _: " _hn

# sudo scutil --set ComputerName "$_hn"
# sudo scutil --set HostName "$_hn"
# sudo scutil --set LocalHostName "$_hn"
# sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$_hn"


###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

echo "Start week on Monday"
defaults write com.apple.ical "first day of the week" 1


###############################################################################
# Photos                                                                      #
###############################################################################

# echo "Prevent Photos from opening automatically when devices are plugged in"
# defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


###############################################################################
# Firewall
###############################################################################

# echo "Enable the firewall"
# sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# echo "Enable stealth mode"
# sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on


###############################################################################
# Dock, Dashboard, and hot corners
###############################################################################

echo "Top right screen corner → Put display to sleep"
# Hot corners:
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
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0


###############################################################################
# TextEdit
###############################################################################

echo "TexEdit: Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0

echo "TexEdit: Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4


###############################################################################
# Messages
###############################################################################

echo "Messages: Disable continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

# Finished
echo "$(basename "$0") complete."

