#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pandas
import beautifultable

#infile = "/home/michal/Documents/Projects/Scripting/TableGenerator/input/Book2.csv"
infile = "/home/michal/Documents/Projects/Scripting/TableGenerator/input/ANSI.csv"
my_dataframe = pandas.read_csv(infile, skip_blank_lines=True)

headers = list(my_dataframe)
lists = my_dataframe.values.tolist()
my_table = beautifultable.BeautifulTable()
my_table.column_headers = headers

for item in lists:
    my_table.append_row(item)
    
print(my_table)

#outfile_html = "/home/michal/Documents/Projects/Scripting/TableGenerator/output/Book2.html"
#outfile = "/home/michal/Documents/Projects/Scripting/TableGenerator/output/Book2.txt"
#print(my_dataframe)
#pandas.DataFrame.to_string(outfile)
#encoding="ISO-8859-1"
