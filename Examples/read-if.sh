#!/bin/bash

echo -n "Please enter your name: "
read sName


if [ "${sName}" = "Matthew" ]; then
	echo "Hello ${sName}, nice to meet you."
	echo "You are the greatest person in the world."
elif [ "${sName}" = "Bob" ]; then
	echo "BOBOBOBOBOBOBOBO"
else
	echo "You're a horrible person."
fi

echo "Goodbye."

