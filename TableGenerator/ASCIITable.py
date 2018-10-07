#!/usr/bin/env python
# CREATES FIXED CHAR WIDE ASCII TABLE FROM CSV FILE WITH NEWLINE AS NEEDED IN EACH ROW
# -*- coding: utf-8 -*-
import pandas
import beautifultable
import sys
import os
import os.path

def error_syntax():
    print(" Usage syntax is $> python ASCIItable.py {input file} > {output file}")
def read_success():
    print(" **** SUCCESS: INPUT FILE EXISTS AND IS READABLE, CONTINUING. ****")
def read_error():
    print(" **** ERROR: INPUT FILE IS MISSING OR NOT READABLE, EXITING. ****")
    error_syntax()
    exit(1)
def error_file():
    print(" **** ERROR: PLEASE SPECIFY CSV FILE TO CONVERT, EXITING. ****")
    error_syntax()
    exit(1)
def style_custom():
    my_table.left_border_char = '|'
    my_table.right_border_char = '|'
    my_table.top_border_char = '#'
    my_table.bottom_border_char = '= '
    my_table.header_separator_char = '#'
    my_table.row_separator_char = '- '
    my_table.intersection_char = '+'
    my_table.column_separator_char = ':'

try:
    sys.argv[1:]
    # INPUT
    INFILE = sys.argv[1]
    # CHECK IF FILE EXISTS
    if os.path.isfile(INFILE) and os.access(INFILE, os.R_OK):
        read_success()
        # CREATE TABLE
        my_dataframe = pandas.read_csv(INFILE, skip_blank_lines=True)
        headers = list(my_dataframe)
        lists = my_dataframe.values.tolist()
        my_table = beautifultable.BeautifulTable(max_width=100, default_padding=2)
        my_table.column_headers = headers
        # WRITE TO TABLE
        for item in lists:
            my_table.append_row(item)
        # OUTPUT RESULTS
        style_custom()
        print(my_table)
        #print >>f1, 'THIS IS WHERE WE CAN PRINT TO A FILE VERSUS BASH REDIRECT'
        exit(1)
    else:
        read_error()
except IndexError:
        error_file()
