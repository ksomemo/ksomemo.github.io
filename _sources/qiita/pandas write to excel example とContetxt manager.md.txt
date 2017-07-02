## to excel
```py3:pandas_excel_example.py
import pandas as pd
import numpy as np


writer = pd.ExcelWriter("excel_file_path.xlsx")

df = pd.DataFrame(np.random.randn(50, 2), columns=list('ab'))
df.to_excel(writer, sheet_name="sheet_name1", index=False)
df.to_excel(writer, sheet_name="sheet_name2", index=False)

writer.save()
```

‐ 使うだけならここまででよかったんだけど
- ioが絡むのになんでcontext managerが一切出てこないのかな？と思い調べてみた。
- 結果withと一緒に使えるので、使おう。勝手にsaveされるようにもなる

```py3:pandas_excel_cm_example.py
with pd.ExcelWriter("excel_file_path.xlsx") as witer:
    df.to_excel(writer, sheet_name="sheet_name1", index=False)
    df.to_excel(writer, sheet_name="sheet_name2", index=False)
```


以下調査過程

## enter and exit
```py3:pandas_excel_enter_exit.py
help(writer.__exit__)
Help on method __exit__ in module pandas.io.excel:
__exit__(exc_type, exc_value, traceback) method of pandas.io.excel._XlsxWriter instance


help(writer.__enter__)
Help on method __enter__ in module pandas.io.excel:
__enter__() method of pandas.io.excel._XlsxWriter instance
    # Allow use as a contextmanager


[a for a in dir(writer) if not a.startswith('_')]
['book',
 'check_extension',
 'close',
 'cur_sheet',
 'curr_sheet',
 'date_format',
 'datetime_format',
 'engine',
 'path',
 'save',
 'sheets',
 'supported_extensions',
 'write_cells']
```

## pandas excel module and base excel module
- 抜粋
- 抽象クラスとxlsx実装クラスがある
- 抽象クラス内でcontext managerとしてのInterfaceが決めてある
- 実装クラス内でsave実装
- 実際はimportしているmoduleにまかせている
- 最終的にはzipファイルcloseしているが、ここではwithがない…

```py3:pandas_excel_module_and_base_excel_module.py
# pandas/io/excel.py
@add_metaclass(abc.ABCMeta)
class ExcelWriter(object):
    @abc.abstractmethod
    def save(self):
        pass

    # Allow use as a contextmanager
    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()
    
    def close(self):
        """synonym for save, to make it more file-like"""
        return self.save()

class _XlsxWriter(ExcelWriter):
    def __init__(self, ):
        # Use the xlsxwriter module as the Excel writer.
        import xlsxwriter
        # https://pypi.python.org/pypi/XlsxWriter
        # https://github.com/jmcnamara/XlsxWriter

        super(_XlsxWriter, self).__init__
        self.book = xlsxwriter.Workbook(path, **engine_kwargs)

    def save(self):
        """
        Save workbook to disk.
        """
        return self.book.close()

# xlsxwriter/__init__.py
from .workbook import Workbook

# xlsxwriter/workbook.py
class Workbook(xmlwriter.XMLwriter):
    def __enter__(self):
        """Return self object to use with "with" statement."""
        return self

    def __exit__(self, type, value, traceback):
        """Close workbook when exiting "with" statement."""
        self.close()
        
    def close(self):
        """
        Call finalization code and close file.
        Args:
            None.
        Returns:
            Nothing.
        """
        if not self.fileclosed:
            self.fileclosed = 1
            self._store_workbook()
            
    def _store_workbook(self):
        xlsx_file = ZipFile(self.filename, "w", compression=ZIP_DEFLATED,
                            allowZip64=self.allow_zip64)
        xlsx_file.close()
```
