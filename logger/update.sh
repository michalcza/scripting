#!/bin/bash

# Functions
# Returns date and time.  EX: 2018-09-06_09:51:32
DATETIME() {
	echo "$(date +%Y-%m-%d_%H:%M:%S)"
}

# Returns date and time along with two words used as arguments.  
# EX: 2018-09-06_09:51:32 Stopping Sophos
LOGGING() {
	echo "$(DATETIME) $1 $2"
}

# Starts or stops sophos.  start or stop would be supplied as argument. 
# EX: SOPHOSCONTROL stop
SOPHOSCONTROL() {
	systemctl $1 sav-protect.service
}

# Runs apt update and if successful then runs apt upgrade specifying yes to prompts
UPDATEANDUPGRADE() {
	apt update && apt upgrade -y
}
# End Functions

# Stop sophos
LOGGING Stopping Sophos
SOPHOSCONTROL stop
LOGGING Stopped Sophos 
# Start update and upgrade
LOGGING Starting Update 
UPDATEANDUPGRADE
LOGGING Completed Update
# Start sophos
LOGGING Starting Sophos
SOPHOSCONTROL start
LOGGING Started Sophos
# Announce that script is finished
LOGGING Script Finished
