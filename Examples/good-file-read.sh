#!/bin/bash


linecount=0
while read sLine; do

	linecount=$(( ${linecount} + 1 ))

done < <(cat ${1})

echo "There are ${linecount} lines in ${1}."
