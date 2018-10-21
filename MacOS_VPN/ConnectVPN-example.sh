function vpn-connect {
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "UniVPN" -- your VPN name here
                if exists VPN then connect VPN
                repeat while (current configuration of VPN is not connected)
                    delay 1
                end repeat
        end tell
end tell
EOF
}

function vpn-disconnect {
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "UniVPN" -- your VPN name here
                if exists VPN then disconnect VPN
        end tell
end tell
return
EOF
}

#####
class SwitchIp

def go
  turn_off
  sleep 3
  turn_on
end

def turn_on
  `/usr/bin/env osascript <<-EOF
      tell application "System Events"
        tell current location of network preferences
            set VPN to service "StrongVPN" -- your VPN name here
            if exists VPN then connect VPN
      end tell
    end tell
  EOF` 
end

def turn_off
  `/usr/bin/env osascript <<-EOF
    tell application "System Events"
      tell current location of network preferences
            set VPN to service "StrongVPN" -- your VPN name here
            if exists VPN then disconnect VPN
      end tell
  end tell
 EOF`
end

end