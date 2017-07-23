## from_stringがない
- read_csvでCSV読み込むのめんどうなとき
- copyした内容で作りたい
- というよりは、Rにもあるからpandasにもあると思ったらなかった
- from_csvはあったので、StringIOで包んでしまえ
- つくったあとに、read_csvでよいことに気づく
- documentにのってたのでmemoに降格…(http://pandas.pydata.org/pandas-docs/stable/io.html#csv-text-files)

```py3:read_and_from_csv.py
import pandas as pd
import io

_csv = """a,b,c
1,2,3
4,5,6
"""

pd.read_csv(io.StringIO(_csv))

# from stringつくった
# from_csvはIndexの読み込みがめんどうだった
# 以下、無視して問題なし

def from_string(_csv, **kwargs):
    # http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.from_csv.html
    return pd.DataFrame.from_csv(io.StringIO(_csv), **kwargs)

from_string(_csv)
from_string(_csv, index_col=None)
from_string(_csv[1:])

	b	c
a		
1	2	3
4	5	6
#################
	a	b	c
0	1	2	3
1	4	5	6
#################
	b	c
1	2	3
4	5	6
```

## copyするのめんどうならclipboardから
- これもfrom_はないが、read_, to_ が存在した
- https://github.com/pydata/pandas/blob/master/pandas/util/clipboard.py
- https://github.com/pydata/pandas/blob/master/pandas/util/clipboard.py#L1　に `# Pyperclip v1.5.15` と書かれている
- https://github.com/pydata/pandas/commit/a7d069dc2dbf451e5286cfca3497fa03c77dc900 からPyperclipのコードを使っているっぽい

### なんでこんなに調べたか
- read_ の存在に気づかず、to_しかないのかよーとPyperclipを使ったコードを作成していた…
- http://qiita.com/ksomemo/items/381191fa95992d81be90#python%E3%81%A7clipboard%E6%93%8D%E4%BD%9C

```py3:from_clipboad.py
import pyperclip


def from_clipboad(**kwargs):
    return from_string(pyperclip.paste(), **kwargs)

pyperclip.copy(_csv)
from_clipboad(index_col=None)
```
