#!/bin/bash
# Creates or appends to log file based on date and command used.
# Tee can be replaced with typical redirection.  Use &>> to append stdout and stderr to a file without printing on screen.
# Provide script or command to logger as arguments in order to log output of that command/script.

# Variables
LOGLOCATION=~/logs
LOGFILE="$LOGLOCATION/$1.$(date +%Y-%m-%d).log"
COMMAND=$1
FULLCOMMAND=$@
# End Variables

# Functions
# Returns date and time.  
# EX: 2018-09-06_09:51:32
DATETIME () {
	echo "$(date +%Y-%m-%d_%H:%M:%S)"
}

# Returnes date and time followed by argument 1 from script and then a word supplied as an argument
# EX:  2018-09-06_09:51:32 apt Logging Started
LOGGING() {
	echo "$(DATETIME) $COMMAND Logging $1" | tee -a $LOGFILE
}

# Executes and logs command supplied as argument to script.
# Logs stdout and stderr
LOGGINGTOFILE() {
	$@ 2>&1 | tee -a $LOGFILE
	#Allows for seperate stdout and stderr files
	#$@ > >(tee -a $LOGFILE) 2> >(tee -a $LOGFILE >&2)
}

# Returns date, time and all arguments provided to script.
# EX: 2018-09-06_09:51:32 Command Issued: apt update
COMMANDISSUED() {
        echo "$(DATETIME) Command Issued: $FULLCOMMAND" | tee -a $LOGFILE
}
# End Functions

LOGGING STARTED
COMMANDISSUED
LOGGINGTOFILE $FULLCOMMAND
LOGGING FINISHED
