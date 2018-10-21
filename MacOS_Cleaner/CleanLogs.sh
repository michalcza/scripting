#!/bin/bash
set -e

##### LOG FILES #####

#find files inside of FOLDER that are +1 days old and DELETE
find /var/log -type f -mtime +1 -exec srm -f {} \;
wait
find /private/var/log -type f -mtime +1 -exec srm -f {} \;
wait
find ~/Library/Logs -type f -mtime +1 -exec srm -f {} \;
wait

#SEARCH and CLEAR download quarantine log
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
wait

#history of servers that finder connected to and DVDs mounted
find ~/Library/Preferences/com.apple.finder.plist -type f -mtime +1 -exec srm -f {} \;
wait

#disk images .dmg that have been burned using DiskUtility
find ~/Library/Preferences/com.apple.DiskUtility.plist -type f -mtime +1 -exec srm -f {} \;
wait

#Safari items
find ~/Library/Preferences/com.apple.Safari.plist -type f -mtime +1 -exec srm -f {} \;
wait


##### CACHES #####

find ~/Library/Caches/Safari -type f -mtime +1 -exec srm -f {} \;
wait

find ~~/Library/Caches/ -type f -mtime +1 -exec srm -f {} \;
wait

find ~/Library/Caches -type f -mtime +1 -exec srm -f {} \;
wait

##### APPLICATIONS #####

#iChat
find ~/Library/Preferences/com.apple.iChat.AIM.plist -type f -mtime +1 -exec srm -f {} \;
wait

#recent Preview items
find ~/Library/Preferences/com.apple.Preview.bookmarks.plist -type f -mtime +1 -exec srm -f {} \;
wait

#recent desktop connections
find ~/Library/Preferences/com.apple.RemoteDesktop.plist -type f -mtime +1 -exec srm -f {} \;
wait

#last ipod connnected
find ~/Library/Preferences/com.apple.iPod.plist -type f -mtime +1 -exec srm -f {} \;
wait

#address book

find ~~/Library/Caches/com.apple.AddressBook/MetaData -type f -mtime +1 -exec srm -f {} \;
wait

#recent items

find ~/Library/Preferences/com.apple.recentitems.plist -type f -mtime +1 -exec srm -f {} \;
wait

#recent Quicktime
 
find ~/Library/Preferences/com.apple.quicktimeplayer.plist -type f -mtime +1 -exec srm -f {} \;
wait

##### VARIOUS #####

#original registrant of computer
find ~/Library/Assistants/Sendregistration.setup -type f -mtime +1 -exec srm -f {} \;
wait

find ~/Library/Preferences/AddressBookMe.plist -type f -mtime +1 -exec srm -f {} \;
wait

#DNS cache
sudo discoveryutil mdnsflushcache
wait
sudo discoveryutil udnsflushcaches
wait

#remove sleep image
sudo srm /private/var/vm/sleepimage
wait

#check sleep image status
#pmset -g | grep hibernatemode
#hibernatemode 0 - disabled
#hibernatemode 3 - enabled

#find file inside of folder older than +1 days
#find /var/log -type f -mtime +1

#SHOW all downloaded items in quarantine for user
#sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | sort




