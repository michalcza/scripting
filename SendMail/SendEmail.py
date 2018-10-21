
mail -s "subject" messagereceiver@gmail.com < /tmp/motion/textfilethatbecomesbodyofmessage.txt

mpack -s attachment /tmp/motion/filetoattach.jpg messagereceiver@gmail.com

#!/usr/bin/python
#
# timelapseOnDemand.py
# Creates a timelapse from this day
#
# Autor : Carlos Silva
# Data : 29/03/2015

# Import required Python libraries
import time
import datetime
import os

i = datetime.datetime.now()
name = “%s-%s-%s_%s-%s-%s” % (i.hour, i.minute, i.second, i.day, i.month,i.year)

timelapse = str(os.popen(“sudo jpeg2swf -o %s.swf /home/pi/webpage/files/*.jpg” % (nome)).read())
print “Timelapse ok”
email = str(os.popen(“sudo mpack -s ‘Timelapse on demand’ %s.swf my_email@internet.com” % (name)).read())
print “Email ok”
delete = str(os.popen(“sudo rm %s.swf” % (name)).read())
print “Ficheiro deleted”