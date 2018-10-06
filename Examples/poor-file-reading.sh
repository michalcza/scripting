#!/bin/bash

OIFS=$IFS
IFS=$'\n'


linecount=0
for line in $(cat ${1}); do
	linecount=$(( ${linecount} + 1 ))
done
echo "There are ${linecount} lines in ${1}."
