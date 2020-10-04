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
import os
import os.path
import sys
import beautifultable
import pandas
import PySimpleGUI as sg

if len(sys.argv) == 1:

    if len(sys.argv) == 1:
        fname = sg.Window('CSV to ASCII',
                          [[sg.Text('This will convert CSV to fixed width ASCII text file')],
                           [sg.Text('_' * 80)],
                           [sg.Text('Left border character', size=(30, 1)), sg.InputText('|', size=(1, 1))],
                           [sg.Text('Right border character', size=(30, 1)), sg.InputText('|', size=(1, 1))],
                           [sg.Text('Top border character', size=(30, 1)), sg.InputText('#', size=(1, 1))],
                           [sg.Text('Bottom border character', size=(30, 1)), sg.InputText('=', size=(1, 1))],
                           [sg.Text('Header separator character', size=(30, 1)), sg.InputText('#', size=(1, 1))],
                           [sg.Text('Row separator character', size=(30, 1)), sg.InputText('-', size=(1, 1))],
                           [sg.Text('Intersection character', size=(30, 1)), sg.InputText('+', size=(1, 1))],
                           [sg.Text('Column separator character', size=(30, 1)), sg.InputText(':', size=(1, 1))],
                           [sg.Text('Table Width', size=(15, 1)),
                            sg.Spin(values=[i for i in range(1, 500)], initial_value=100, size=(3, 1)),
                            sg.Text('Cell Padding', size=(18, 1)),
                            sg.Spin(values=[i for i in range(1, 10)], initial_value=2, size=(2, 1))],
                           [sg.Text('_' * 80)],
                           [sg.Text('CSV to open')],
                           [sg.In(), sg.FileBrowse()],
                           [sg.Open(), sg.Cancel()]]).read(close=True)[1][0]
    else:
        fname = sys.argv[1]

    if not fname:
        sg.popup("Cancel", "No filename supplied")
        raise SystemExit("Cancelling: no filename supplied")
    #else:
        #sg.popup('The filename you chose was', fname)

else:
    fname = sys.argv[1]

if not fname:
    sg.popup("Cancel", "No filename supplied")
    raise SystemExit("Cancelling: no filename supplied")
else:

    print(fname)


def read_success():
    print(" **** SUCCESS: INPUT FILE EXISTS AND IS READABLE, CONTINUING. ****")


def read_error():
    print(" **** ERROR: INPUT FILE IS MISSING OR NOT READABLE, EXITING. ****")
    exit(2)



def style_custom():
    my_table.left_border_char = '|'
    my_table.right_border_char = '|'
    my_table.top_border_char = '#'
    my_table.bottom_border_char = '= '
    my_table.header_separator_char = '#'
    my_table.row_separator_char = '- '
    my_table.intersection_char = '+'
    my_table.column_separator_char = ':'


def error_file():
    pass


try:
    # CHECK IF FILE EXISTS
    if os.path.isfile(fname) and os.access(fname, os.R_OK):
        read_success()
        # CREATE TABLE
        my_dataframe = pandas.read_csv(fname, skip_blank_lines=True)
        headers = list(my_dataframe)
        lists = my_dataframe.values.tolist()
        my_table = beautifultable.BeautifulTable(max_width=100, default_padding=2)
        my_table.column_headers = headers
        # WRITE TO TABLE
        for item in lists:
            my_table.append_row(item)
        # OUTPUT RESULTS
        style_custom()
        #PRINT OUTPUT TO TERMINAL
        print(my_table)
        #CREATE NEW NAME FOR OUTPUT FILE
        filename = "%s.txt" % fname
        print(filename)

        #WRITE TO NEW FILE
        with open(filename, 'w') as f:
            print(my_table, file=f)
            f.close()

        exit(0)
    else:
        exit(0)
        read_error()
except IndexError:
    error_file()
