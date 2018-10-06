#!/bin/bash

smartctl --all /dev/sda | awk '/ID#/{f=1} f{if($1 ~ /^(ID#|5|187|188|197|198)$/) printf "%-3s %-23s %s\n",$1,$2,$NF; if (!NF) f=0}'
