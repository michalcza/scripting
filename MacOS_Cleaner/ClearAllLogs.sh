#!/bin/bash
#find file inside of folder older than +1 days
#find /var/log -type f -mtime +1

#find file with extension .bak and DELETE it 
#CAREFUL THIS CALLS ROOT FODER AND EVERYTHING DOWNSTREAM
#find . -type f -name "*.bak" -exec rm -f {} \;

### TO DO ###
#- WAIT FOR COMMANDS TO FINISH BEFORE CONTINUING (apparently you do this with a loop)


##### LOG FILES #####

#find files inside of FOLDER that are +1 days old and DELETE
find /var/log -type f -mtime +1 -exec srm -f {} \;
find /private/var/log -type f -mtime +1 -exec srm -f {} \;
find ~/Library/Logs -type f -mtime +1 -exec srm -f {} \;

#SHOW all downloaded items in quarantine for user
#sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | sort

#SEARCH and CLEAR download quarantine log
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'

#history of servers that finder connected to and DVDs mounted
find ~/Library/Preferences/com.apple.finder.plist -type f -mtime +1 -exec srm -f {} \;

#disk images .dmg that have been burned using DiskUtility
find ~/Library/Preferences/com.apple.DiskUtility.plist -type f -mtime +1 -exec srm -f {} \;

#Safari items
find ~/Library/Preferences/com.apple.Safari.plist -type f -mtime +1 -exec srm -f {} \;


##### CACHES #####

find ~/Library/Caches/Safari -type f -mtime +1 -exec srm -f {} \;

find ~/Library/Caches/ -type f -mtime +1 -exec srm -f {} \;

find ~/Library/Caches -type f -mtime +1 -exec srm -f {} \;

##### APPLICATIONS #####

#iChat
find ~/Library/Preferences/com.apple.iChat.AIM.plist -type f -mtime +1 -exec srm -f {} \;

#recent Preview items
find ~/Library/Preferences/com.apple.Preview.bookmarks.plist -type f -mtime +1 -exec srm -f {} \;

#recent desktop connections
find ~/Library/Preferences/com.apple.RemoteDesktop.plist -type f -mtime +1 -exec srm -f {} \;

#last ipod connnected
find ~/Library/Preferences/com.apple.iPod.plist -type f -mtime +1 -exec srm -f {} \;

#address book

find ~/Library/Caches/com.apple.AddressBook/MetaData -type f -mtime +1 -exec srm -f {} \;

#recent items

find ~/Library/Preferences/com.apple.recentitems.plist -type f -mtime +1 -exec srm -f {} \;

#recent Quicktime
 
find ~/Library/Preferences/com.apple.quicktimeplayer.plist -type f -mtime +1 -exec srm -f {} \;

##### VARIOUS #####

#original registrant of computer

find ~/Library/Assistants/Sendregistration.setup -type f -mtime +1 -exec srm -f {} \;

find ~/Library/Preferences/AddressBookMe.plist -type f -mtime +1 -exec srm -f {} \;

#DNS cache
sudo discoveryutil mdnsflushcache
sudo discoveryutil udnsflushcaches

#remove sleep image
sudo srm /private/var/vm/sleepimage

#check sleep image status
#pmset -g | grep hibernatemode
#hibernatemode 0 - disabled
#hibernatemode 3 - enabled






