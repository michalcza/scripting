#!/bin/sh
#set -x
 
from="michal@example.com"
to="mczarnecki@gmail.com"
subject="Some fancy title"
body="This is the body of our email"
declare -a attachments
attachments=( "/tmp/motion/09-20160210015815-03.jpg" "/tmp/motion/20160210-timelapse.mpg" )
 
declare -a attargs
for att in "${attachments[@]}"; do
  attargs+=( "-a"  "$att" )  
done
 
mail -s "$subject" -r "$from" "${attargs[@]}" "$to" <<< "$body"

        