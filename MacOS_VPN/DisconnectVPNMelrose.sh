#!/bin/bash
function vpn-disconnect {
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "Melrose" -- your VPN name here
                if exists VPN then disconnect VPN
        end tell
end tell
return
EOF
}