#!/bin/bash

function information() {
	printf '%-22s %-22s\n' "${1}" "${2}"
}

information "Username: " "$(id -nu)"
information "User ID: " "$(id -u)"
information "User Group Primary: " "$(id -ng)"
information "User Group Secondary: " "$(id -nG)"

function kernel() {
	printf '%-22s %-22s\n' "${1}" "${2}"
}

kernel "Kerel: " "$(uname -v)"
kernel "Version: " "$(uname -r)"
kernel "Architecture: " "$(uname -p)"


#UserName=$('id -nu')
#UserID=$('id -u')
#UserGroupPrimary=$('id -ng')
#UserGroupSecondary=$('id -nG')






