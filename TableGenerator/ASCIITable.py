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

import PySimpleGUI as sg
import beautifultable
import pandas

WINDOW = sg.Window('CSV to ASCII',
                   [[sg.Text('This will convert CSV to fixed width ASCII text file. UTF-8 encoded CSV file works best.')],
                    [sg.Text('_' * 80)],
                    [sg.Text('Left border character', size=(30, 1)), sg.InputText('|', size=(1, 1), key='left_border')],
                    [sg.Text('Right border character', size=(30, 1)),
                     sg.InputText('|', size=(1, 1), key='right_border')],
                    [sg.Text('Top border character(s)', size=(30, 1)), sg.InputText('#', size=(3, 1), key='top_border')],
                    [sg.Text('Bottom border character(s)', size=(30, 1)),
                     sg.InputText('=', size=(3, 1), key='bottom_border')],
                    [sg.Text('Bottom intersection character', size=(30, 1)),
                     sg.InputText('=', size=(1, 1), key='bottom_x')],
                    [sg.Text('Bottom left character', size=(30, 1)), sg.InputText('=', size=(1, 1), key='bottom_l')],
                    [sg.Text('Bottom right character', size=(30, 1)), sg.InputText('=', size=(1, 1), key='bottom_r')],
                    [sg.Text('Top intersection character', size=(30, 1)), sg.InputText('=', size=(1, 1), key='top_x')],
                    [sg.Text('Top left character', size=(30, 1)), sg.InputText('=', size=(1, 1), key='top_l')],
                    [sg.Text('Top right character', size=(30, 1)), sg.InputText('=', size=(1, 1), key='top_r')],
                    [sg.Text('Header separator character(s)', size=(30, 1)), sg.InputText('#', size=(3, 1), key='header')],
                    [sg.Text('Row separator character(s)', size=(30, 1)), sg.InputText('-', size=(3, 1), key='row')],
                    [sg.Text('Intersection character', size=(30, 1)),
                     sg.InputText('+', size=(1, 1), key='intersection')],
                    [sg.Text('Left header character', size=(30, 1)), sg.InputText('+', size=(1, 1), key='header_l')],
                    [sg.Text('Right header character', size=(30, 1)), sg.InputText('+', size=(1, 1), key='header_r')],
                    [sg.Text('Left intersection character', size=(30, 1)),
                     sg.InputText('+', size=(1, 1), key='left_x')],
                    [sg.Text('Right intersection character', size=(30, 1)),
                     sg.InputText('+', size=(1, 1), key='right_x')],
                    [sg.Text('Column separator character', size=(30, 1)), sg.InputText(':', size=(1, 1), key='column')],
                    [sg.Text('Table Width', size=(15, 1), ),
                     sg.Spin(values=[i for i in range(1, 500)], initial_value=100, size=(3, 1), key='width'),
                     sg.Text('Cell Padding', size=(18, 1)),
                     sg.Spin(values=[i for i in range(1, 10)], initial_value=2, size=(2, 1), key='padding')],
                    [sg.Text('_' * 80)],
                    [sg.Text('CSV to convert. OUTPUT file will be placed in the same folder as INPUT file and renamed as TXT file.')],
                    [sg.In(key='source'), sg.FileBrowse()],
                    [sg.Open(), sg.Cancel()]])

EVENT, VALUES = WINDOW.read()
print(VALUES)
# DECLARE VARIABLES
FNAME = VALUES['source']
LEFT_BORDER = VALUES['left_border']
RIGHT_BORDER = VALUES['right_border']
TOP_BORDER = VALUES['top_border']
BOTTOM_BORDER = VALUES['bottom_border']
BOTTOM_X = VALUES['bottom_x']
BOTTOM_L = VALUES['bottom_l']
BOTTOM_R = VALUES['bottom_r']
TOP_X = VALUES['top_x']
TOP_L = VALUES['top_l']
TOP_R = VALUES['top_r']
HEADER = VALUES['header']
ROW = VALUES['row']
INTERSECTION = VALUES['intersection']
HEADER_L = VALUES['header_l']
HEADER_R = VALUES['header_r']
LEFT_X = VALUES['left_x']
RIGHT_X = VALUES['right_x']
COLUMN = VALUES['column']
WIDTH = VALUES['width']
PADDING = VALUES['padding']


# ERROR HANDLING, NO FILE SELECTED POPUP WINDOW
if not FNAME:
    sg.popup("Conversion canceled", "No filename supplied")
    raise SystemExit("Cancelling: no filename supplied")

else:

    print(FNAME)


def read_success():
    print(" **** SUCCESS: INPUT FILE EXISTS AND IS READABLE, CONTINUING. ****")


def read_error():
    print(" **** ERROR: INPUT FILE IS MISSING OR NOT READABLE, EXITING. ****")
    exit(2)


def style_custom():
    my_table.border.left = LEFT_BORDER
    my_table.border.right = RIGHT_BORDER
    my_table.border.bottom = BOTTOM_BORDER
    my_table.border.bottom_junction = BOTTOM_X
    my_table.border.bottom_left = BOTTOM_L
    my_table.border.bottom_right = BOTTOM_R
    my_table.border.top = TOP_BORDER
    my_table.border.top_junction = TOP_X
    my_table.border.top_left = TOP_L
    my_table.border.top_right = TOP_R
    my_table.border.header_left = HEADER_L
    my_table.border.header_right = HEADER_R
    my_table.border.left_junction = LEFT_X
    my_table.border.right_junction = RIGHT_X
    #my_table.BTColumnCollection.default_alignment =

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
        my_table = beautifultable.BeautifulTable(maxwidth=WIDTH, default_padding=PADDING, headers=headers, default_alignment = beautifultable.ALIGN_LEFT )
        # WRITE TO TABLE
        for item in lists:
            # my_table.append_row(item)
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
