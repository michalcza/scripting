#!/usr/bin/env python
# CREATES FIXED CHAR WIDE ASCII TABLE FROM CSV FILE WITH NEWLINE AS NEEDED IN EACH ROW
# -*- coding: utf-8 -*-
# 10/01/2020 MICHAL CZARNECKI:  ADDED GUI FOR FILE SELECTION
# TODO ADD SEPARATOR SELECTION CHARACTERS INTO GUI
# TODO ERROR HANDLING
# TODO OUTPUT AND INPUT DIRECTORIES
# SOURCES
# https://pysimplegui.readthedocs.io/en/latest/cookbook/
# https://www.geeksforgeeks.org/user-input-in-pysimplegui/
#
import os.path
import sys

import PySimpleGUI as sg
import beautifultable
import pandas

# if len(sys.argv) == 0:

    # if len(sys.argv) == 1:
WINDOW = sg.Window('CSV to ASCII',
                   [[sg.Text('This will convert CSV to fixed width ASCII text file')],
                   [sg.Text('_' * 80)],
                   [sg.Text('Left border character', size=(30, 1)), sg.InputText('|', size=(1, 1), key='left_border')],
                   [sg.Text('Right border character', size=(30, 1)), sg.InputText('|', size=(1, 1), key='right_border')],
                   [sg.Text('Top border character', size=(30, 1)), sg.InputText('#', size=(1, 1), key ='top_border')],
                   [sg.Text('Bottom border character', size=(30, 1)), sg.InputText('=', size=(1, 1), key='bottom_border')],
                   [sg.Text('Header separator character', size=(30, 1)), sg.InputText('#', size=(1, 1), key='header')],
                   [sg.Text('Row separator character', size=(30, 1)), sg.InputText('-', size=(1, 1), key='row')],
                   [sg.Text('Intersection character', size=(30, 1)), sg.InputText('+', size=(1, 1), key='intersection')],
                   [sg.Text('Column separator character', size=(30, 1)), sg.InputText(':', size=(1, 1), key='column')],
                   [sg.Text('Table Width', size=(15, 1), ),
                    sg.Spin(values=[i for i in range(1, 500)], initial_value=100, size=(3, 1), key='width'),
                    sg.Text('Cell Padding', size=(18, 1)),
                    sg.Spin(values=[i for i in range(1, 10)], initial_value=2, size=(2, 1), key='padding')],
                   [sg.Text('_' * 80)],
                   [sg.Text('CSV to open')],
                   [sg.In(key='source'), sg.FileBrowse()],
                   [sg.Open(), sg.Cancel()]])

EVENT, VALUES = WINDOW.read()
print(VALUES)
FNAME = VALUES['source']
LEFT_BORDER = VALUES['left_border']
RIGHT_BORDER = VALUES['right_border']
TOP_BORDER = VALUES['top_border']
BOTTOM_BORDER = VALUES['bottom_border']
HEADER = VALUES['header']
ROW = VALUES['row']
INTERSECTION = VALUES['intersection']
COLUMN = VALUES['column']
WIDTH = VALUES['width']
PADDING = VALUES['padding']

    # else:
    #     FNAME = sys.argv[1]
if not FNAME:
    sg.popup("Cancel", "No filename supplied")
    raise SystemExit("Cancelling: no filename supplied")
    # else:
    # sg.popup('The filename you chose was', fname)

# else:
#     FNAME = sys.argv[1]

if not FNAME:
    sg.popup("Cancel", "No filename supplied")
    raise SystemExit("Cancelling: no filename supplied")
else:

    print(FNAME)


def read_success():
    print(" **** SUCCESS: INPUT FILE EXISTS AND IS READABLE, CONTINUING. ****")


def read_error():
    print(" **** ERROR: INPUT FILE IS MISSING OR NOT READABLE, EXITING. ****")
    exit(2)


def style_custom():
    # my_table.left_border_char = LEFT_BORDER
    # my_table.right_border_char = RIGHT_BORDER
    # my_table.top_border_char = TOP_BORDER
    # my_table.bottom_border_char = BOTTOM_BORDER
    # my_table.header_separator_char = HEADER
    # my_table.row_separator_char = ROW
    # my_table.intersection_char = INTERSECTION
    # my_table.column_separator_char = COLUMN

    my_table.border.left = LEFT_BORDER
    my_table.border.right = RIGHT_BORDER
    my_table.border.top = TOP_BORDER
    my_table.border.bottom = BOTTOM_BORDER


def error_file():
    pass


try:
    # CHECK IF FILE EXISTS
    if os.path.isfile(FNAME) and os.access(FNAME, os.R_OK):
        read_success()
        # CREATE TABLE
        my_dataframe = pandas.read_csv(FNAME, skip_blank_lines=True)
        headers = list(my_dataframe)
        lists = my_dataframe.values.tolist()
        my_table = beautifultable.BeautifulTable(maxwidth=WIDTH, default_padding=PADDING, )
        my_table.column_headers = headers
        # WRITE TO TABLE
        for item in lists:
            #my_table.append_row(item)
            my_table.rows.append(item)
        # OUTPUT RESULTS
        style_custom()
        # PRINT OUTPUT TO TERMINAL
        print(my_table)
        # CREATE NEW NAME FOR OUTPUT FILE
        FNAME = FNAME.split(".")[0]
        filename = f"{FNAME}.txt"
        # WRITE TO NEW FILE
        with open(filename, 'w') as f:
            print(my_table, file=f)
            f.close()

        exit(0)
    else:
        exit(0)
        read_error()
except IndexError:
    error_file()
