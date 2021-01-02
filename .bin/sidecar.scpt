tell application "System Events" to tell process "ControlCenter"
  click menu bar item "Control Center" of menu bar 1
  tell group 1 of group 1 of window "Control Center"
    delay 1
    click checkbox "Connect to Sidecar"
    delay 1
    click checkbox "Adam Jahnke’s iPad"
  end tell
end tell
