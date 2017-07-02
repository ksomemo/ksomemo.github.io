
```1_python_handle_byte_str_io.md
- byte/strの変換をよく忘れているのでメモ
- ioよくわかってなかったけど、なんとなくわかった
- pandas.read_csv(handle) を覚えた
- 0.17.1ならgzip可能なので気にしなくて良い
```

```py3:example.py
import gzip
import io
import pandas as pd


gz_file = "ababa.gz"
with gzip.open(gz_file) as g:
    byte_content = g.read()
    text_content = byte_content.decode()
    strio = io.StringIO(text_content)
    print(byte_content)
    print(text_content)
    print(g)
    print(strio)
    df = pd.read_csv(strio)
    print(df)

with gzip.open(gz_file, "rt") as g:
    text_content = g.read()
    print(text_content)
    print(g)

with gzip.open(gz_file, "rt") as g:
    df = pd.read_csv(g)
    print(df)

"""
b'ababa\n'
ababa

<gzip _io.BufferedReader name='ababa.gz' 0x106caef98>
<_io.StringIO object at 0x106c56798>
Empty DataFrame
Columns: [ababa]
Index: []
ababa

<_io.TextIOWrapper name='ababa.gz' encoding='UTF-8'>
Empty DataFrame
Columns: [ababa]
Index: []
"""
```
