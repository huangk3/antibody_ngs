#!/usr/bin/env python3

import pandas as pd
import sys, os
from openpyxl.utils.dataframe import dataframe_to_rows
from openpyxl import Workbook

wb = Workbook()
ws = wb.active

input_file=sys.argv[1]
origin_name=os.path.splitext(input_file)[0]

df = pd.read_csv(input_file, header=0, sep="\t")

for r in dataframe_to_rows(df, index=False, header=True):
    ws.append(r)

wb.save(origin_name+".xlsx")

