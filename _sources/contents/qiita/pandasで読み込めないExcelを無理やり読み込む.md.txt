# pandasで読み込めないExcelを無理やり読み込む
openpyxlを利用して読み込む

```py3
import openpyxl
import pandas as pd


def read_from_excel(xls_path, sheet_name="Sheet1"):
    wb = openpyxl.load_workbook(mpx_xlsm_path)
    ws = wb.get_sheet_by_name(sheet_name)

    def column_values(column, start_row_num, end_row_num):
        cell_range = ws[column + str(start_row_num):column + str(end_row_num)]
        return (cell.value for (cell,) in cell_range)

    df = pd.DataFrame()
    df["A"] = column_values("A", 3, 10)
    df["B"] = column_values("B", 5, 12)

    return df
```
