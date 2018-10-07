#!/usr/bin/env python
# CREATES 80 CHAR WIDE ASCII TABLE FROM CSV FILE WITH NEWLINE AS NEEDED IN EACH ROW
# -*- coding: utf-8 -*-
import pandas
import beautifultable
import sys
import os
import os.path

try:
    sys.argv[1:]
    # INPUT
    INFILE = sys.argv[1]
    # CHECK IF FILE EXISTS
    if os.path.isfile(INFILE) and os.access(INFILE, os.R_OK):
        print " **** INPUT FILE EXISTS AND IS READABLE, CONTINUING. ****"
        my_dataframe = pandas.read_csv(INFILE, skip_blank_lines=True)
        headers = list(my_dataframe)
        lists = my_dataframe.values.tolist()
        my_table = beautifultable.BeautifulTable()
        my_table.column_headers = headers
        # WRITE TO TABLE
        for item in lists:
            my_table.append_row(item)
        # OUTPUT RESULTS
            print(my_table)
            print >>f1, 'THIS IS WHERE WE CAN PRINT TO A FILE VERSUS BASH REDIRECT'
            exit(1)
    else:
        print "**** INPUT FILE IS MISSING OR NOT READABLE ****"
        print " Usage syntax is $> python ASCIItable.py {filename}"
        exit(1)
except IndexError:
        print " **** PLEASE SPECIFY FILE TO CONVERT ****"
        sys.exit()
