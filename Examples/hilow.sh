#!/bin/bash
#	game picks random number
#	user picks number between 1-100
#	game tells if number is high or low
#	user gets another chance
#	track score and store to file

iGameNum=$(( ($RANDOM % 100) + 1))
echo "Welcom Professor, would you like to play a game?"
echo -n "Please pick a number between 1-100"

if [ "${iUserNum}" -eq "${iGameNum}"]; then
	echo "YOU ARE A WINNER"
elseif [if [ "${iUserNum}" -eq "${iGameNum}"]; then
        echo "YOU ARE A WINNER"

